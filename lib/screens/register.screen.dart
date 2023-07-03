import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSubmit() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Conta criada com sucesso"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Conta não criada."),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void navLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/icon-transparente.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Registrar-se!',
              style: TextStyle(fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      backgroundColor: const Color.fromRGBO(
                          33, 77, 171, 0.478), // Define a cor de fundo do botão
                      padding: const EdgeInsets.symmetric(vertical: 16.0)),
                  onPressed: onSubmit,
                  child: const Text('Registra-se')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      backgroundColor: const Color.fromARGB(
                          255, 164, 168, 227), // Define a cor de fundo do botão
                      padding: const EdgeInsets.symmetric(vertical: 16.0)),
                  onPressed: navLogin,
                  child: const Text('Já tenho conta')),
            )
          ],
        ),
      ),
    );
  }
}
