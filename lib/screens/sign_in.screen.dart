import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/routes.path.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final String message;
  String request = 'https://pensador-api.vercel.app/?term=Jesus+Cristo&max=7';

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(request));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        List<dynamic> frases = data['frases'];
        if (frases.isNotEmpty) {
          message = frases[0]['texto'];
        } else {
          message = 'Nenhuma frase encontrada.';
        }
      });
    }).catchError((error) {
      print('Ocorreu um erro ao obter os dados: $error');
    });
  }

  void onSubmit() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushNamed(RoutesPath.HOME);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário autenticado."),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário não autenticado."),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void navRegister() {
    //Navigator.push(null);
    Navigator.of(context).pushNamed(RoutesPath.REGISTER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login!',
              style: TextStyle(fontSize: 32),
            ),
            Image.asset(
              'assets/image/icon-transparente.png',
              width: 200,
              height: 200,
            ),
            Center(
              child: Text(
                message.toString(),
                style: TextStyle(fontSize: 18),
              ),
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
                  child: const Text('Entrar')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      backgroundColor: const Color.fromARGB(
                          255, 164, 168, 227), // Define a cor de fundo do botão
                      padding: const EdgeInsets.symmetric(vertical: 16.0)),
                  onPressed: navRegister,
                  child: const Text('Registrar-se')),
            )
          ],
        ),
      ),
    );
  }
}
