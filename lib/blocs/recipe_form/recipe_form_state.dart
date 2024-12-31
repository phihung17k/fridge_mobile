import 'package:equatable/equatable.dart';

class RecipeFormState extends Equatable {
  final int hour;
  final int minute;

  const RecipeFormState({
    this.hour = 0,
    this.minute = 0,
  });

  RecipeFormState copyWith({
    int? hour,
    int? minute,
  }) {
    return RecipeFormState(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  List<Object?> get props => [
        hour,
        minute,
      ];
}
