import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<List<DropdownMenuItem<int>>> bookDropdownMenuItens(BuildContext context) async {
  Dio dio = Dio();
  final token = Provider.of<UserTokenProvider>(context, listen: false).token;
    
  var headers = {
    'Authorization': 'Token $token',
    'Content-Type': 'application/json',
  };
    
  Response response = await dio.get("http://ec2-18-228-44-147.sa-east-1.compute.amazonaws.com/api/book/estante/list/",options: Options(headers: headers));
  List<DropdownMenuItem<int>> itens = [];
  if (response.data  != 0) {
    for (var i in response.data){
      itens.add(DropdownMenuItem<int>(child:Text(i["nome"]), value: i["id"],));
    }
  }
  


  return itens;
 }