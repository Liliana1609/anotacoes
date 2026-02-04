import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from './auth.service';

@Injectable()
export class FirebaseAuthGuard implements CanActivate {
  constructor(private readonly authService: AuthService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const authHeader: string = request.headers['authorization'];
    if (!authHeader) {
      throw new UnauthorizedException('Token ausente');
    }
    const token = authHeader.replace('Bearer ', '');
    const payload = await this.authService.validateToken(token);
    request.user = payload;
    return true;
  }
}
