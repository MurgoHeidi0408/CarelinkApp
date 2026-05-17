import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart'
as timeago;

class AlertasScreen extends StatelessWidget {
  const AlertasScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor:
        const Color(0xFFF5F5F5),

        appBar: AppBar(

          backgroundColor: Colors.white,
          elevation: 0,

          title: const Text(
            "Alertas",

            style: TextStyle(
              color: Colors.black,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        body: StreamBuilder<QuerySnapshot>(

          stream: FirebaseFirestore
              .instance
              .collection('posts')
              .where(
            'categoria',
            whereIn: [
              'Emergencia',
              'Seguridad',
            ],
          )
              .orderBy(
            'fecha',
            descending: true,
          )
              .snapshots(),

          builder: (context, snapshot) {

            //
            // 🔥 ERROR
            //

            if (snapshot.hasError) {

              return Center(
                child: Padding(
                  padding:
                  const EdgeInsets.all(20),

                  child: Text(

                    "Error:\n\n${snapshot.error}",

                    textAlign:
                    TextAlign.center,

                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }

            //
            // 🔥 CARGANDO
            //

            if (snapshot.connectionState ==
                ConnectionState.waiting) {

              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }

            //
            // 🔥 SIN ALERTAS
            //

            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty) {

              return const Center(
                child: Text(
                  "No hay alertas",
                ),
              );
            }

            final posts =
                snapshot.data!.docs;

            //
            // 🔥 LISTA
            //

            return ListView.builder(

              padding:
              const EdgeInsets.all(15),

              itemCount: posts.length,

              itemBuilder: (context, index) {

                final post = posts[index];

                return Container(

                  margin:
                  const EdgeInsets.only(
                    bottom: 16,
                  ),

                  padding:
                  const EdgeInsets.all(18),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(
                      22,
                    ),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 8,
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      //
                      // 🔥 HEADER
                      //

                      Row(
                        children: [

                          Container(

                            padding:
                            const EdgeInsets
                                .all(10),

                            decoration:
                            BoxDecoration(

                              color:
                              Colors.red
                                  .withOpacity(
                                0.12,
                              ),

                              shape:
                              BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.warning,

                              color:
                              Colors.red,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Text(
                                  post['categoria'],

                                  style:
                                  const TextStyle(

                                    color:
                                    Colors.red,

                                    fontWeight:
                                    FontWeight
                                        .bold,

                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(

                                  timeago.format(

                                    (post['fecha']
                                    as Timestamp)
                                        .toDate(),
                                  ),

                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.grey,

                                    fontSize:
                                    12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      //
                      // 🔥 MENSAJE
                      //

                      Text(

                        post['mensaje'],

                        style:
                        const TextStyle(

                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      //
                      // 🔥 IMAGEN
                      //

                      if (post
                          .data()
                          .toString()
                          .contains(
                        'imageUrl',
                      ) &&

                          post['imageUrl']
                              != null &&

                          post['imageUrl']
                              .toString()
                              .isNotEmpty) ...[

                        const SizedBox(
                          height: 15,
                        ),

                        ClipRRect(

                          borderRadius:
                          BorderRadius
                              .circular(16),

                          child:
                          Image.network(

                            post['imageUrl'],

                            width:
                            double.infinity,

                            height: 220,

                            fit: BoxFit.cover,

                            errorBuilder:
                                (
                                context,
                                error,
                                stackTrace,
                                ) {

                              return Container(

                                height: 220,

                                decoration:
                                BoxDecoration(

                                  color:
                                  Colors
                                      .grey
                                      .shade300,

                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    16,
                                  ),
                                ),

                                child:
                                const Center(

                                  child: Icon(
                                    Icons
                                        .broken_image,

                                    size: 40,

                                    color:
                                    Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}