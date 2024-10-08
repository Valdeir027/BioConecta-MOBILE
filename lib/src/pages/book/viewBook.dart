import 'package:bio_conecta/src/models/book.dart';
import 'package:flutter/material.dart';

class Viewbook extends StatefulWidget {
  final Book book;
  const Viewbook({super.key, required this.book});

  @override
  State<Viewbook> createState() => _ViewbookState();
}

class _ViewbookState extends State<Viewbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child:Text(widget.book.titulo!),
          ),
      ]
      ),
    );
  }
}