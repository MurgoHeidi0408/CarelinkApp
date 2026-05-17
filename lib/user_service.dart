import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final usuarios =
      FirebaseFirestore.instance
          .collection('users');

  //
  // 🔥 GUARDAR USUARIO
  //

  Future<void> guardarUsuario({

    required String uid,

    required String nombre,

    required String email,

  }) async {

    await usuarios.doc(uid).set({

      'uid': uid,

      'nombre': nombre,

      'email': email,

      'photoUrl': '',

      'bio': '',

      'ciudad': '',
    });
  }

  //
  // 🔥 OBTENER USUARIO
  //

  Stream<DocumentSnapshot> obtenerUsuario(
      String uid,
      ) {

    return usuarios.doc(uid).snapshots();
  }

  //
  // 🔥 ACTUALIZAR USUARIO
  //

  Future<void> actualizarUsuario({

    required String uid,

    required String nombre,

    required String bio,

    required String ciudad,

    required String photoUrl,

  }) async {

    await usuarios.doc(uid).set({

      'nombre': nombre,
      'bio': bio,
      'ciudad': ciudad,
      'photoUrl': photoUrl,

    }, SetOptions(merge: true));
  }
}