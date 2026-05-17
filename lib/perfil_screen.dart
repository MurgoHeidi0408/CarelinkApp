import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'editar_perfil_screen.dart';
import 'register_screen.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //
    // 🔥 USUARIO ACTUAL
    //

    final user =
    FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(

        backgroundColor:
        const Color(0xFFF5F5F5),

        body: SingleChildScrollView(

          child: Column(
            children: [

              //
              // 🔥 HEADER
              //

              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.only(

                  top: 35,
                  bottom: 35,
                ),

                decoration:
                const BoxDecoration(

                  color:
                  Color(0xFFFF7A00),

                  borderRadius:
                  BorderRadius.only(

                    bottomLeft:
                    Radius.circular(
                      35,
                    ),

                    bottomRight:
                    Radius.circular(
                      35,
                    ),
                  ),
                ),

                child: Column(
                  children: [

                    //
                    // 🔥 FOTO PERFIL
                    //

                    CircleAvatar(

                      radius: 52,

                      backgroundColor:
                      Colors.white,

                      backgroundImage:

                      user?.photoURL != null

                          ? NetworkImage(
                        user!.photoURL!,
                      )

                          : null,

                      child:

                      user?.photoURL == null

                          ? const Icon(

                        Icons.person,

                        size: 50,

                        color: Colors.grey,
                      )

                          : null,
                    ),

                    const SizedBox(height: 16),

                    //
                    // 🔥 NOMBRE
                    //

                    Text(

                      user?.displayName
                          ?? "Usuario",

                      style:
                      const TextStyle(

                        color:
                        Colors.white,

                        fontSize: 26,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    //
                    // 🔥 EMAIL
                    //

                    Text(

                      user?.email
                          ?? "Sin correo",

                      style:
                      const TextStyle(

                        color:
                        Colors.white70,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 18),

                    //
                    // 🔥 EDITAR PERFIL
                    //

                    ElevatedButton.icon(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                            const EditarPerfilScreen(),
                          ),
                        );
                      },

                      style:
                      ElevatedButton
                          .styleFrom(

                        backgroundColor:
                        Colors.white,

                        foregroundColor:
                        const Color(
                          0xFFFF7A00,
                        ),

                        elevation: 0,

                        padding:
                        const EdgeInsets
                            .symmetric(

                          horizontal: 20,
                          vertical: 14,
                        ),

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius
                              .circular(
                            18,
                          ),
                        ),
                      ),

                      icon: const Icon(
                        Icons.edit,
                      ),

                      label: const Text(

                        "Editar perfil",

                        style: TextStyle(

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //
              // 🔥 ESTADÍSTICAS
              //

              Padding(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Row(
                  children: [

                    Expanded(
                      child: statCard(
                        "12",
                        "Reportes",
                        Icons.warning_amber,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: statCard(
                        "34",
                        "Likes",
                        Icons.favorite,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //
              // 🔥 OPCIONES
              //

              Padding(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Column(
                  children: [

                    optionTile(

                      icon:
                      Icons.notifications,

                      title:
                      "Notificaciones",

                      onTap: () {},
                    ),

                    optionTile(

                      icon:
                      Icons.lock,

                      title:
                      "Privacidad",

                      onTap: () {},
                    ),

                    optionTile(

                      icon:
                      Icons.help_outline,

                      title:
                      "Ayuda",

                      onTap: () {},
                    ),

                    optionTile(

                      icon:
                      Icons.logout,

                      title:
                      "Cerrar sesión",

                      color:
                      Colors.red,

                      onTap: () async {

                        await FirebaseAuth
                            .instance
                            .signOut();

                        if (!context.mounted) {
                          return;
                        }

                        Navigator
                            .pushAndRemoveUntil(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                            const AuthScreen(),
                          ),

                              (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //
  // 🔥 CARD ESTADÍSTICAS
  //

  Widget statCard(

      String value,
      String label,
      IconData icon,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 22,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          24,
        ),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,
          ),
        ],
      ),

      child: Column(
        children: [

          Icon(

            icon,

            color:
            const Color(
              0xFFFF7A00,
            ),

            size: 30,
          ),

          const SizedBox(height: 10),

          Text(

            value,

            style: const TextStyle(

              fontSize: 24,

              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(

            label,

            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  //
  // 🔥 OPCIONES
  //

  Widget optionTile({

    required IconData icon,

    required String title,

    required VoidCallback onTap,

    Color color = Colors.black,
  }) {

    return Container(

      margin:
      const EdgeInsets.only(
        bottom: 14,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          20,
        ),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(
              0.04,
            ),

            blurRadius: 8,
          ),
        ],
      ),

      child: ListTile(

        onTap: onTap,

        leading: Icon(
          icon,
          color: color,
        ),

        title: Text(

          title,

          style: TextStyle(
            color: color,
            fontWeight:
            FontWeight.w600,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }
}