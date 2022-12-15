import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intexgram/Screens/authorization.dart';
import 'package:intexgram/Screens/main_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthorizationPage(),
    );
  }
}
