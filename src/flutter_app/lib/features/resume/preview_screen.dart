import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview do currículo'),
        actions: [
          IconButton(
            onPressed: () => context.go('/export'),
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preview em tempo real', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                const Text(
                  'O conteúdo será renderizado com base nos dados salvos do editor e nas versões por vaga.',
                ),
                const Divider(height: 32),
                const Text('• Selecione um currículo para visualizar.'),
                const Text('• O layout será aplicado conforme o template escolhido.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
