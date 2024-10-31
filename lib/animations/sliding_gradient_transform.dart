import 'package:flutter/widgets.dart';

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  /// set x Axis: (row, col) = (0, 3) || index in Matrix4 = 12
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
    // return Matrix4.identity()..translate(bounds.width * slidePercent);
    return Matrix4.identity()..setEntry(0, 3, bounds.width * slidePercent);
  }
}
