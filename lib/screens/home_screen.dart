import 'package:flutter/material.dart';
import 'view_exercises_screen.dart';
import 'edit/edit_existing_exercise_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFFFF003D), // Cor do AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewExercisesScreen()),
                );
              },
              child: const Text('Visualizar Exercícios'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditExistingExerciseScreen()),
                );
              },
              child: const Text('Editar Exercícios'),
            ),
          ],
        ),
      ),
    );
  }
}
