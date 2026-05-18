import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ayudaScreen extends StatelessWidget {
  const ayudaScreen({super.key});

  // 🔥 FUNCIÓN PARA ABRIR LINK
  Future<void> abrirLink() async {
    final url = Uri.parse("https://6a0a3b354d400.site123.me/");

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Centro de Ayuda"),
        backgroundColor: const Color(0xFFFF7A00),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _HelpCard(
            icon: Icons.report_problem,
            title: "¿Cómo hago un reporte?",
            subtitle:
                "Ve a la sección Publicar y describe el problema que encontraste.",
          ),

          _HelpCard(
            icon: Icons.favorite,
            title: "¿Cómo doy like?",
            subtitle:
                "Toca el ícono de corazón en cualquier publicación.",
          ),

          _HelpCard(
            icon: Icons.edit,
            title: "¿Cómo edito mi perfil?",
            subtitle:
                "Ve a Perfil > Editar perfil y modifica tus datos.",
          ),

          _HelpCard(
            icon: Icons.support_agent,
            title: "Soporte técnico",
            subtitle:
                "Toca aquí para contactar al equipo de soporte.",
            onTap: abrirLink,
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _HelpCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              backgroundColor:
                  const Color(0xFFFF7A00).withOpacity(0.15),
              child: Icon(icon, color: const Color(0xFFFF7A00)),
            ),

            const SizedBox(width: 12),

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

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}