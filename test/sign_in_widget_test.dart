import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login - Campos de email e senha vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    final loginButton = find.text('Entrar');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Usuário autenticado.'), findsNothing);
    expect(find.text('Usuário não autenticado.'), findsNothing);
  });
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              'Login!',
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: const Text('Registrar-se')),
            )
          ],
        ),
      ),
    );
  }
}
