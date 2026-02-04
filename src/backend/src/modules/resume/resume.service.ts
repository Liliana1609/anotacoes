import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../services/prisma.service';

@Injectable()
export class ResumeService {
  constructor(private readonly prisma: PrismaService) {}

  listByUser(userId: string) {
    return this.prisma.resume.findMany({ where: { userId }, orderBy: { updatedAt: 'desc' } });
  }

  create(userId: string, data: { title: string; summary?: string; content: any }) {
    return this.prisma.resume.create({
      data: {
        userId,
        title: data.title,
        summary: data.summary,
        content: data.content,
      },
    });
  }

  update(id: string, data: { title?: string; summary?: string; content?: any }) {
    return this.prisma.resume.update({ where: { id }, data });
  }
}
