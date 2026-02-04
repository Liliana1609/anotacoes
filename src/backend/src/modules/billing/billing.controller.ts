import { Body, Controller, Post, UseGuards, Req } from '@nestjs/common';
import { BillingService } from './billing.service';
import { FirebaseAuthGuard } from '../auth/firebase-auth.guard';
import { PlanTier } from '@prisma/client';

@Controller('billing')
@UseGuards(FirebaseAuthGuard)
export class BillingController {
  constructor(private readonly billingService: BillingService) {}

  @Post('stripe/checkout')
  async stripeCheckout(
    @Req() req: { user: { uid: string } },
    @Body()
    body: { priceId: string; successUrl: string; cancelUrl: string; mode: 'subscription' | 'payment' },
  ) {
    return this.billingService.createStripeCheckoutSession({
      userId: req.user.uid,
      priceId: body.priceId,
      successUrl: body.successUrl,
      cancelUrl: body.cancelUrl,
      mode: body.mode,
    });
  }

  @Post('stripe/subscribe')
  async registerStripeSub(
    @Req() req: { user: { uid: string } },
    @Body() body: { tier: PlanTier; providerRef: string; status: string; periodEnd: string },
  ) {
    return this.billingService.registerSubscription({
      userId: req.user.uid,
      tier: body.tier,
      providerRef: body.providerRef,
      status: body.status,
      periodEnd: new Date(body.periodEnd),
    });
  }

  @Post('google-play/receipt')
  async googlePlayReceipt(
    @Req() req: { user: { uid: string } },
    @Body() body: { tier: PlanTier; receipt: string },
  ) {
    return this.billingService.registerGooglePlayReceipt({
      userId: req.user.uid,
      tier: body.tier,
      receipt: body.receipt,
    });
  }
}
