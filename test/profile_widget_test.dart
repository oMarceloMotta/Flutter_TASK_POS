import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_tasks/components/list_task.dart';
import 'package:my_tasks/screens/profile.screen.dart';

void main() {
  testWidgets('Perfil', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
    expect(find.text('Perfil'), findsOneWidget);

    // Verifique se o ícone de pessoa está presente dentro do CircleAvatar
  });
  testWidgets('Perfil - CircleAvatar without image',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    // Verifique se o CircleAvatar está presente
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Verifique se o ícone de pessoa está presente dentro do CircleAvatar
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? const Icon(
                      Icons.person,
                      size: 80,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Selecionar Imagem"),
            )
          ],
        ),
      ),
    );
  }
}
