import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { FirebaseService } from '../../services/firebase.service';
import { PrismaService } from '../../services/prisma.service';

@Module({
  controllers: [AuthController],
  providers: [AuthService, FirebaseService, PrismaService],
  exports: [AuthService],
})
export class AuthModule {}
