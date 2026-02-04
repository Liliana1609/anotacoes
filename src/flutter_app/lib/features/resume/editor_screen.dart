import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int _currentStep = 0;

  void _next() {
    if (_currentStep < 2) {
      setState(() => _currentStep += 1);
    } else {
      context.go('/preview');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor de Currículo'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _next,
        onStepCancel: _currentStep == 0
            ? null
            : () => setState(() => _currentStep -= 1),
        steps: const [
          Step(
            title: Text('Dados pessoais'),
            content: _StepForm(
              hint: 'Nome, email, telefone, LinkedIn',
            ),
          ),
          Step(
            title: Text('Experiências'),
            content: _StepForm(
              hint: 'Adicione experiências e resultados.',
            ),
          ),
          Step(
            title: Text('Educação e habilidades'),
            content: _StepForm(
              hint: 'Cursos, idiomas, skills e certificações.',
            ),
          ),
        ],
      ),
    );
  }
}

class _StepForm extends StatelessWidget {
  const _StepForm({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 6,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
