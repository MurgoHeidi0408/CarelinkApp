import 'package:flutter/material.dart';

class RecomendacionesScreen extends StatelessWidget {
  const RecomendacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Recomendaciones"),
        backgroundColor: const Color(0xFFFFB300),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Tips útiles para tu seguridad y bienestar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 TARJETAS
            recommendationCard(
              icon: Icons.health_and_safety,
              title: "Seguridad Personal",
              description:
                  "Evita caminar solo en zonas oscuras y mantén tu celular cargado.",
              color: Colors.redAccent,
            ),

            recommendationCard(
              icon: Icons.local_hospital,
              title: "Salud",
              description:
                  "Ten siempre a la mano hospitales cercanos y contactos de emergencia.",
              color: Colors.blue,
            ),

            recommendationCard(
              icon: Icons.home,
              title: "En Casa",
              description:
                  "Revisa puertas y ventanas antes de dormir para mayor seguridad.",
              color: Colors.green,
            ),

            recommendationCard(
              icon: Icons.traffic,
              title: "En la Calle",
              description:
                  "Respeta semáforos y evita distracciones al cruzar calles.",
              color: Colors.orange,
            ),

            recommendationCard(
              icon: Icons.phone_android,
              title: "Tecnología",
              description:
                  "Comparte tu ubicación solo con personas de confianza.",
              color: Colors.purple,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= CARD PRO =================
  Widget recommendationCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          // ICONO
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 28),
          ),

          const SizedBox(width: 14),

          // TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
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
}