
import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:bio_conecta/src/pages/homePage.dart';
import 'package:bio_conecta/src/pages/loginPage.dart';
import 'package:bio_conecta/src/pages/navigatorPage.dart';
import 'package:bio_conecta/src/pages/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserTokenProvider())
    ],
    child: MainApp(),),
  );
}

class MainApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BioConecta",
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF37ab98),brightness: Brightness.dark)
      ),// Tema escuro
      themeMode: ThemeMode.system, // Usa o tema do sistema
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF37ab98),brightness: Brightness.light)
      ),
     initialRoute: '/login',
     routes: {
      '/home':(context) => NavigatorPage(),
      '/login': (context) => const LoginPage(),
      '/register':(context) => const RegisterPage()
     },
    );
  }
}
