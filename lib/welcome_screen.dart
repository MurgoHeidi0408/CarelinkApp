import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  //
  // 🔥 CONTINUAR
  //

  Future<void> continuar(
      BuildContext context,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();

    //
    // 🔥 GUARDAR QUE YA VIO
    //

    await prefs.setBool(
      'yaVioBienvenida',
      true,
    );

    if (!context.mounted) return;

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const MainNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFFF8C42),
              Color(0xFFF5F5F5),
            ],
          ),
        ),

        child: SafeArea(

          child: Padding(

            padding:
            const EdgeInsets.all(30),

            child: Column(

              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                //
                // 🔥 ICONO
                //

                Container(

                  padding:
                  const EdgeInsets.all(28),

                  decoration:
                  BoxDecoration(

                    color: Colors.white,

                    shape: BoxShape.circle,

                    boxShadow: [

                      BoxShadow(

                        color: Colors.orange
                            .withOpacity(0.3),

                        blurRadius: 25,
                      ),
                    ],
                  ),

                  child: const Icon(

                    Icons.shield_rounded,

                    color:
                    Color(0xFFFF7A00),

                    size: 90,
                  ),
                ),

                const SizedBox(height: 40),

                //
                // 🔥 TITULO
                //

                const Text(

                  "Bienvenido a Carelink",

                  textAlign:
                  TextAlign.center,

                  style: TextStyle(

                    fontSize: 38,

                    fontWeight:
                    FontWeight.bold,

                    color:
                    Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 20),

                //
                // 🔥 TEXTO
                //

                const Text(

                  "Mantente conectado con tu comunidad y reporta emergencias en tiempo real.",

                  textAlign:
                  TextAlign.center,

                  style: TextStyle(

                    fontSize: 17,

                    color:
                    Color(0xFF64748B),

                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 50),

                //
                // 🔥 BOTON
                //

                SizedBox(

                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(

                    onPressed: () {

                      continuar(context);
                    },

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(
                        0xFFFF7A00,
                      ),

                      elevation: 8,

                      shadowColor:
                      Colors.orange,

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),

                    child: const Text(

                      "Continuar",

                      style: TextStyle(

                        fontSize: 18,

                        color: Colors.white,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}