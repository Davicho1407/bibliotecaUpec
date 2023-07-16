import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/notifications/firebase_api.dart';
import 'package:upec_library_bloc/pages/inicio.dart';
import 'package:animate_do/animate_do.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Made_tommy',
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            body: FadeIn(duration: Duration(seconds: 3), child: InicioPage())));
  }
}
