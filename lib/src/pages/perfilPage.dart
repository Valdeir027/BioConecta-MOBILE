import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Future<void> _logout() async {
    final userProvider = Provider.of<UserTokenProvider>(context, listen: false);

    if (userProvider.token !="") {
      userProvider.clearToken();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
          onTap: () {
            _logout();
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sair"),
                      SizedBox(width: 10),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
                Container(height: 2, color: Colors.white10),
              ],
            ),
          ),
        )
          
          
        ],
      ),
    );
  }
}