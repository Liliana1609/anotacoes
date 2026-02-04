import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planos e pagamentos')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _PlanCard(
            title: 'Free',
            price: '1 download gratuito (PDF)',
            description: 'Apenas PT-BR',
          ),
          _PlanCard(
            title: 'Básico',
            price: 'R$ 9,99 por download',
            description: 'PDF ou DOCX + 1 foto processada',
          ),
          _PlanCard(
            title: 'Plus',
            price: 'R$ 14,99/mês',
            description: '5 downloads/mês + idiomas',
          ),
          _PlanCard(
            title: 'Premium',
            price: 'R$ 24,99/mês',
            description: 'Downloads ilimitados + carta de apresentação',
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.title, required this.price, required this.description});

  final String title;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(price),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text('Assinar')),
          ],
        ),
      ),
    );
  }
}
