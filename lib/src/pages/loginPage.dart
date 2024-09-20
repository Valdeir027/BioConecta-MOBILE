import 'dart:convert';

import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _cpfController =  TextEditingController();
    final TextEditingController _passwordController =  TextEditingController();

    bool _isLoading = false;
    bool _isPasswordVisible = true;

    Future<void> _login() async {
      if (_isLoading) return;
      setState(() {
        _isLoading = true;
      });

      var body = {
            'username': _cpfController.text.replaceAll(RegExp(r'[^0-9]'), ''),
            'password': _passwordController.text,
          };

      try {
          final response = await http.post(Uri.parse('http://ec2-18-228-44-147.sa-east-1.compute.amazonaws.com/api/api-token-auth/'), body: body);
          final respponseBody = jsonDecode(response.body);
          if (response.statusCode == 200) {
            Provider.of<UserTokenProvider>(context, listen: false).setToken(respponseBody['token']);
            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            _showOverlayMessage("Usuário ou senha inválidos");
            _cpfController.clear();
            _passwordController.clear();
          }
        } catch (e) {
          _showOverlayMessage("Erro ao fazer login");
          print(e);
        } finally {
          setState(() {
            _isLoading = false; // Desativa o estado de carregamento
          });
        }      
    }

    void _showOverlayMessage(String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: 10.0,
      right: 10.0,
      child: Material(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.red[400],
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Container(
              child: Image.asset('assets/images/icon.png',fit: BoxFit.cover,),
              width: 80,
              height: 80,
            ),
          ),
          Center(
            child: Container(
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,),
            width: 200,
            height: 30,
            ),
          ),
          Container(height: 10,),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _cpfController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      inputFormatters: [
                        MaskedInputFormatter('000-000-000-00')
                      ],
                      decoration: InputDecoration(
                        labelText: "CPF",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(height: 5,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          iconSize: 16,
                          icon: Icon(_isPasswordVisible? Icons.visibility : Icons.visibility_off, color: Color(0xFF37ab98)),
                          onPressed: () =>{
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            })
                          },
                          )
                      ),
                      obscureText: _isPasswordVisible,
                    ),
                    Container(height: 10,),
                    ElevatedButton(
                      onPressed: _isLoading?null:_login, 
                    child: _isLoading 
                    ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                    ): Text("Login", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF37ab98))
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 5,),
          Center(
            child: GestureDetector(
              child: Text("Cadastre-se aqui", style: TextStyle(color: Colors.grey),), 
              onTap: () =>{
                Navigator.of(context).pushReplacementNamed("/register")
              },
            )
          ),
          Spacer(),
          Text("@24.09.0",style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10
            )
          ,),
          Container(height: 15,)
        ],
      ),
    );
  }

}