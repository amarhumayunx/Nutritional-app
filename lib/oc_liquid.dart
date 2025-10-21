import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class OCLiquid extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color color;
  final BorderRadius borderRadius;

  const OCLiquid({
    super.key,
    required this.child,
    this.blur = 18,
    this.color = const Color(0x26FFFFFF),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: const SizedBox.shrink(),
          ),
          Container(color: color),
          child,
        ],
      ),
    );
  }
}
