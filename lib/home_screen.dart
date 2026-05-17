import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              //
              // 🔥 HEADER
              //

              Row(
                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFF7A00),

                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Hola, Usuario 👋",

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Mantente informado sobre tu comunidad",

                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.notifications_none,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //
              // 🔥 BUSCADOR
              //

              TextField(
                decoration: InputDecoration(

                  hintText:
                  "Buscar reportes o emergencias...",

                  prefixIcon:
                  const Icon(Icons.search),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              //
              // 🔥 ACCESOS RÁPIDOS
              //

              const Text(
                "Accesos rápidos",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                childAspectRatio: 1.2,

                children: [

                  quickCard(
                    Icons.warning_amber_rounded,
                    "Reportar",
                    const Color(0xFFFF7A00),
                  ),

                  quickCard(
                    Icons.location_on,
                    "Cercanos",
                    Colors.redAccent,
                  ),

                  quickCard(
                    Icons.local_hospital,
                    "Hospitales",
                    Colors.blue,
                  ),

                  quickCard(
                    Icons.security,
                    "Seguridad",
                    Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //
              // 🔥 ALERTAS
              //

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Alertas recientes",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: () {},

                    child: const Text(
                      "Ver todas",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              alertCard(
                "Accidente vial",
                "Choque fuerte en Av. Central",
                Colors.red,
              ),

              const SizedBox(height: 14),

              alertCard(
                "Zona inundada",
                "Evitar calle Morelos",
                Colors.orange,
              ),

              const SizedBox(height: 30),

              //
              // 🔥 ACTIVIDAD
              //

              const Text(
                "Actividad comunitaria",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              communityPost(
                "María González",
                "¿La avenida principal ya fue despejada?",
              ),

              const SizedBox(height: 12),

              communityPost(
                "Carlos Ruiz",
                "Hospital saturado en zona norte.",
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFFF7A00),

          onPressed: () {},

          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //
  // 🔥 CARD RÁPIDA
  //

  Widget quickCard(
      IconData icon,
      String title,
      Color color,
      ) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor:
            color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  //
  // 🔥 ALERT CARD
  //

  Widget alertCard(
      String title,
      String subtitle,
      Color color,
      ) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
            color.withOpacity(0.15),

            child: Icon(
              Icons.warning_amber_rounded,
              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,

                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  // 🔥 PUBLICACIÓN
  //

  Widget communityPost(
      String user,
      String text,
      ) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const CircleAvatar(
            backgroundColor:
            Color(0xFFFF7A00),

            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  user,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}