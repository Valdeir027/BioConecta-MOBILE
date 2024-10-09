class Book {
  int? id;
  String? titulo;
  String? subtitulo;
  String? img;
  String? autor;
  int? estanteId;
  String? descricao;

  Book(
      {this.id,
      this.titulo,
      this.subtitulo,
      this.autor,
      this.estanteId,
      this.descricao,
      this.img});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    autor = json['autor'];
    estanteId = json['estante_id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['subtitulo'] = subtitulo;
    data['autor'] = autor;
    data['estante_id'] = estanteId;
    data['descricao'] = descricao;
    return data;
  }
}