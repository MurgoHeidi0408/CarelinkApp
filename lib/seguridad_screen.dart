import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class SeguridadScreen extends StatelessWidget {
  const SeguridadScreen({super.key});

  // 📞 LLAMADA
  Future<void> llamarEmergencia(
      BuildContext context, String numero) async {

    final hasVibrator = await Vibration.hasVibrator() ?? false;

    if (hasVibrator) {
      Vibration.vibrate(duration: 120);
    }

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("⚠️ Llamada de emergencia"),
        content: Text("¿Deseas llamar al $numero?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Llamar"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      final Uri url = Uri.parse("tel:$numero");
      await launchUrl(url);
    }
  }

  // 🧱 CARD BONITA
  Widget emergencyCard(
    BuildContext context,
    String title,
    String subtitle,
    String number,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => llamarEmergencia(context, number),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(width: 14),

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
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text("Seguridad"),
        backgroundColor: const Color(0xFFFF3B30),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // 🔥 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🚨 Emergencias rápidas",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Toca cualquier opción para llamar",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            emergencyCard(
              context,
              "Emergencias",
              "Policía / Bomberos / Urgencias",
              "911",
              Icons.local_police,
              Colors.red,
            ),

            emergencyCard(
              context,
              "Denuncia anónima",
              "Reportes confidenciales",
              "089",
              Icons.security,
              Colors.orange,
            ),

            emergencyCard(
              context,
              "Cruz Roja",
              "Ambulancia y primeros auxilios",
              "065",
              Icons.local_hospital,
              Colors.redAccent,
            ),
          ],
        ),
      ),

      // 🚨 SOS MÁS PRO
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        icon: const Icon(Icons.warning, color: Colors.white),
        label: const Text(
          "SOS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => llamarEmergencia(context, "911"),
      ),
    );
  }
}