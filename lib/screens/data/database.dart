
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseMethods {
  final CollectionReference exercisesCollection = FirebaseFirestore.instance.collection('exercises');

  // Função para exibir um toast com feedback
  void mostrarToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Adicionar exercício
  Future<void> adicionarExercicio(Map<String, dynamic> exerciseData) async {
    try {
      await exercisesCollection.add(exerciseData);
      mostrarToast("Exercício adicionado com sucesso!");
    } catch (e) {
      mostrarToast("Erro ao adicionar exercício: $e");
    }
  }

  // Editar exercício
  Future<void> editarExercicio(String id, Map<String, dynamic> updatedData) async {
    try {
      await exercisesCollection.doc(id).update(updatedData);
      mostrarToast("Exercício atualizado com sucesso!");
    } catch (e) {
      mostrarToast("Erro ao atualizar exercício: $e");
    }
  }

  // Deletar exercício
  Future<void> deletarExercicio(String id) async {
    try {
      await exercisesCollection.doc(id).delete();
      mostrarToast("Exercício deletado com sucesso!");
    } catch (e) {
      mostrarToast("Erro ao deletar exercício: $e");
    }
  }

  // Ler exercícios (retorna stream de dados para exibição em tempo real)
  Stream<QuerySnapshot> lerExercicios() {
    return exercisesCollection.snapshots();
  }

  // Atualizar estado de um exercício (marcar como concluído)
  Future<void> atualizarExercicio(String id, Map<String, dynamic> updatedData) async {
    try {
      await exercisesCollection.doc(id).update(updatedData);
      mostrarToast("Estado do exercício atualizado com sucesso!");
    } catch (e) {
      mostrarToast("Erro ao atualizar estado do exercício: $e");
    }
  }
}
