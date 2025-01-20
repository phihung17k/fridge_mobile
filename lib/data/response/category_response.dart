class CategoryResponse {
  final int id;
  final String name;
  final String? localName;
  final String? description;

  const CategoryResponse({
    required this.id,
    required this.name,
    this.localName,
    this.description,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'localName': String? localName,
        'description': String? description
      } =>
        CategoryResponse(
          id: id,
          name: name,
          localName: localName,
          description: description,
        ),
      _ => throw const FormatException('Fail to load category'),
    };
  }
}
