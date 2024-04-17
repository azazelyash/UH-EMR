import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final int index;
  final Widget widget;

  const FadeAnimation({super.key, required this.index, required this.widget});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 50), // Increased duration for smoother rendering
      );

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: index * 5), // Adjusted delay formula
      duration: tween.duration,
      tween: tween,
      child: widget,
      builder: (context, value, child) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: child,
      ),
    );
  }
}
