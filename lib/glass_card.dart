import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'oc_liquid.dart';
// import removed: liquid_glass_renderer not used directly here after OCLiquid overlay

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 38,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // Strong frosted pass (iOS-like) using system backdrop blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox.shrink(),
            ),
          ),
          // OCLiquid overlay to add wet, uniform liquid layer
          Positioned.fill(
            child: OCLiquid(
              blur: 1,
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(borderRadius),
              child: const SizedBox.shrink(),
            ),
          ),

          // Content padding
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}
