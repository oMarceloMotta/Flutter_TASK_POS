import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Registro - Verificar elementos na tela',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

    // Verifique se a imagem está presente
    expect(find.byType(Image), findsOneWidget);

    // Verifique se o texto 'Registrar-se!' está presente
    expect(find.text('Registrar-se!'), findsOneWidget);

    // Verifique se o campo de texto de e-mail está presente
    expect(find.byType(TextField).at(0), findsOneWidget);

    // Verifique se o campo de texto de senha está presente
    expect(find.byType(TextField).at(1), findsOneWidget);

    // Verifique se o botão 'Registra-se' está presente
    expect(find.text('Registra-se'), findsOneWidget);

    // Verifique se o botão 'Já tenho conta' está presente
    expect(find.text('Já tenho conta'), findsOneWidget);
  });

  testWidgets('Registro - Navegar para a tela de login',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

    // Verifique se o botão 'Já tenho conta' está presente
    final loginButton = find.text('Já tenho conta');
    expect(loginButton, findsOneWidget);

    // Toque no botão 'Já tenho conta'
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verifique se a tela de login foi exibida (verifique se ocorreu uma navegação de volta)
    expect(find.byType(RegisterScreen), findsNothing);
  });
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  onPressed: () {},
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
