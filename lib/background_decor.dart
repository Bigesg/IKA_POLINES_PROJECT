import 'package:flutter/material.dart';

/// A reusable background decoration widget that adapts to the page type.
///
/// Example:
/// BackgroundDecor(type: 'login', child: YourWidget())
class BackgroundDecor extends StatelessWidget {
  final Widget child;
  final String type;

  const BackgroundDecor({
    super.key,
    required this.child,
    this.type = 'default',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(color: Colors.white),

        // Dynamic background based on page type
        if (type == 'Bold') _buildBoldDecor(),
        if (type == 'Light') _buildLightDecor(),
        if (type == 'default') _buildDefaultDecor(),

        // Main content
        child,
      ],
    );
  }

  /// Login background: more decorative
  Widget _buildBoldDecor() {
    return Stack(
      children: [
        Positioned(top: -80, right: -60, child: _circle(180, const Color(0xFFd9f3ef))),
        Positioned(bottom: -100, left: -70, child: _circle(220, const Color(0xFFe8f9f5))),
        Positioned(top: 180, right: 40, child: _circle(80, const Color(0xFFc5ece5))),
      ],
    );
  }

  /// Home background: clean and simple
  Widget _buildLightDecor() {
    return Stack(
      children: [
        Positioned(top: -100, right: -100, child: _circle(250, const Color(0xFFe6f2f0))),
        Positioned(bottom: -120, left: -80, child: _circle(200, const Color(0xFFf3fbfa))),
      ],
    );
  }

  /// Default: minimal background
  Widget _buildDefaultDecor() {
    return Stack(
      children: [
        Positioned(top: -60, left: -40, child: _circle(120, Colors.grey.shade100)),
        Positioned(bottom: -60, right: -40, child: _circle(120, Colors.grey.shade100)),
      ],
    );
  }

  /// Helper for making circular shapes
  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
