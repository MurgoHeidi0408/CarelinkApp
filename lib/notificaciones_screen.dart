import 'package:flutter/material.dart';

class notificacionesScreen extends StatelessWidget {
  const notificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Notificaciones"),
        backgroundColor: const Color(0xFFFF7A00),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ================= HEADER BONITO =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7A00).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 40,
                    color: Color(0xFFFF7A00),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Centro de notificaciones",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Aquí verás toda la actividad de tu cuenta",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= NOTIFICACIONES SIMULADAS =================
          const Text(
            "Recientes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          _notiItem(
            icon: Icons.favorite,
            color: Colors.red,
            title: "A alguien le gustó tu publicación",
            time: "Hace 2 min",
          ),

          _notiItem(
            icon: Icons.comment,
            color: Colors.blue,
            title: "Nuevo comentario en tu post",
            time: "Hace 10 min",
          ),

          _notiItem(
            icon: Icons.person_add,
            color: Colors.green,
            title: "Nuevo seguidor",
            time: "Hace 1 hora",
          ),

          _notiItem(
            icon: Icons.cloud_upload,
            color: Colors.orange,
            title: "Tu reporte fue publicado",
            time: "Ayer",
          ),

          const SizedBox(height: 20),

          // ================= ESTADO VACÍO (BONITO) =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                const Icon(
                  Icons.notifications_off,
                  size: 50,
                  color: Colors.grey,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sin más notificaciones",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Cuando haya nueva actividad aparecerá aquí automáticamente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= WIDGET DE NOTIFICACIÓN =================
  Widget _notiItem({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
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