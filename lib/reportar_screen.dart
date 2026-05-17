import 'package:flutter/material.dart';

class HospitalesScreen extends StatelessWidget {
  const HospitalesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Hospitales",
        ),
      ),

      body: ListView(

        padding:
        const EdgeInsets.all(20),

        children: [

          hospitalCard(
            "Hospital General",
            "Av. Central #123",
          ),

          hospitalCard(
            "Cruz Roja",
            "Zona Norte",
          ),

          hospitalCard(
            "IMSS Regional",
            "Col. Centro",
          ),
        ],
      ),
    );
  }

  Widget hospitalCard(
      String nombre,
      String direccion,
      ) {

    return Container(

      margin:
      const EdgeInsets.only(bottom: 15),

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Row(

        children: [

          const CircleAvatar(

            backgroundColor:
            Colors.blue,

            child: Icon(

              Icons.local_hospital,

              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  nombre,

                  style: const TextStyle(

                    fontWeight:
                    FontWeight.bold,

                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  direccion,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}