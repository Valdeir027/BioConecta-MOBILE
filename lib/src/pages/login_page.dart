import 'dart:convert';

import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
    bool _isLoadingPage = true;
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
            // ignore: use_build_context_synchronously
            Provider.of<UserTokenProvider>(context, listen: false).setToken(respponseBody['token']);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            _showOverlayMessage("Usuário ou senha inválidos");
            _cpfController.clear();
            _passwordController.clear();
          }
        } catch (e) {
          _showOverlayMessage("Erro ao fazer login");
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
          padding: const EdgeInsets.all(16.0),
          color: Colors.red[400],
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  void _checkToken() async {
    final tokenProvider = Provider.of<UserTokenProvider>(context, listen: false);
    await tokenProvider.loadToken(); // Carregar o token do armazenamento local
    if (tokenProvider.token!= "") {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacementNamed('/home');
        
    } else {
      setState(() {
        _isLoadingPage = false;
      });
    }
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingPage ? const Center(child: CircularProgressIndicator(),)
      :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
                    width: 80,
              height: 80,
                    child: Hero( 
                           tag: 'Icon', 
                           child: Image.asset('assets/images/icon.png',fit: BoxFit.cover,),
                           ),
            ),
          ),
          Center(
            child: SizedBox(
            width: 200,
            height: 30,
            child:Hero(tag: "Logo",
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,)),
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
                      decoration: const InputDecoration(
                        labelText: "CPF",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(height: 5,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          iconSize: 16,
                          icon: Icon(_isPasswordVisible? Icons.visibility : Icons.visibility_off, color: const Color(0xFF37ab98)),
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
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color(0xFF37ab98))
                      ), 
                    child: _isLoading 
                    ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                    ): const Text("Login", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 5,),
          Center(
            child: GestureDetector(
              child: const Text("Cadastre-se aqui", style: TextStyle(color: Colors.grey),), 
              onTap: () =>{
                Navigator.of(context).pushNamed("/register")
              },
            )
          ),
          const Spacer(),
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