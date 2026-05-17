import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'foro_screen.dart';
import 'publicar_screen.dart';
import 'alertas_screen.dart';
import 'perfil_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  //
  // 🔥 PANTALLAS
  //

  final List<Widget> screens = [

    HomeScreen(),

    PublicarScreen(),

    ForoScreen(),

    AlertasScreen(),

    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F5F5),

      //
      // 🔥 BODY
      //

      body: screens[currentIndex],

      //
      // 🔥 NAVBAR
      //

      bottomNavigationBar: Container(

        height: 78,

        decoration: BoxDecoration(

          color: Colors.white,

          boxShadow: [

            BoxShadow(

              color:
              Colors.black.withOpacity(
                0.08,
              ),

              blurRadius: 10,
            ),
          ],
        ),

        child: Row(

          mainAxisAlignment:
          MainAxisAlignment.spaceAround,

          children: [

            //
            // 🔥 INICIO
            //

            navItem(

              Icons.home_outlined,

              "Inicio",

              0,
            ),

            //
            // 🔥 PUBLICAR
            //

            navItem(

              Icons.add_circle_outline,

              "Publicar",

              1,
            ),

            //
            // 🔥 FORO
            //

            navItem(

              Icons.forum_outlined,

              "Foro",

              2,
            ),

            //
            // 🔥 ALERTAS
            //

            navItem(

              Icons.notifications_none,

              "Alertas",

              3,
            ),

            //
            // 🔥 PERFIL
            //

            navItem(

              Icons.person_outline,

              "Perfil",

              4,
            ),
          ],
        ),
      ),
    );
  }

  //
  // 🔥 ITEM NAV
  //

  Widget navItem(

      IconData icon,

      String label,

      int index,
      ) {

    bool selected =
        currentIndex == index;

    return GestureDetector(

      onTap: () {

        setState(() {

          currentIndex = index;
        });
      },

      child: AnimatedContainer(

        duration:
        const Duration(
          milliseconds: 250,
        ),

        padding:
        const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 8,
        ),

        decoration: BoxDecoration(

          color: selected

              ? const Color(
            0xFFFF7A00,
          ).withOpacity(0.12)

              : Colors.transparent,

          borderRadius:
          BorderRadius.circular(
            16,
          ),
        ),

        child: Column(

          mainAxisSize:
          MainAxisSize.min,

          children: [

            //
            // 🔥 ICON
            //

            Icon(

              icon,

              size: 26,

              color: selected

                  ? const Color(
                0xFFFF7A00,
              )

                  : Colors.black54,
            ),

            const SizedBox(height: 4),

            //
            // 🔥 LABEL
            //

            Text(

              label,

              style: TextStyle(

                fontSize: 12,

                fontWeight: selected

                    ? FontWeight.bold

                    : FontWeight.normal,

                color: selected

                    ? const Color(
                  0xFFFF7A00,
                )

                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}