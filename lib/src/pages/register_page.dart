import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  Future<void> fechUser() async {

    if(_password1Controller.text == _password2Controller.text){

    Dio dio = Dio();
    var data = {
        "cpf": _cpfController.text,
        "nome": _nomeController.text,
        "email": _emailController.text,
        "senha": _password1Controller.text
      };
    Response response = await dio.post("http://ec2-18-228-44-147.sa-east-1.compute.amazonaws.com/api/user/register/", data: data);
    if (response.statusCode == 201) {
      // ignore: unused_local_variable, use_build_context_synchronously
      final tokenProvider = Provider.of<UserTokenProvider>(context, listen: false).setToken(response.data["auth_token"]);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/home');
      
    }
    } 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre-se"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10),
            child: Form(
              
              child: Column(
              children: [
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  inputFormatters: [
                          MaskedInputFormatter('000-000-000-00')
                  ],
                  decoration: const InputDecoration(
                    labelText: "cpf", border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _nomeController,
                  decoration: const  InputDecoration(
                    labelText: "Nome completo", border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _emailController,
                  decoration:  const InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _password1Controller,
                  obscureText: true,
                  decoration:  const InputDecoration(
                    
                    labelText: "Senha", border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _password2Controller,
                  obscureText: true,
                  decoration:  const InputDecoration(
                    labelText: "Confirmar senha", border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: fechUser, child: const Text("cadastrar"))
              ],
            )),
          )
        ],
      )
    );
  }
}