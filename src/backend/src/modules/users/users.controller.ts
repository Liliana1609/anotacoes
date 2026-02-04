import { Controller, Get, Delete, UseGuards, Req } from '@nestjs/common';
import { UsersService } from './users.service';
import { FirebaseAuthGuard } from '../auth/firebase-auth.guard';

@Controller('users')
@UseGuards(FirebaseAuthGuard)
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('me')
  async me(@Req() req: { user: { uid: string } }) {
    return this.usersService.getProfile(req.user.uid);
  }

  @Delete('me')
  async delete(@Req() req: { user: { uid: string } }) {
    return this.usersService.deleteAccount(req.user.uid);
  }
}
