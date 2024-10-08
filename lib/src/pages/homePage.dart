import 'dart:convert';

import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:bio_conecta/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  bool _isLoading = true;
  
  Future<Map<String, dynamic>> getUser() async {

    final token = Provider.of<UserTokenProvider>(context, listen: false).token;
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse("http://ec2-18-228-44-147.sa-east-1.compute.amazonaws.com/api/user/"),
      headers: headers, // Não precisa de jsonEncode aqui
    );
    

    return jsonDecode(response.body);
  } 

   @override
  void initState() {
    super.initState();
    fetchUserData();  // Chama o método para buscar os dados do usuário
  }
Future<void> fetchUserData() async {
    try {
      Map<String, dynamic> userData = await getUser();  // Espera pelos dados do usuário
      if (mounted){
      setState(() {
        user = User.fromJson(userData);  // Inicializa o objeto user
        _isLoading = false;  // Desativa o estado de carregamento
      });
      }
    } catch (e) {
      // Trate possíveis erros de conexão aqui
      print("Erro ao buscar os dados do usuário: $e");
      if (mounted){
      setState(() {
        _isLoading = false;  // Mesmo em caso de erro, desativa o carregamento
      });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset('assets/images/icon.png', width: 40, fit: BoxFit.cover,),
            Padding(padding: EdgeInsets.only(top: 15, left:0), child: Hero( tag: "Logo", child: Image.asset('assets/images/logo.png', width: 130, height: 40,fit: BoxFit.cover,)),)
          ],
        ),
      ),
      body:  _isLoading
          ? Center(child: CircularProgressIndicator())  // Mostra indicador de carregamento
          : user != null
              ? Center(child: Text("Oi ${user!.firstName}"))  // Exibe os dados do usuário
              : Center(child: Text("Erro ao carregar os dados do usuário")),  // Mensagem de erro se o user for nulo
    );
  }
}