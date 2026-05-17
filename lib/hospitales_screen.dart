import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalesScreen extends StatelessWidget {
  const HospitalesScreen({super.key});

  // 📞 LLAMAR
  Future<void> llamar(String numero) async {
    final Uri url = Uri.parse("tel:$numero");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // 🗺️ VER EN MAPA (SIN SDK - SEGURO)
  Future<void> abrirMapa(String direccion) async {
    final query = Uri.encodeComponent(direccion);

    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Hospitales"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("hospitals")
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No hay hospitales registrados"),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {

              final data =
                  docs[index].data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🏥 HEADER
                    Row(
                      children: const [
                        Icon(Icons.local_hospital,
                            color: Colors.blue,
                            size: 28),
                        SizedBox(width: 10),
                        Text(
                          "Hospital",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // 📌 NOMBRE
                    Text(
                      data["nombre"] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 📍 DIRECCIÓN
                    Text(
                      data["direccion"] ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 16),

                    // 🔘 BOTONES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // 📞 LLAMAR
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            llamar(data["telefono"]);
                          },
                          icon: const Icon(Icons.call),
                          label: const Text("Llamar"),
                        ),

                        // 🗺️ MAPA
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            abrirMapa(data["direccion"]);
                          },
                          icon: const Icon(Icons.map),
                          label: const Text("Mapa"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}