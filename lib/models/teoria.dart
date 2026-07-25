class Teoria {
  final String id;
  final String codigoTema;
  final String materia;
  final String titulo;
  final String contenidoMarkdown;
  final String formulaClave;
  final String videoUrl;

  Teoria({
    required this.id,
    required this.codigoTema,
    required this.materia,
    required this.titulo,
    required this.contenidoMarkdown,
    this.formulaClave = '',
    this.videoUrl = '',
  });

  factory Teoria.fromMap(Map<String, dynamic> map) {
    return Teoria(
      id: map['id']?.toString() ?? '',
      codigoTema: map['codigo_tema']?.toString() ?? '',
      materia: map['materia']?.toString() ?? '',
      titulo: map['titulo']?.toString() ?? '',
      contenidoMarkdown: map['contenido_markdown']?.toString() ?? '',
      formulaClave: map['formula_clave']?.toString() ?? '',
      videoUrl: map['video_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo_tema': codigoTema,
      'materia': materia,
      'titulo': titulo,
      'contenido_markdown': contenidoMarkdown,
      'formula_clave': formulaClave,
      'video_url': videoUrl,
    };
  }
}
