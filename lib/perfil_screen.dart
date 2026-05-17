import 'package:carelink_app/notificaciones_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editar_perfil_screen.dart';
import 'register_screen.dart';
import 'user_service.dart';
import 'ayuda_screen.dart';
import 'privacidad_screen.dart';
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        body: StreamBuilder(
          stream: UserService().obtenerUsuario(user!.uid),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            Map<String, dynamic> data = {};

            if (snapshot.hasData && snapshot.data!.exists) {
              data = snapshot.data!.data() as Map<String, dynamic>;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // =========================
                  // HEADER
                  // =========================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 35, bottom: 35),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF7A00),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              data['photoUrl'] != null &&
                                      data['photoUrl'] != ''
                                  ? NetworkImage(data['photoUrl'])
                                  : null,
                          child: data['photoUrl'] == null ||
                                  data['photoUrl'] == ''
                              ? const Icon(Icons.person,
                                  size: 50, color: Colors.grey)
                              : null,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          data['nombre'] ??
                              user.displayName ??
                              "Usuario",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          data['email'] ?? user.email ?? "Sin correo",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            data['bio'] ?? "Miembro de Carelink",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFFFF7A00),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          icon: const Icon(Icons.edit),
                          label: const Text("Editar perfil"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // ESTADÍSTICAS REALES
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // POSTS
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("posts")
                                .where("userId",
                                    isEqualTo: user.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return statCard(
                                    "0", "Reportes", Icons.warning_amber);
                              }

                              final count =
                                  snapshot.data!.docs.length;

                              return statCard(
                                  count.toString(),
                                  "Reportes",
                                  Icons.warning_amber);
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        // LIKES
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("posts")
                                .where("userId",
                                    isEqualTo: user.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return statCard(
                                    "0", "Likes", Icons.favorite);
                              }

                              int totalLikes = 0;

                              for (var doc
                                  in snapshot.data!.docs) {
                                totalLikes +=
                                    (doc["likes"] ?? 0) as int;
                              }

                              return statCard(
                                  totalLikes.toString(),
                                  "Likes",
                                  Icons.favorite);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // OPCIONES
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        optionTile(
                          icon: Icons.location_city,
                          title: data['ciudad'] ?? "México",
                          onTap: () {},
                        ),
                        optionTile(
                          icon: Icons.notifications,
                          title: "Notificaciones",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const notificacionesScreen()
                                ),
                            );
                          }
                            

                        ),
                        optionTile(
                          icon: Icons.lock,
                          title: "Privacidad",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const privacidadScreen()
                                ),
                              );
                          },
                        ),
                        optionTile(
                          icon: Icons.help_outline,
                          title: "Ayuda",
                          onTap: () {
                            Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (_) => const ayudaScreen(),
                               ),
                            );
                          },
                        ),
                        optionTile(
                          icon: Icons.logout,
                          title: "Cerrar sesión",
                          color: Colors.red,
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();

                            if (!context.mounted) return;

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AuthScreen(),
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
            );
          },
        ),
      ),
    );
  }

  // =========================
  // STAT CARD
  // =========================
  Widget statCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon,
              color: const Color(0xFFFF7A00), size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // =========================
  // OPTION TILE
  // =========================
  Widget optionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}