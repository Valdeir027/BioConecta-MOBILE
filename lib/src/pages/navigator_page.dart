import 'package:bio_conecta/src/constance/config.dart';
import 'package:bio_conecta/src/pages/home_page.dart';
import 'package:bio_conecta/src/pages/perfil_page.dart';
import 'package:bio_conecta/src/pages/estante_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  NavigatorPageState createState() => NavigatorPageState();
}

class NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 2;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _currentIndex = page;
          });
        },
        children: const [
          HomePage(),
          PerfilPage(),
          EstantePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: LocalConfig().primaryColor,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Perfil", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Estante", icon: Icon(Icons.menu_book)),
        ]
      ),
    );
  }
}
