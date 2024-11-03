
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data/database.dart';

class ViewExercisesScreen extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  ViewExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Exercícios'),
        backgroundColor: const Color(0xFFFF003D), // Cor do AppBar
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseMethods.lerExercicios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum exercício cadastrado.', style: TextStyle(color: Colors.black)));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              bool isConcluido = data['concluido'] == true;

              return Container(
                color: isConcluido ? const Color(0xFFCCF390) : const Color(0xFFE0E05A), // Verde claro para exercícios concluídos, amarelo para exercícios pendentes
                child: ListTile(
                  title: Text(data['nome'], style: const TextStyle(color: Colors.black)), // Cor do texto
                  subtitle: Text(
                    'Sequência: ${data['sequencia']}, Repetições: ${data['repeticoes']}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isConcluido ? Icons.check_circle : Icons.circle,
                      color: isConcluido ? Colors.green : null,
                    ),
                    onPressed: () {
                      // Alterna o estado de concluído
                      final updatedData = {
                        'concluido': !isConcluido, // Alterna o valor do campo 'concluido'
                      };
                      databaseMethods.atualizarExercicio(doc.id, updatedData);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
