import 'package:bio_conecta/src/components/estente_dropdown_itens.dart';
import 'package:bio_conecta/src/repositories/book_respository.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController _tituloControler = TextEditingController();
  int _estateId = 0;
  final TextEditingController _autorControler = TextEditingController();
  final TextEditingController _descricaoControler = TextEditingController();

  Future<List<DropdownMenuItem<int>>> _getDropdownItems() async {
    return await bookDropdownMenuItens(context);
  }

  Future<void> _cadastrar() async {
    BookRespository repository = BookRespository();
    await repository.create(
      context,
      _tituloControler.text,
      _autorControler.text,
      _estateId,
      _descricaoControler.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Livro"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _tituloControler,
                decoration: const InputDecoration(
                  labelText: "Título",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<DropdownMenuItem<int>>>(
                future: _getDropdownItems(), // Chama a função que retorna os itens
                builder: (BuildContext context, AsyncSnapshot<List<DropdownMenuItem<int>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}'); // Mostra um erro, se houver
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhum item encontrado'); // Mostra mensagem se não houver dados
                  }

                  // Se os dados foram carregados corretamente
                  return DropdownButtonFormField<int>(
                    onChanged: (value) {
                      setState(() {
                        _estateId = value ?? 0; // Atualiza _estateId
                      });
                    },
                    items: snapshot.data!, // Usa os dados carregados
                    decoration: const InputDecoration(
                      labelText: "Estante",
                      border: OutlineInputBorder(),
                    ),
                    value: _estateId != 0 ? _estateId : null, // Define valor inicial como null
                  );
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _autorControler,
                decoration: const InputDecoration(
                  labelText: "Autor",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 5,
                controller: _descricaoControler,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Descrição",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _cadastrar,
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
