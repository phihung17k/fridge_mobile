import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? name;
  final String? localName;
  final String? description;

  const CategoryModel({
    this.id,
    this.name,
    this.localName,
    this.description,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? localName,
    String? description,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id];
}
