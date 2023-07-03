import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks/firebase_options.dart';
import 'package:my_tasks/routes/routes.path.dart';
import 'package:my_tasks/screens/home.screen.dart';
import 'package:my_tasks/screens/profile.screen.dart';
import 'package:my_tasks/screens/register.screen.dart';
import 'package:my_tasks/screens/sign_in.screen.dart';
import 'package:my_tasks/screens/task_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      RoutesPath.SIGNIN: (context) => const SignInScreen(),
      RoutesPath.PROFILE: (context) => const ProfileScreen(),
      RoutesPath.REGISTER: (context) => const RegisterScreen(),
      RoutesPath.HOME: (context) => const Home(),
      RoutesPath.TASKFORMSCREEN: (context) => const TaskFormScreen(),
    });
  }
}
