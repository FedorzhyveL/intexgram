import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intexgram/locator_service.dart';
import 'Presentation/Routes/router.gr.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final flutterRouter = serverLocator<FlutterRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: flutterRouter.delegate(),
      routeInformationParser: flutterRouter.defaultRouteParser(),
    );
  }
}
