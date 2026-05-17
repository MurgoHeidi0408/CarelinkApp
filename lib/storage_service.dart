import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  final FirebaseStorage storage =
      FirebaseStorage.instance;

  //
  // 🔥 SUBIR IMAGEN
  //

  Future<String> subirImagen(
      Uint8List imageBytes) async {

    try {

      //
      // 🔥 NOMBRE ÚNICO
      //

      String fileName =
          DateTime.now()
              .millisecondsSinceEpoch
              .toString();

      //
      // 🔥 REFERENCIA
      //

      Reference ref = storage
          .ref()
          .child("posts")
          .child("$fileName.jpg");

      //
      // 🔥 SUBIR ARCHIVO
      //

      UploadTask uploadTask =
          ref.putData(imageBytes);

      //
      // 🔥 ESPERAR
      //

      TaskSnapshot snapshot =
          await uploadTask;

      //
      // 🔥 URL
      //

      String downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
          "Error al subir imagen: $e");
    }
  }
}