import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Idiomas')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Português (Brasil)'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Inglês'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Espanhol'),
          ),
        ],
      ),
    );
  }
}
