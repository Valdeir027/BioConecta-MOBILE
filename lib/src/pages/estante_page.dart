import 'package:bio_conecta/src/components/book_component.dart';
import 'package:bio_conecta/src/pages/book/addBook.dart';
import 'package:bio_conecta/src/pages/book/viewBook.dart';
import 'package:bio_conecta/src/repositories/book_respository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EstantePage extends StatefulWidget {
  const EstantePage({super.key});

  @override
  State<EstantePage> createState() => _EstantePageState();
}

class _EstantePageState extends State<EstantePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Hero(tag: 'Icon', child: Image.asset('assets/images/icon.png', width: 50,)),
          ],),
      ),
      body: FutureBuilder(
        future: BookRespository().all(context),
         builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasError) {
            return const Center(child: Text("erro ao carregar livro"),);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text("Nenhum livro disponivel"));
          }


          List books = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // Número de colunas
                  crossAxisSpacing: 5,  // Espaçamento entre as colunas
                  mainAxisSpacing: 5,  // Espaçamento entre as linhas
                  childAspectRatio: 1.0,  // Relação de aspecto entre largura e altura
                ),
              itemCount: books.length,
               itemBuilder: (context, index) {
            
                // Adicionando um deslocamento para cada item com base no índice
                 // Deslocar alternadamente
                // Variação no deslocamento vertical
            
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Viewbook(book: books[index])));
                    },
                    child: BookWidget(book: books[index]),
                  );
               }
              ),
          );

         }),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () {
          Navigator.push(context, PageTransition(child: const AddBook(), type: PageTransitionType.bottomToTop));
        },),
      );

  }
}

