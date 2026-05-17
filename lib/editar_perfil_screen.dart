import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({
    super.key,
  });

  @override
  State<EditarPerfilScreen> createState() =>
      _EditarPerfilScreenState();
}

class _EditarPerfilScreenState
    extends State<EditarPerfilScreen> {

  final nombreController =
      TextEditingController();

  final bioController =
      TextEditingController();

  final ciudadController =
      TextEditingController();

  File? image;

  bool loading = false;

  //
  // 🔥 IMAGE PICKER
  //

  final ImagePicker picker =
      ImagePicker();

  @override
  void initState() {

    super.initState();

    //
    // 🔥 USUARIO ACTUAL
    //

    final user =
        FirebaseAuth.instance.currentUser;

    nombreController.text =
        user?.displayName ?? "";

    bioController.text =
        "Usuario activo en la comunidad.";
  }

  //
  // 🔥 SELECCIONAR FOTO
  //

  Future<void> seleccionarImagen()
  async {

    final XFile? pickedFile =

    await picker.pickImage(

      source: ImageSource.gallery,

      imageQuality: 70,
    );

    if (pickedFile != null) {

      setState(() {

        image = File(
          pickedFile.path,
        );
      });
    }
  }

  //
  // 🔥 GUARDAR CAMBIOS
  //

  Future<void> guardarCambios() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    setState(() {
      loading = true;
    });

    try {

      //
      // 🔥 ACTUALIZAR AUTH
      //

      await user.updateDisplayName(
        nombreController.text.trim(),
      );

      //
      // 🔥 ACTUALIZAR FIRESTORE
      //

      await UserService().actualizarUsuario(

        uid: user.uid,

        nombre:
        nombreController.text.trim(),

        bio:
        bioController.text.trim(),

        ciudad:
        ciudadController.text.trim(),

        photoUrl: "",
      );

      //
      // 🔥 RECARGAR USUARIO
      //

      await user.reload();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          content: Text(
            "Perfil actualizado",
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            "Error: $e",
          ),
        ),
      );
    }

    if (mounted) {

      setState(() {
        loading = false;
      });
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

          title: const Text(

            "Editar perfil",

            style: TextStyle(
              color: Colors.black,
            ),
          ),

          iconTheme:
          const IconThemeData(
            color: Colors.black,
          ),
        ),

        body: Padding(

          padding:
          const EdgeInsets.all(20),

          child: SingleChildScrollView(

            child: Column(

              children: [

                //
                // 🔥 FOTO PERFIL
                //

                GestureDetector(

                  onTap:
                  seleccionarImagen,

                  child: Stack(

                    children: [

                      CircleAvatar(

                        radius: 55,

                        backgroundColor:
                        Colors.grey.shade300,

                        backgroundImage:

                        image != null

                            ? FileImage(
                          image!,
                        )

                            : null,

                        child:

                        image == null

                            ? const Icon(

                          Icons.person,

                          size: 50,

                          color: Colors.grey,
                        )

                            : null,
                      ),

                      Positioned(

                        bottom: 0,
                        right: 0,

                        child: Container(

                          padding:
                          const EdgeInsets
                              .all(8),

                          decoration:
                          const BoxDecoration(

                            color:
                            Color(
                              0xFFFF7A00,
                            ),

                            shape:
                            BoxShape.circle,
                          ),

                          child: const Icon(

                            Icons.camera_alt,

                            color:
                            Colors.white,

                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(

                  "Toca para cambiar foto",

                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                //
                // 🔥 NOMBRE
                //

                TextField(

                  controller:
                  nombreController,

                  decoration:
                  InputDecoration(

                    labelText:
                    "Nombre",

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

                const SizedBox(height: 20),

                //
                // 🔥 BIO
                //

                TextField(

                  controller:
                  bioController,

                  maxLines: 4,

                  decoration:
                  InputDecoration(

                    labelText:
                    "Biografía",

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

                const SizedBox(height: 20),

                //
                // 🔥 CIUDAD
                //

                TextField(

                  controller:
                  ciudadController,

                  decoration:
                  InputDecoration(

                    labelText:
                    "Ciudad",

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

                const SizedBox(height: 30),

                //
                // 🔥 GUARDAR
                //

                SizedBox(

                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed:
                    loading
                        ? null
                        : guardarCambios,

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(
                        0xFFFF7A00,
                      ),

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 18,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    child:

                    loading

                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )

                        : const Text(

                      "Guardar cambios",

                      style: TextStyle(

                        color: Colors.white,

                        fontWeight:
                        FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}