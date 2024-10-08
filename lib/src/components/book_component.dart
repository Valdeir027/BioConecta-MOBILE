import 'package:flutter/material.dart';
import 'package:bio_conecta/src/models/book.dart';


class BookWidget extends StatefulWidget {
  final Book book;
  const BookWidget({super.key, required this.book});

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> { // Inicializa img como uma string vazia

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,  // Remover qualquer margem externa
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),  // Remover arredondamento das bordas
      ),
      child: Stack(
        children: [
          // Imagem de fundo da capa do livro
          if(widget.book.img != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Mantém o arredondamento em 0
                child: Image.network(
                  widget.book.img?? "", // Usa a variável img corretamente
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center();
                  },
                ),
              ),
            ),
          // Degradê sobre a imagem
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Mantém o arredondamento em 0
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0, 0.60],
                ),
              ),
            ),
          ),
          // Conteúdo com as informações do livro
          Padding(
            padding: const EdgeInsets.all(8.0),  // Ajuste do padding para alinhar bem
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag:'book_${widget.book.id}',
                  child: Text(
                    widget.book.titulo ?? 'Sem título',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (widget.book.subtitulo != null)
                  Text(
                    widget.book.subtitulo!,
                    softWrap: false,  
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                      
                    ),
                  ),
                // const SizedBox(height: 1.0),  // Pequeno espaçamento
                Text(
                  widget.book.autor ?? 'Desconhecido',
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}