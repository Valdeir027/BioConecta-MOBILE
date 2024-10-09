import 'package:bio_conecta/src/constance/config.dart';
import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:bio_conecta/src/pages/book/addBook.dart';

import 'package:bio_conecta/src/pages/login_page.dart';
import 'package:bio_conecta/src/pages/navigator_page.dart';
import 'package:bio_conecta/src/pages/register_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserTokenProvider())
    ],
    child: const MainApp(),),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BioConecta",
      
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: LocalConfig().primaryColor ,brightness: Brightness.dark)
      ),// Tema escuro
      themeMode: ThemeMode.system, // Usa o tema do sistema
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: LocalConfig().primaryColor ,brightness: Brightness.light)
      ),
     initialRoute: '/login',
     routes: {
      '/home':(context) => const NavigatorPage(),
      '/login': (context) => const LoginPage(),
      '/register':(context) => const RegisterPage(),
      '/addBook':(context) => const AddBook(),
     },
    );
  }
}
