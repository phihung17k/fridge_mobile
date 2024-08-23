import 'package:flutter/widgets.dart';

class BlocProvider<T> extends InheritedWidget {
  final T bloc;

  const BlocProvider({super.key, required this.bloc, required super.child});

  static T? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>()?.bloc;
  }

  static T of<T>(BuildContext context) {
    final BlocProvider<T>? provider = maybeOf(context);
    assert(provider != null, 'ERROR: $T is not found in context');
    return provider!.bloc;
  }

  @override
  bool updateShouldNotify(covariant BlocProvider<T> oldWidget) {
    return oldWidget.bloc != bloc;
  }
}
