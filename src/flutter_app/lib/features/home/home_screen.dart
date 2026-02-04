import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../resume/resume_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumesAsync = ref.watch(resumesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Currículos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.go('/account'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/editor'),
        label: const Text('Novo currículo'),
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: resumesAsync.when(
          data: (resumes) {
            if (resumes.isEmpty) {
              return const Center(child: Text('Nenhum currículo criado ainda.'));
            }
            return ListView.separated(
              itemCount: resumes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final resume = resumes[index];
                return Card(
                  child: ListTile(
                    title: Text(resume['title'] ?? 'Currículo'),
                    subtitle: Text('Atualizado em: ${resume['updatedAt'] ?? ''}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf),
                      onPressed: () => context.go('/export'),
                    ),
                    onTap: () => context.go('/preview'),
                  ),
                );
              },
            );
          },
          error: (error, _) => Center(child: Text('Erro: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Nome do App', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Templates'),
              onTap: () => context.go('/templates'),
            ),
            ListTile(
              title: const Text('Foto profissional IA'),
              onTap: () => context.go('/photo'),
            ),
            ListTile(
              title: const Text('Planos e pagamentos'),
              onTap: () => context.go('/plans'),
            ),
            ListTile(
              title: const Text('Idiomas'),
              onTap: () => context.go('/languages'),
            ),
          ],
        ),
      ),
    );
  }
}
