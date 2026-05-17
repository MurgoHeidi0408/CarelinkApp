import 'package:flutter/material.dart';

class privacidadScreen extends StatefulWidget {
  const privacidadScreen({super.key});

  @override
  State<privacidadScreen> createState() => _PrivacidadScreenState();
}

class _PrivacidadScreenState extends State<privacidadScreen> {

  bool perfilPublico = true;
  bool mostrarUbicacion = true;
  bool actividadVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Privacidad"),
        backgroundColor: const Color(0xFFFF7A00),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Controla quién puede ver tu información",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          _PrivacyCard(
            icon: Icons.public,
            title: "Perfil público",
            subtitle: "Cualquiera puede ver tu perfil y publicaciones",
            value: perfilPublico,
            onChanged: (v) => setState(() => perfilPublico = v),
          ),

          _PrivacyCard(
            icon: Icons.location_on,
            title: "Mostrar ubicación",
            subtitle: "Permite mostrar tu ubicación en publicaciones",
            value: mostrarUbicacion,
            onChanged: (v) => setState(() => mostrarUbicacion = v),
          ),

          _PrivacyCard(
            icon: Icons.visibility,
            title: "Actividad visible",
            subtitle: "Otros pueden ver cuando estás activo",
            value: actividadVisible,
            onChanged: (v) => setState(() => actividadVisible = v),
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  const _PrivacyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: SwitchListTile(
        secondary: CircleAvatar(
          backgroundColor: const Color(0xFFFF7A00).withOpacity(0.15),
          child: Icon(icon, color: const Color(0xFFFF7A00)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        value: value,
        activeColor: const Color(0xFFFF7A00),
        onChanged: onChanged,
      ),
    );
  }
}