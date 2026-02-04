import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../services/prisma.service';
import Stripe from 'stripe';
import { PlanTier } from '@prisma/client';

@Injectable()
export class BillingService {
  private stripe: Stripe;

  constructor(private readonly prisma: PrismaService) {
    this.stripe = new Stripe(process.env.STRIPE_SECRET_KEY ?? '', {
      apiVersion: '2024-06-20',
    });
  }

  async createStripeCheckoutSession(params: {
    userId: string;
    priceId: string;
    successUrl: string;
    cancelUrl: string;
    mode: 'subscription' | 'payment';
  }) {
    const session = await this.stripe.checkout.sessions.create({
      mode: params.mode,
      line_items: [{ price: params.priceId, quantity: 1 }],
      success_url: params.successUrl,
      cancel_url: params.cancelUrl,
      client_reference_id: params.userId,
    });
    return { url: session.url };
  }

  async registerSubscription(params: {
    userId: string;
    tier: PlanTier;
    providerRef: string;
    status: string;
    periodEnd: Date;
  }) {
    return this.prisma.subscription.create({
      data: {
        userId: params.userId,
        tier: params.tier,
        provider: 'STRIPE',
        providerRef: params.providerRef,
        status: params.status,
        currentPeriodEnd: params.periodEnd,
      },
    });
  }

  async registerGooglePlayReceipt(params: {
    userId: string;
    tier: PlanTier;
    receipt: string;
  }) {
    return this.prisma.subscription.create({
      data: {
        userId: params.userId,
        tier: params.tier,
        provider: 'GOOGLE_PLAY',
        providerRef: params.receipt,
        status: 'active',
        currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      },
    });
  }
}
