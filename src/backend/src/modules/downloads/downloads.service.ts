import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from '../../services/prisma.service';
import { ExportFormat, PlanTier } from '@prisma/client';

const PLAN_LIMITS: Record<PlanTier, { downloads: number; photo: number; languages: number }> = {
  FREE: { downloads: 1, photo: 0, languages: 1 },
  BASIC: { downloads: 1, photo: 1, languages: 1 },
  PLUS: { downloads: 5, photo: 5, languages: 3 },
  PREMIUM: { downloads: 50, photo: 50, languages: 10 },
};

@Injectable()
export class DownloadsService {
  constructor(private readonly prisma: PrismaService) {}

  async getActiveTier(userId: string): Promise<PlanTier> {
    const subscription = await this.prisma.subscription.findFirst({
      where: { userId, status: 'active' },
      orderBy: { currentPeriodEnd: 'desc' },
    });
    return subscription?.tier ?? PlanTier.FREE;
  }

  async ensureDownloadAvailable(userId: string) {
    const tier = await this.getActiveTier(userId);
    const limit = PLAN_LIMITS[tier].downloads;
    const startOfMonth = new Date();
    startOfMonth.setDate(1);
    startOfMonth.setHours(0, 0, 0, 0);
    const used = await this.prisma.download.count({
      where: { userId, createdAt: { gte: startOfMonth } },
    });
    if (used >= limit) {
      throw new ForbiddenException('Limite de downloads atingido');
    }
  }

  async registerDownload(params: {
    userId: string;
    resumeId: string;
    format: ExportFormat;
    storageUrl: string;
  }) {
    await this.ensureDownloadAvailable(params.userId);
    return this.prisma.download.create({ data: params });
  }

  history(userId: string) {
    return this.prisma.download.findMany({ where: { userId }, orderBy: { createdAt: 'desc' } });
  }
}
