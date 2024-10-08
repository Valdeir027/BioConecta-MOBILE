import 'package:bio_conecta/src/pages/homePage.dart';
import 'package:bio_conecta/src/pages/perfilPage.dart';
import 'package:bio_conecta/src/pages/estantePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
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
        onPageChanged: (_) {
          print("mexiaqui oh");
          setState(() {
            _currentIndex = _;
          });
        },
        children: const [
          HomePage(),
          PerfilPage(),
          EstantePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF37ab98),
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
