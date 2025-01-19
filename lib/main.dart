import 'package:de_talks/pages/chat_screen.dart';
import 'package:de_talks/pages/navigation.dart';
import 'package:de_talks/pages/splash_screen.dart';
import 'package:de_talks/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  // Made main async
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'De-Talks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Manjari',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 245, 245, 255),
          ),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
