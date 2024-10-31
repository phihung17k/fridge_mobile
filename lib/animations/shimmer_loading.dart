import 'package:flutter/widgets.dart';

import 'sliding_gradient_transform.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with TickerProviderStateMixin {
  late AnimationController shimmerController;
  late AnimationController fadeController;

  @override
  void initState() {
    super.initState();

    shimmerController = AnimationController(
        vsync: this,
        lowerBound: -0.5,
        upperBound: 0.9,
        duration: const Duration(milliseconds: 2500))
      ..repeat();

    fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      fadeController.forward();
      return FadeTransition(
        opacity: fadeController,
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: shimmerController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              // stops: red, green, blue | 0.1, 0.2, 0.3
              // => red: 0.0 -> <0.1
              // => green: 0.1 -> <0.2
              // => blue: 0.2 -> <1
              colors: const [
                Color.fromARGB(255, 227, 227, 245),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 227, 227, 245),
              ],
              stops: const [
                0.1,
                0.2,
                0.3,
              ],
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              tileMode: TileMode.clamp,
              transform: SlidingGradientTransform(slidePercent: shimmerController.value),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    shimmerController.dispose();
    fadeController.dispose();
    super.dispose();
  }
}
