import 'package:flutter/material.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Templates')),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 2,
        padding: const EdgeInsets.all(24),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: List.generate(
          4,
          (index) => Card(
            child: Center(
              child: Text('Template ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }
}
