import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_service.dart';
import 'storage_service.dart';

class PublicarScreen extends StatefulWidget {
  const PublicarScreen({super.key});

  @override
  State<PublicarScreen> createState() =>
      _PublicarScreenState();
}

class _PublicarScreenState
    extends State<PublicarScreen> {

  final mensajeController =
  TextEditingController();

  final ubicacionController =
  TextEditingController();

  String categoria = "Emergencia";

  bool loading = false;

  Uint8List? imageBytes;

  //
  // 🔥 SELECCIONAR IMAGEN
  //

  Future<void> seleccionarImagen()
  async {

    showModalBottomSheet(

      context: context,

      builder: (_) {

        return SafeArea(

          child: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              //
              // 🔥 GALERÍA
              //

              ListTile(

                leading:
                const Icon(
                  Icons.photo,
                ),

                title:
                const Text(
                  "Galería",
                ),

                onTap: () async {

                  Navigator.pop(
                    context,
                  );

                  final picker =
                  ImagePicker();

                  final imagen =
                  await picker.pickImage(

                    source:
                    ImageSource.gallery,

                    imageQuality: 70,
                  );

                  if (imagen != null) {

                    final bytes =
                    await imagen
                        .readAsBytes();

                    setState(() {

                      imageBytes = bytes;
                    });
                  }
                },
              ),

              //
              // 🔥 CÁMARA
              //

              ListTile(

                leading:
                const Icon(
                  Icons.camera_alt,
                ),

                title:
                const Text(
                  "Cámara",
                ),

                onTap: () async {

                  Navigator.pop(
                    context,
                  );

                  final picker =
                  ImagePicker();

                  final imagen =
                  await picker.pickImage(

                    source:
                    ImageSource.camera,

                    imageQuality: 70,
                  );

                  if (imagen != null) {

                    final bytes =
                    await imagen
                        .readAsBytes();

                    setState(() {

                      imageBytes = bytes;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //
  // 🔥 PUBLICAR
  //

  Future<void> publicar() async {

    if (mensajeController.text
        .trim()
        .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Escribe algo antes de publicar",
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      //
      // 🔥 SUBIR IMAGEN
      //

      String imageUrl = "";

      if (imageBytes != null) {

        imageUrl =
        await StorageService()
            .subirImagen(
          imageBytes!,
        );
      }

      //
      // 🔥 USUARIO ACTUAL
      //

      final user =
      FirebaseAuth
          .instance
          .currentUser;

      //
      // 🔥 CREAR POST
      //

      await FirestoreService()
          .crearPost(

        nombre:

        user?.displayName
            ?? "Usuario",

        mensaje:
        mensajeController.text
            .trim(),

        categoria:
        categoria,

        ubicacion:
        ubicacionController
            .text
            .trim(),

        imageUrl:
        imageUrl,
      );

      //
      // 🔥 LIMPIAR
      //

      mensajeController.clear();

      ubicacionController.clear();

      imageBytes = null;

      //
      // 🔥 TERMINAR
      //

      if (mounted) {

        setState(() {
          loading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content:
            Text(
              "Publicación creada",
            ),
          ),
        );
      }

    } catch (e) {

      if (mounted) {

        setState(() {
          loading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(

            content:
            Text(
              "Error: $e",
            ),
          ),
        );
      }
    }
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

          iconTheme:
          const IconThemeData(
            color: Colors.black,
          ),

          title: const Text(

            "Nueva publicación",

            style: TextStyle(

              color: Colors.black,

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        body: SingleChildScrollView(

          padding:
          const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              //
              // 🔥 CATEGORÍA
              //

              const Text(

                "Categoría",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(

                value: categoria,

                decoration:
                InputDecoration(

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                      16,
                    ),

                    borderSide:
                    BorderSide.none,
                  ),
                ),

                items: const [

                  DropdownMenuItem(
                    value:
                    "Emergencia",

                    child: Text(
                      "Emergencia",
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                    "Tránsito",

                    child: Text(
                      "Tránsito",
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                    "Salud",

                    child: Text(
                      "Salud",
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                    "Seguridad",

                    child: Text(
                      "Seguridad",
                    ),
                  ),
                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      categoria = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 25),

              //
              // 🔥 UBICACIÓN
              //

              const Text(

                "Ubicación",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller:
                ubicacionController,

                decoration:
                InputDecoration(

                  hintText:
                  "Ej: Centro, Hospital, Avenida...",

                  prefixIcon:
                  const Icon(
                    Icons.location_on,
                  ),

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //
              // 🔥 DESCRIPCIÓN
              //

              const Text(

                "Descripción",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller:
                mensajeController,

                maxLines: 8,

                decoration:
                InputDecoration(

                  hintText:
                  "Describe lo ocurrido...",

                  hintStyle:
                  const TextStyle(
                    color: Colors.grey,
                  ),

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //
              // 🔥 BOTÓN CÁMARA
              //

              Row(
                children: [

                  GestureDetector(

                    onTap:
                    seleccionarImagen,

                    child: Container(

                      padding:
                      const EdgeInsets
                          .all(14),

                      decoration:
                      BoxDecoration(

                        color:
                        const Color(
                          0xFFFF7A00,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          16,
                        ),
                      ),

                      child: const Icon(

                        Icons.camera_alt,

                        color:
                        Colors.white,

                        size: 28,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  Expanded(

                    child: Text(

                      imageBytes == null

                          ? "Agregar imagen"

                          : "Imagen seleccionada",

                      style:
                      const TextStyle(

                        fontSize: 15,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              //
              // 🔥 PREVIEW
              //

              if (imageBytes != null) ...[

                const SizedBox(height: 18),

                ClipRRect(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  child: Image.memory(

                    imageBytes!,

                    width:
                    double.infinity,

                    height: 220,

                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 30),

              //
              // 🔥 BOTÓN PUBLICAR
              //

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed:
                  loading
                      ? null
                      : publicar,

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    const Color(
                      0xFFFF7A00,
                    ),

                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 18,
                    ),

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius
                          .circular(
                        18,
                      ),
                    ),
                  ),

                  child:

                  loading

                      ? const SizedBox(

                    height: 22,
                    width: 22,

                    child:
                    CircularProgressIndicator(

                      color:
                      Colors.white,

                      strokeWidth:
                      2.5,
                    ),
                  )

                      : const Text(

                    "Publicar",

                    style: TextStyle(

                      fontSize: 16,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}