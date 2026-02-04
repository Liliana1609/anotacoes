import { Body, Controller, Get, Post, Put, UseGuards, Req, Param } from '@nestjs/common';
import { ResumeService } from './resume.service';
import { FirebaseAuthGuard } from '../auth/firebase-auth.guard';

@Controller('resumes')
@UseGuards(FirebaseAuthGuard)
export class ResumeController {
  constructor(private readonly resumeService: ResumeService) {}

  @Get()
  async list(@Req() req: { user: { uid: string } }) {
    return this.resumeService.listByUser(req.user.uid);
  }

  @Post()
  async create(
    @Req() req: { user: { uid: string } },
    @Body() body: { title: string; summary?: string; content: any },
  ) {
    return this.resumeService.create(req.user.uid, body);
  }

  @Put(':id')
  async update(
    @Param('id') id: string,
    @Body() body: { title?: string; summary?: string; content?: any },
  ) {
    return this.resumeService.update(id, body);
  }
}
