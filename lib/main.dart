import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/locator_service.dart';
import 'Presentation/Routes/router.gr.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAuth.instance.signOut();
  // FirebaseAuth.instance.currentUser!.delete();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final flutterRouter = serverLocator<FlutterRouter>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Palette.statusBarColor,
      ),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: flutterRouter.delegate(),
      routeInformationParser: flutterRouter.defaultRouteParser(),
    );
  }
}
