import {
  Controller,
  Post,
  UseGuards,
  Req,
  UploadedFile,
  UseInterceptors,
  Body,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AiService } from './ai.service';
import { FirebaseAuthGuard } from '../auth/firebase-auth.guard';

@Controller('ai')
@UseGuards(FirebaseAuthGuard)
export class AiController {
  constructor(private readonly aiService: AiService) {}

  @Post('photo')
  @UseInterceptors(FileInterceptor('file'))
  async processPhoto(
    @Req() req: { user: { uid: string } },
    @UploadedFile() file: Express.Multer.File,
    @Body() body: { crop: '4:5' | '1:1' },
  ) {
    const result = await this.aiService.processPhoto({
      userId: req.user.uid,
      buffer: file.buffer,
      crop: body.crop ?? '4:5',
    });
    return {
      recordId: result.recordId,
      imageBase64: result.image.toString('base64'),
    };
  }

  @Post('text')
  async generateText(@Body() body: { prompt: string; locale: string; model?: string }) {
    return this.aiService.generateResumeText(body);
  }
}
