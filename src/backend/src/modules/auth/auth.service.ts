import { Injectable, UnauthorizedException } from '@nestjs/common';
import { FirebaseService } from '../../services/firebase.service';
import { PrismaService } from '../../services/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly firebase: FirebaseService,
    private readonly prisma: PrismaService,
  ) {}

  async validateToken(token: string) {
    try {
      return await this.firebase.verifyToken(token);
    } catch (error) {
      throw new UnauthorizedException('Token inválido');
    }
  }

  async syncUser(profile: { uid: string; email: string; name?: string }) {
    return this.prisma.user.upsert({
      where: { firebaseUid: profile.uid },
      update: { email: profile.email, displayName: profile.name },
      create: {
        firebaseUid: profile.uid,
        email: profile.email,
        displayName: profile.name,
      },
    });
  }
}
