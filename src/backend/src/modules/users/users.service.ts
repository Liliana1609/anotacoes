import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../services/prisma.service';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async getProfile(firebaseUid: string) {
    return this.prisma.user.findUnique({ where: { firebaseUid } });
  }

  async deleteAccount(firebaseUid: string) {
    return this.prisma.user.delete({ where: { firebaseUid } });
  }
}
