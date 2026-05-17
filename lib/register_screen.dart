import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'welcome_screen.dart';
import 'user_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() =>
      _AuthScreenState();
}

class _AuthScreenState
    extends State<AuthScreen> {

  //
  // 🔥 CONTROLADORES
  //

  final usernameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  //
  // 🔥 ESTADOS
  //

  bool esLogin = true;

  bool loading = false;

  bool ocultarPassword = true;

  bool ocultarConfirmPassword = true;

  //
  // 🔥 LOGIN
  //

  Future<void> login() async {

    if (emailController.text
        .trim()
        .isEmpty ||

        passwordController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.red,

          content: Text(
            "Completa todos los campos",
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email:
        emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const WelcomeScreen(),
        ),
      );

    } on FirebaseAuthException
    catch (e) {

      String mensaje =
          "Error al iniciar sesión";

      if (e.code == 'user-not-found') {

        mensaje =
        "No existe una cuenta con ese correo";
      }

      if (e.code == 'wrong-password') {

        mensaje =
        "Contraseña incorrecta";
      }

      if (e.code == 'invalid-email') {

        mensaje =
        "Correo inválido";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor:
          Colors.red,

          content: Text(mensaje),
        ),
      );
    }

    if (mounted) {

      setState(() {
        loading = false;
      });
    }
  }

  //
  // 🔥 REGISTER
  //

  Future<void> register() async {

    if (usernameController.text
        .trim()
        .isEmpty ||

        emailController.text
            .trim()
            .isEmpty ||

        passwordController.text
            .trim()
            .isEmpty ||

        confirmPasswordController
            .text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.red,

          content: Text(
            "Completa todos los campos",
          ),
        ),
      );

      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text
            .trim()) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.red,

          content: Text(
            "Las contraseñas no coinciden",
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      UserCredential userCredential =

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email:
        emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      //
      // 🔥 GUARDAR NOMBRE
      //

      await userCredential.user!
          .updateDisplayName(

        usernameController.text.trim(),
      );

      //
      // 🔥 GUARDAR EN FIRESTORE
      //

      await UserService().guardarUsuario(

        uid:
        userCredential.user!.uid,

        nombre:
        usernameController.text.trim(),

        email:
        emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.green,

          content: Text(
            "Cuenta creada correctamente",
          ),
        ),
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const WelcomeScreen(),
        ),
      );

    } on FirebaseAuthException
    catch (e) {

      String mensaje =
          "Error al registrarse";

      if (e.code ==
          'email-already-in-use') {

        mensaje =
        "El correo ya está registrado";
      }

      if (e.code ==
          'weak-password') {

        mensaje =
        "La contraseña es muy débil";
      }

      if (e.code ==
          'invalid-email') {

        mensaje =
        "Correo inválido";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor:
          Colors.red,

          content: Text(mensaje),
        ),
      );
    }

    if (mounted) {

      setState(() {
        loading = false;
      });
    }
  }

  //
  // 🔥 INPUTS
  //

  InputDecoration inputDecoration({

    required String hint,

    required IconData icon,

    Widget? suffixIcon,
  }) {

    return InputDecoration(

      hintText: hint,

      hintStyle: TextStyle(
        color: Colors.grey.shade500,
      ),

      prefixIcon: Icon(
        icon,
        color: const Color(0xFFFF6B00),
      ),

      suffixIcon: suffixIcon,

      filled: true,

      fillColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(
        vertical: 20,
      ),

      border: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      enabledBorder:
      OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(18),

        borderSide: BorderSide(

          color: Colors.grey.shade200,
        ),
      ),

      focusedBorder:
      OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(18),

        borderSide: const BorderSide(

          color: Color(0xFFFF6B00),

          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFFF8C42),
              Color(0xFFF5F7FA),
            ],
          ),
        ),

        child: SafeArea(

          child: Center(

            child: SingleChildScrollView(

              child: Padding(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 28,
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    //
                    // 🔥 LOGO
                    //

                    Container(

                      padding:
                      const EdgeInsets.all(24),

                      decoration: BoxDecoration(

                        gradient:
                        const LinearGradient(

                          colors: [

                            Color(0xFFFF8C42),
                            Color(0xFFFF6B00),
                          ],
                        ),

                        shape: BoxShape.circle,

                        boxShadow: [

                          BoxShadow(

                            color: Colors.orange
                                .withOpacity(0.35),

                            blurRadius: 25,

                            offset:
                            const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: Icon(

                        esLogin

                            ? Icons.lock_open_rounded

                            : Icons.person_add_alt_1_rounded,

                        color: Colors.white,

                        size: 68,
                      ),
                    ),

                    const SizedBox(height: 28),

                    //
                    // 🔥 TITULO
                    //

                    Text(

                      esLogin
                          ? "Bienvenido"
                          : "Crear cuenta",

                      style: const TextStyle(

                        fontSize: 42,

                        letterSpacing: -1,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      esLogin

                          ? "Inicia sesión para continuar"

                          : "Únete a Carelink",

                      textAlign:
                      TextAlign.center,

                      style: const TextStyle(

                        color:
                        Color(0xFF64748B),

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),

                    //
                    // 🔥 CARD
                    //

                    AnimatedContainer(

                      duration:
                      const Duration(
                        milliseconds: 300,
                      ),

                      curve:
                      Curves.easeInOut,

                      width: 380,

                      padding:
                      const EdgeInsets.all(
                        28,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(30),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black
                                .withOpacity(0.08),

                            blurRadius: 35,

                            spreadRadius: 2,

                            offset:
                            const Offset(0, 12),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          if (!esLogin) ...[

                            TextField(

                              controller:
                              usernameController,

                              decoration:
                              inputDecoration(

                                hint:
                                "Nombre de usuario",

                                icon:
                                Icons.person_outline,
                              ),
                            ),

                            const SizedBox(height: 18),
                          ],

                          TextField(

                            controller:
                            emailController,

                            decoration:
                            inputDecoration(

                              hint:
                              "Correo electrónico",

                              icon:
                              Icons.email_outlined,
                            ),
                          ),

                          const SizedBox(height: 18),

                          TextField(

                            controller:
                            passwordController,

                            obscureText:
                            ocultarPassword,

                            decoration:
                            inputDecoration(

                              hint:
                              "Contraseña",

                              icon:
                              Icons.lock_outline,

                              suffixIcon:
                              IconButton(

                                icon: Icon(

                                  ocultarPassword

                                      ? Icons
                                      .visibility_off_outlined

                                      : Icons
                                      .visibility_outlined,

                                  color:
                                  Colors.orange,
                                ),

                                onPressed: () {

                                  setState(() {

                                    ocultarPassword =
                                    !ocultarPassword;
                                  });
                                },
                              ),
                            ),
                          ),

                          if (!esLogin) ...[

                            const SizedBox(height: 18),

                            TextField(

                              controller:
                              confirmPasswordController,

                              obscureText:
                              ocultarConfirmPassword,

                              decoration:
                              inputDecoration(

                                hint:
                                "Confirmar contraseña",

                                icon:
                                Icons.lock_reset_outlined,

                                suffixIcon:
                                IconButton(

                                  icon: Icon(

                                    ocultarConfirmPassword

                                        ? Icons
                                        .visibility_off_outlined

                                        : Icons
                                        .visibility_outlined,

                                    color:
                                    Colors.orange,
                                  ),

                                  onPressed: () {

                                    setState(() {

                                      ocultarConfirmPassword =
                                      !ocultarConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 32),

                          SizedBox(

                            width: double.infinity,

                            height: 60,

                            child: ElevatedButton(

                              style:
                              ElevatedButton
                                  .styleFrom(

                                elevation: 8,

                                shadowColor:
                                Colors.orange,

                                backgroundColor:
                                const Color(
                                  0xFFFF7A00,
                                ),

                                shape:
                                RoundedRectangleBorder(

                                  borderRadius:
                                  BorderRadius.circular(
                                    20,
                                  ),
                                ),
                              ),

                              onPressed:
                              loading

                                  ? null

                                  : esLogin
                                  ? login
                                  : register,

                              child:

                              loading

                                  ? const CircularProgressIndicator(
                                color:
                                Colors.white,
                              )

                                  : Text(

                                esLogin

                                    ? "Iniciar sesión"

                                    : "Crear cuenta",

                                style:
                                const TextStyle(

                                  fontSize: 17,

                                  color:
                                  Colors.white,

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextButton(

                            onPressed: () {

                              setState(() {

                                esLogin = !esLogin;
                              });
                            },

                            child: Text(

                              esLogin

                                  ? "¿No tienes cuenta? Regístrate"

                                  : "Ya tengo una cuenta",

                              style: const TextStyle(

                                color:
                                Color(
                                  0xFFFF6B00,
                                ),

                                fontWeight:
                                FontWeight.bold,

                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    Text(

                      "Protegiendo a la comunidad juntos",

                      style: TextStyle(

                        color:
                        Colors.grey.shade600,

                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}