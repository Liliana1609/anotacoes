import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAiScreen extends StatefulWidget {
  const PhotoAiScreen({super.key});

  @override
  State<PhotoAiScreen> createState() => _PhotoAiScreenState();
}

class _PhotoAiScreenState extends State<PhotoAiScreen> {
  XFile? _photo;

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final selected = await picker.pickImage(source: ImageSource.gallery);
    setState(() => _photo = selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foto profissional IA')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. Envie sua foto para processamento por IA.'),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickPhoto,
              icon: const Icon(Icons.upload),
              label: const Text('Selecionar foto'),
            ),
            const SizedBox(height: 16),
            if (_photo != null)
              Text('Arquivo selecionado: ${_photo!.name}'),
            const SizedBox(height: 24),
            const Text('2. Ajustes automáticos:'),
            const SizedBox(height: 8),
            const Text('• Detecção de rosto\n• Recorte 4:5 e 1:1\n• Correção de luz'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _photo == null ? null : () {},
              child: const Text('Processar foto'),
            ),
          ],
        ),
      ),
    );
  }
}
