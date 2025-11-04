import 'package:flutter/material.dart';

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
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFf6fffc), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        if (type == 'Bold') const AnimatedBoldDecor(),
        if (type == 'Light') _buildLightDecor(),
        if (type == 'default') _buildDefaultDecor(),
        child,
      ],
    );
  }

  Widget _buildLightDecor() {
    return Stack(
      children: [
        Positioned(top: -100, right: -100, child: _circle(250, const Color(0xFFe6f2f0))),
        Positioned(bottom: -120, left: -80, child: _circle(200, const Color(0xFFf3fbfa))),
      ],
    );
  }

  Widget _buildDefaultDecor() {
    return Stack(
      children: [
        Positioned(top: -60, left: -40, child: _circle(120, Colors.grey.shade100)),
        Positioned(bottom: -60, right: -40, child: _circle(120, Colors.grey.shade100)),
      ],
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }
}

class AnimatedBoldDecor extends StatefulWidget {
  const AnimatedBoldDecor({super.key});

  @override
  State<AnimatedBoldDecor> createState() => _AnimatedBoldDecorState();
}

class _AnimatedBoldDecorState extends State<AnimatedBoldDecor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = Curves.easeOut.transform(_controller.value);
        return Stack(
          children: [
            Positioned(
              top: -150 + (30 * (1 - progress)),
              right: -100 + (30 * (1 - progress)),
              child: Opacity(
                opacity: progress,
                child: _circle(300, const Color(0xFFd9f3ef).withOpacity(0.8)),
              ),
            ),
            Positioned(
              bottom: -180 + (40 * (1 - progress)),
              left: -120 + (40 * (1 - progress)),
              child: Opacity(
                opacity: progress,
                child: _circle(320, const Color(0xFFe8f9f5).withOpacity(0.9)),
              ),
            ),
            Positioned(
              top: 200 - (20 * (1 - progress)),
              right: 50 - (20 * (1 - progress)),
              child: Opacity(
                opacity: progress,
                child: _circle(100, const Color(0xFFc5ece5).withOpacity(0.7)),
              ),
            ),
            Positioned(
              top: 60 - (15 * (1 - progress)),
              left: -80 + (15 * (1 - progress)),
              child: Opacity(
                opacity: progress,
                child: _circle(140, const Color(0xFFe0f7f4).withOpacity(0.6)),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.45,
              child: Opacity(
                opacity: progress,
                child: _circle(60, const Color(0xFFd0f0e8).withOpacity(0.5)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }
}
