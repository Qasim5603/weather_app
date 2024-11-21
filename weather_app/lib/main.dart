import 'package:weather_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA5GXWV2cgSNaUAPSeYIR8cgTRVRWBQwhY",
        authDomain: "testing-weather-app.firebaseapp.com",
        projectId: "testing-weather-app",
        storageBucket: "testing-weather-app.appspot.com",
        messagingSenderId: "897409329818",
        appId: "1:897409329818:web:72148feb043a023768cd23",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
