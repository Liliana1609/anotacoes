import { Controller, Post, Headers } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('session')
  async createSession(@Headers('authorization') auth: string) {
    const token = auth?.replace('Bearer ', '');
    const payload = await this.authService.validateToken(token);
    const user = await this.authService.syncUser({
      uid: payload.uid,
      email: payload.email,
      name: payload.name,
    });
    return { user };
  }
}
