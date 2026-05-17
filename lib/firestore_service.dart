import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  //
  // 🔥 CREAR POST (CORREGIDO)
  //

  Future<void> crearPost({
    required String nombre,
    required String mensaje,
    required String categoria,
    required String ubicacion,
    String imageUrl = "",
  }) async {

    final user = FirebaseAuth.instance.currentUser;

    await firestore.collection('posts').add({

      'nombre': nombre,
      'mensaje': mensaje,
      'categoria': categoria,
      'ubicacion': ubicacion,
      'imageUrl': imageUrl,

      'likes': 0,

      'userId': user!.uid, // 🔥 CLAVE (ESTO TE FALTABA)

      'fecha': FieldValue.serverTimestamp(),
    });
  }

  //
  // 🔥 DAR LIKE (MEJORADO)
  //

  Future<void> darLike(String postId) async {

    await firestore
        .collection('posts')
        .doc(postId)
        .update({

      'likes': FieldValue.increment(1),
    });
  }
}