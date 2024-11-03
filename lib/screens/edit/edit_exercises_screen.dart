import 'package:flutter/material.dart';
import '../data/database.dart';

class EditExistingExerciseScreen extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  EditExistingExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Exercício Existente'),
        backgroundColor: const Color(0xFFFF003D), // Cor do AppBar
      ),
      body: StreamBuilder(
        stream: databaseMethods.lerExercicios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum exercício cadastrado.'));
          }

          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['nome']),
                subtitle: Text('Sequência: ${data['sequencia']}, Repetições: ${data['repeticoes']}'),
                onTap: () {
                  // Navega para uma tela onde o usuário pode editar este exercício específico
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditExerciseDetailScreen(
                        docId: doc.id,
                        currentData: data,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class EditExerciseDetailScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> currentData;

  const EditExerciseDetailScreen({
    super.key,
    required this.docId,
    required this.currentData,
  });

  @override
  _EditExerciseDetailScreenState createState() => _EditExerciseDetailScreenState();
}

class _EditExerciseDetailScreenState extends State<EditExerciseDetailScreen> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  late TextEditingController nomeController;
  late TextEditingController sequenciaController;
  late TextEditingController repeticoesController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.currentData['nome']);
    sequenciaController = TextEditingController(text: widget.currentData['sequencia'].toString());
    repeticoesController = TextEditingController(text: widget.currentData['repeticoes'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Exercício'),
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
                final Map<String, dynamic> updatedExercise = {
                  'nome': nomeController.text,
                  'sequencia': int.parse(sequenciaController.text),
                  'repeticoes': int.parse(repeticoesController.text),
                };
                databaseMethods.editarExercicio(widget.docId, updatedExercise);
                Navigator.pop(context); // Retorna à lista de exercícios após editar
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
