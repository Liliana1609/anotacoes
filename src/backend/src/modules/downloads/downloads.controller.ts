import { Body, Controller, Get, Post, UseGuards, Req } from '@nestjs/common';
import { DownloadsService } from './downloads.service';
import { FirebaseAuthGuard } from '../auth/firebase-auth.guard';
import { ExportFormat } from '@prisma/client';

@Controller('downloads')
@UseGuards(FirebaseAuthGuard)
export class DownloadsController {
  constructor(private readonly downloadsService: DownloadsService) {}

  @Get()
  async history(@Req() req: { user: { uid: string } }) {
    return this.downloadsService.history(req.user.uid);
  }

  @Post()
  async register(
    @Req() req: { user: { uid: string } },
    @Body() body: { resumeId: string; format: ExportFormat; storageUrl: string },
  ) {
    return this.downloadsService.registerDownload({
      userId: req.user.uid,
      resumeId: body.resumeId,
      format: body.format,
      storageUrl: body.storageUrl,
    });
  }
}
