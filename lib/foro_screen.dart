import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comentarios_screen.dart';
import 'firestore_service.dart';

class ForoScreen extends StatelessWidget {

  ForoScreen({super.key}) {

    timeago.setLocaleMessages(
      'es',
      timeago.EsMessages(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor:
        const Color(0xFFF5F5F5),

        appBar: AppBar(

          backgroundColor:
          Colors.white,

          elevation: 0,

          title: const Text(
            "Foro Comunitario",

            style: TextStyle(
              color: Colors.black,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        body: StreamBuilder(

          stream:
          FirebaseFirestore.instance
              .collection('posts')
              .orderBy(
            'fecha',
            descending: true,
          )
              .snapshots(),

          builder: (context, snapshot) {

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
            // 🔥 SIN POSTS
            //

            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty) {

              return const Center(
                child: Text(
                  "No hay publicaciones",
                ),
              );
            }

            final posts =
                snapshot.data!.docs;

            //
            // 🔥 LISTA POSTS
            //

            return ListView.builder(

              padding:
              const EdgeInsets.all(15),

              itemCount: posts.length,

              itemBuilder:
                  (context, index) {

                final post =
                posts[index];

                return PostCard(

                  //
                  // 🔥 ID
                  //

                  postId:
                  post.id,

                  //
                  // 🔥 DATOS
                  //

                  nombre:
                  post['nombre'] ??
                      "",

                  categoria:
                  post['categoria'] ??
                      "",

                  ubicacion:
                  post['ubicacion'] ??
                      "",

                  mensaje:
                  post['mensaje'] ??
                      "",

                  likes:
                  post['likes'] ?? 0,

                  //
                  // 🔥 TIEMPO REAL
                  //

                  tiempo:
                  timeago.format(

                    post['fecha']
                        .toDate(),

                    locale: 'es',
                  ),

                  //
                  // 🔥 IMAGEN
                  //

                  imageUrl:
                  post.data()
                      .toString()
                      .contains(
                    'imageUrl',
                  )
                      ? post['imageUrl']
                      : "",
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//
// 🔥 TARJETA POST
//

class PostCard extends StatelessWidget {

  final String postId;

  final String nombre;
  final String categoria;
  final String ubicacion;
  final String mensaje;

  final int likes;

  final String tiempo;

  final String imageUrl;

  const PostCard({
    super.key,

    required this.postId,

    required this.nombre,

    required this.categoria,

    required this.ubicacion,

    required this.mensaje,

    required this.likes,

    required this.tiempo,

    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

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
            color:
            Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 8,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          //
          // 🔥 HEADER
          //

          Row(
            children: [

              CircleAvatar(

                radius: 22,

                backgroundColor:
                const Color(
                  0xFFFF7A00,
                ),

                child: Text(

                  nombre.isNotEmpty
                      ? nombre[0]
                      : "U",

                  style:
                  const TextStyle(

                    color: Colors.white,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [

                    //
                    // 🔥 NOMBRE
                    //

                    Text(
                      nombre,

                      style:
                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    //
                    // 🔥 CATEGORÍA
                    //

                    Container(

                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),

                      decoration:
                      BoxDecoration(

                        border: Border.all(
                          color:
                          const Color(
                            0xFFFF7A00,
                          ),
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          10,
                        ),
                      ),

                      child: Text(
                        categoria,

                        style:
                        const TextStyle(

                          color:
                          Color(
                            0xFFFF7A00,
                          ),

                          fontSize: 11,
                        ),
                      ),
                    ),

                    //
                    // 🔥 UBICACIÓN
                    //

                    const SizedBox(
                      height: 6,
                    ),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on,

                          size: 14,

                          color:
                          Colors.grey,
                        ),

                        const SizedBox(
                          width: 4,
                        ),

                        Expanded(
                          child: Text(

                            ubicacion,

                            style:
                            const TextStyle(

                              color:
                              Colors.grey,

                              fontSize: 12,
                            ),

                            overflow:
                            TextOverflow
                                .ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //
              // 🔥 TIEMPO
              //

              Text(
                tiempo,

                style:
                const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          //
          // 🔥 MENSAJE
          //

          Text(

            mensaje,

            style:
            const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          //
          // 🔥 IMAGEN
          //

          if (imageUrl.isNotEmpty) ...[

            const SizedBox(height: 15),

            ClipRRect(

              borderRadius:
              BorderRadius.circular(
                16,
              ),

              child: Image.network(

                imageUrl,

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

                      color: Colors
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

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 10),

          //
          // 🔥 ACCIONES
          //

          Row(
            children: [

              //
              // 🔥 LIKE
              //

              GestureDetector(

                onTap: () async {

                  await FirestoreService()
                      .darLike(
                    postId,
                  );
                },

                child: Row(
                  children: [

                    const Icon(

                      Icons
                          .thumb_up_alt_outlined,

                      color:
                      Color(
                        0xFFFF7A00,
                      ),

                      size: 20,
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    Text("$likes"),
                  ],
                ),
              ),

              const SizedBox(width: 25),

              //
              // 🔥 COMENTARIOS
              //

              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          ComentariosScreen(
                            postId:
                            postId,
                          ),
                    ),
                  );
                },

                child: const Row(
                  children: [

                    Icon(
                      Icons
                          .mode_comment_outlined,

                      color:
                      Color(
                        0xFFFF7A00,
                      ),

                      size: 20,
                    ),

                    SizedBox(width: 5),

                    Text(
                      "Comentar",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}