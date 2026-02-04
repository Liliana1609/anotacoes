import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { ResumeModule } from './resume/resume.module';
import { BillingModule } from './billing/billing.module';
import { AiModule } from './ai/ai.module';
import { DownloadsModule } from './downloads/downloads.module';
import { UsersModule } from './users/users.module';
import { PrismaService } from '../services/prisma.service';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    UsersModule,
    ResumeModule,
    BillingModule,
    AiModule,
    DownloadsModule,
  ],
  providers: [PrismaService],
})
export class AppModule {}
