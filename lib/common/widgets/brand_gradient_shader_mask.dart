import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class BrandGradientShaderMask extends StatelessWidget {
  const BrandGradientShaderMask({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          LinearGradient(colors: brandGradientColorList, stops: const [
        0.0,
        0.05,
        0.9,
      ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({required this.dimension, super.key});

  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image(
        width: dimension,
        height: dimension,
        image: const AssetImage('assets/images/stars.png'),
      ),
    );
  }
}
