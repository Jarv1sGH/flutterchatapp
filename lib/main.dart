import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/firebase_options.dart';
import 'package:flutterchatapp/services/auth/auth_middleware.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return AuthService();
      },
      child: const MyApp(),
    ),
  );
}

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: darkTheme,
        home: const AuthMiddleware());
  }
}
