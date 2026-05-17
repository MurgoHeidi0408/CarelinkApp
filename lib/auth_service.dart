import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class AuthService {

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  //
  // 🔥 REGISTRAR USUARIO
  //

  Future<UserCredential>
  registrarUsuario({

    required String nombre,

    required String email,

    required String password,
  }) async {

    //
    // 🔥 CREAR CUENTA
    //

    UserCredential userCredential =

    await auth
        .createUserWithEmailAndPassword(

      email: email,

      password: password,
    );

    //
    // 🔥 GUARDAR NOMBRE EN FIREBASE AUTH
    //

    await userCredential.user!
        .updateDisplayName(
      nombre,
    );

    //
    // 🔥 GUARDAR EN FIRESTORE
    //

    await UserService()
        .guardarUsuario(

      uid:
      userCredential.user!.uid,

      nombre: nombre,

      email: email,
    );

    return userCredential;
  }

  //
  // 🔥 LOGIN
  //

  Future<UserCredential>
  iniciarSesion({

    required String email,

    required String password,
  }) async {

    return await auth
        .signInWithEmailAndPassword(

      email: email,

      password: password,
    );
  }

  //
  // 🔥 LOGOUT
  //

  Future<void> cerrarSesion()
  async {

    await auth.signOut();
  }

  //
  // 🔥 USUARIO ACTUAL
  //

  User? usuarioActual() {

    return auth.currentUser;
  }
}