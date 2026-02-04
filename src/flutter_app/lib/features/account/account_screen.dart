import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_controller.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gerenciar assinatura', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/plans'),
              child: const Text('Ver planos'),
            ),
            const Divider(height: 32),
            Text('Privacidade e LGPD', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Solicitar exclusão de dados'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authControllerProvider).signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
