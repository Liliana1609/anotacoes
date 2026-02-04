import 'package:flutter/material.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exportar currículo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Escolha o formato', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('PDF'),
                subtitle: const Text('Baixar em PDF com qualidade alta'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Baixar'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('DOCX'),
                subtitle: const Text('Baixar em Word editável'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Baixar'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Histórico de downloads'),
            const SizedBox(height: 8),
            const Text('Nenhum download registrado ainda.'),
          ],
        ),
      ),
    );
  }
}
