class PostModel {

  final String id;
  final String nombre;
  final String mensaje;
  final String categoria;
  final int likes;

  PostModel({
    required this.id,
    required this.nombre,
    required this.mensaje,
    required this.categoria,
    required this.likes,
  });

  factory PostModel.fromMap(
    Map<String, dynamic> data,
    String id,
  ) {

    return PostModel(
      id: id,
      nombre: data['nombre'] ?? '',
      mensaje: data['mensaje'] ?? '',
      categoria: data['categoria'] ?? '',
      likes: data['likes'] ?? 0,
    );
  }
}