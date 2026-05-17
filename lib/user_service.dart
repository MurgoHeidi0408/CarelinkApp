import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> guardarUsuario({

    required String uid,

    required String nombre,

    required String email,
  }) async {

    await firestore
        .collection('users')
        .doc(uid)
        .set({

      'nombre': nombre,

      'email': email,

      'bio':
      'Miembro de Carelink',

      'ciudad':
      'México',

      'photoUrl': '',
    });
  }
}