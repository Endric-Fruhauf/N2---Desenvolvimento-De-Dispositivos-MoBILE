import 'package:flutter/material.dart';
import '../../data/database.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});
  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sequenciaController = TextEditingController();
  final TextEditingController repeticoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Exercício'),
        backgroundColor: const Color(0xFFFF003D), // Cor do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Exercício'),
            ),
            TextField(
              controller: sequenciaController,
              decoration: const InputDecoration(labelText: 'Sequência'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: repeticoesController,
              decoration: const InputDecoration(labelText: 'Repetições'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final Map<String, dynamic> exerciseData = {
                  'nome': nomeController.text,
                  'sequencia': int.parse(sequenciaController.text),
                  'repeticoes': int.parse(repeticoesController.text),
                };
                databaseMethods.adicionarExercicio(exerciseData);
                Navigator.pop(context); // Retorna à tela anterior após adicionar
              },
              child: const Text('Adicionar Exercício'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    sequenciaController.dispose();
    repeticoesController.dispose();
    super.dispose();
  }
}
