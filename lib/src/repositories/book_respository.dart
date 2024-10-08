import 'package:bio_conecta/src/controllers/token_provider.dart';
import 'package:bio_conecta/src/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class BookRespository {
  final Dio dio = Dio();
  
  String baseUrl = "http://ec2-18-228-44-147.sa-east-1.compute.amazonaws.com/api/";
  

  Future<List<Book>> all(BuildContext context) async {
    final token = Provider.of<UserTokenProvider>(context, listen: false).token;
    
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    Response response =  await dio.get("${baseUrl}book/list/",options: Options(
      headers: headers
    ));
    List<Book> books =[];
    for (var i in response.data) {
      books.add(Book.fromJson(i));
    }
    return books;
  }
  Future<Book> create(BuildContext context, String titulo, String autor, int estanteId, String descricao) async {
    final token = Provider.of<UserTokenProvider>(context, listen: false).token;
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    var data = {
        "titulo": titulo,
        "autor": autor,
        "estante_id": estanteId,
        "descricao": descricao
      };
    Response response =  await dio.post("${baseUrl}book/",
    data: data,
    options: Options(
      headers: headers
    ));

    return Book.fromJson(response.data);
  }
}