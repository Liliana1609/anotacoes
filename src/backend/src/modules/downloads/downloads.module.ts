import { Module } from '@nestjs/common';
import { DownloadsController } from './downloads.controller';
import { DownloadsService } from './downloads.service';
import { PrismaService } from '../../services/prisma.service';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule],
  controllers: [DownloadsController],
  providers: [DownloadsService, PrismaService],
})
export class DownloadsModule {}
