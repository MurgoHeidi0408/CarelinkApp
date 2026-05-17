import 'package:flutter/material.dart';

class ayudaScreen extends StatelessWidget {
  const ayudaScreen({super.key});

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
        children: const [

          _HelpCard(
            icon: Icons.report_problem,
            title: "¿Cómo hago un reporte?",
            subtitle: "Ve a la sección Publicar y describe el problema que encontraste.",
          ),

          _HelpCard(
            icon: Icons.favorite,
            title: "¿Cómo doy like?",
            subtitle: "Toca el ícono de corazón en cualquier publicación.",
          ),

          _HelpCard(
            icon: Icons.edit,
            title: "¿Cómo edito mi perfil?",
            subtitle: "Ve a Perfil > Editar perfil y modifica tus datos.",
          ),

          _HelpCard(
            icon: Icons.support_agent,
            title: "Soporte técnico",
            subtitle: "Si tienes problemas, contacta al equipo desde la sección de ayuda o correo oficial.",
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

  const _HelpCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            backgroundColor: const Color(0xFFFF7A00).withOpacity(0.15),
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
    );
  }
}