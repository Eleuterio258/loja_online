import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String nome;
  String password;
  String confPassword;
  String email;

  UserModel({
    this.id,
    this.nome,
    this.password,
    this.confPassword,
    this.email,
  });

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  UserModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nome = document.data()['nome'] as String;
    email = document.data()['email'] as String;
  }

  Future<void> saveData() async {
    await FirebaseFirestore.instance.collection("users").doc(id).set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'email': email};
  }
}
