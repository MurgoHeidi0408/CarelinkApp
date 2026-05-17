import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_screen.dart';
import 'navigation_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream:
      FirebaseAuth.instance
          .authStateChanges(),

      builder: (context, snapshot) {

        //
        // 🔥 LOADING
        //

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child:
              CircularProgressIndicator(),
            ),
          );
        }

        //
        // 🔥 SI HAY USUARIO
        //

        if (snapshot.hasData) {

          return const MainNavigationScreen();
        }

        //
        // 🔥 SI NO HAY USUARIO
        //

        return const AuthScreen();
      },
    );
  }
}