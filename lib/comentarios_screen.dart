import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComentariosScreen extends StatefulWidget {

  final String postId;

  const ComentariosScreen({
    super.key,
    required this.postId,
  });

  @override
  State<ComentariosScreen> createState() =>
      _ComentariosScreenState();
}

class _ComentariosScreenState
    extends State<ComentariosScreen> {

  final comentarioController =
      TextEditingController();

  bool loading = false;

  //
  // 🔥 AGREGAR COMENTARIO
  //

  Future<void> agregarComentario() async {

    if (comentarioController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      loading = true;
    });

    await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("comentarios")
        .add({

      "usuario": "Usuario",

      "comentario":
      comentarioController.text.trim(),

      "fecha": Timestamp.now(),
    });

    comentarioController.clear();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        iconTheme:
        const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "Comentarios",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          //
          // 🔥 LISTA DE COMENTARIOS
          //

          Expanded(
            child: StreamBuilder(

              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .doc(widget.postId)
                  .collection("comentarios")
                  .orderBy("fecha",
                  descending: true)
                  .snapshots(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                final comentarios =
                    snapshot.data!.docs;

                if (comentarios.isEmpty) {

                  return const Center(
                    child: Text(
                      "No hay comentarios",
                    ),
                  );
                }

                return ListView.builder(

                  padding:
                  const EdgeInsets.all(15),

                  itemCount:
                  comentarios.length,

                  itemBuilder: (context, index) {

                    final comentario =
                    comentarios[index];

                    return Container(

                      margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),

                      padding:
                      const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          CircleAvatar(
                            backgroundColor:
                            const Color(
                              0xFFFF7A00,
                            ),

                            child: Text(
                              comentario[
                              "usuario"][0],
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Text(
                                  comentario[
                                  "usuario"],

                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 6,
                                ),

                                Text(
                                  comentario[
                                  "comentario"],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          //
          // 🔥 ESCRIBIR COMENTARIO
          //

          Container(
            padding:
            const EdgeInsets.all(12),

            color: Colors.white,

            child: Row(
              children: [

                Expanded(
                  child: TextField(

                    controller:
                    comentarioController,

                    decoration: InputDecoration(

                      hintText:
                      "Escribe un comentario...",

                      filled: true,

                      fillColor:
                      Colors.grey.shade100,

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),

                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFFFF7A00),

                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),

                  child: IconButton(

                    onPressed:
                    loading
                        ? null
                        : agregarComentario,

                    icon: loading
                        ? const SizedBox(
                      width: 18,
                      height: 18,

                      child:
                      CircularProgressIndicator(
                        color:
                        Colors.white,

                        strokeWidth:
                        2,
                      ),
                    )
                        : const Icon(
                      Icons.send,
                      color:
                      Colors.white,
                    ),
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