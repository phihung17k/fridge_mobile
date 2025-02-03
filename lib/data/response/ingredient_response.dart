import 'package:fridge_mobile/data/response/category_response.dart';

class IngredientResponse {
  final String id;
  final String name;
  final String? localName;
  final String? description;
  final String? imageUrl;
  final CategoryResponse category;

  const IngredientResponse({
    required this.id,
    required this.name,
    this.localName,
    this.description,
    this.imageUrl,
    required this.category,
  });

  factory IngredientResponse.fromJson(Map<String, dynamic> json) {
    return IngredientResponse(
      id: json['id'],
      name: json['name'],
      localName: json['localName'],
      description: json['description'],
      imageUrl: json['image'],
      category: CategoryResponse.fromJson(json['category']),
    );
  }
}
