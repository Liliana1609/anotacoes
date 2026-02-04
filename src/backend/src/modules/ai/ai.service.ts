import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../services/prisma.service';
import sharp from 'sharp';

@Injectable()
export class AiService {
  constructor(private readonly prisma: PrismaService) {}

  async processPhoto(params: {
    userId: string;
    buffer: Buffer;
    crop: '4:5' | '1:1';
  }) {
    const image = sharp(params.buffer);
    const metadata = await image.metadata();
    const width = metadata.width ?? 0;
    const height = metadata.height ?? 0;

    const targetRatio = params.crop === '4:5' ? 4 / 5 : 1;
    let cropWidth = width;
    let cropHeight = Math.round(width / targetRatio);

    if (cropHeight > height) {
      cropHeight = height;
      cropWidth = Math.round(height * targetRatio);
    }

    const left = Math.round((width - cropWidth) / 2);
    const top = Math.round((height - cropHeight) / 2);

    const processed = await image
      .extract({ left, top, width: cropWidth, height: cropHeight })
      .modulate({ brightness: 1.05, saturation: 0.95 })
      .linear(1.05, -5)
      .png()
      .toBuffer();

    const record = await this.prisma.photoProcess.create({
      data: {
        userId: params.userId,
        inputUrl: 'pending',
        outputUrl: 'pending',
        status: 'processed',
      },
    });

    return { recordId: record.id, image: processed };
  }

  async generateResumeText(params: {
    prompt: string;
    locale: string;
    model?: string;
  }) {
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: params.model ?? 'gpt-4o-mini',
        messages: [
          { role: 'system', content: `Você é um gerador de currículos em ${params.locale}.` },
          { role: 'user', content: params.prompt },
        ],
        temperature: 0.4,
      }),
    });

    if (!response.ok) {
      throw new Error('Falha ao gerar texto de currículo');
    }

    const data = await response.json();
    return { content: data.choices?.[0]?.message?.content ?? '' };
  }
}
