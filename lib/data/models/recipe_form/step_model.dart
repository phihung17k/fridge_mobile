import 'package:equatable/equatable.dart';

class StepModel extends Equatable {
  final int? orderNumber;
  final String? content;
  final String? imagePath;

  const StepModel({
    this.orderNumber,
    this.content,
    this.imagePath,
  });

  StepModel copyWith({
    int? orderNumber,
    String? content,
    String? imagePath,
  }) {
    return StepModel(
      orderNumber: orderNumber ?? this.orderNumber,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [orderNumber];
}
