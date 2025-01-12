class IngredientResponse {
  final String id;
  final String? name;
  final String? localName;
  final String? description;
  final String? imageUrl;

  IngredientResponse({
    required this.id,
    this.name,
    this.localName,
    this.description,
    this.imageUrl,
  });

  factory IngredientResponse.fromJson(Map<String, dynamic> json) {
    return IngredientResponse(
      id: json['id'],
      name: json['name'],
      localName: json['localName'],
      description: json['description'],
      imageUrl: json['image'],
    );
  }
}
