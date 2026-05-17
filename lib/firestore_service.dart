import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  //
  // 🔥 CREAR POST
  //

  Future<void> crearPost({

    required String nombre,

    required String mensaje,

    required String categoria,

    required String ubicacion,

    String imageUrl = "",
  }) async {

    await firestore
        .collection('posts')
        .add({

      'nombre': nombre,

      'mensaje': mensaje,

      'categoria': categoria,

      'ubicacion': ubicacion,

      'imageUrl': imageUrl,

      'likes': 0,

      'fecha': Timestamp.now(),
    });
  }

  //
  // 🔥 DAR LIKE
  //

  Future<void> darLike(
    String postId,
  ) async {

    await firestore
        .collection('posts')
        .doc(postId)
        .update({

      'likes':
      FieldValue.increment(1),
    });
  }
}