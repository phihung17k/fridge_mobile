import 'package:flutter/material.dart';

class ProxyDecorator extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const ProxyDecorator({super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        // animation's effect for reorder itemw
        return Material(
          color: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
    ;
  }
}
