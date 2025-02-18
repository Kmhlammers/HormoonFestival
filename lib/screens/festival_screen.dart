import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FestivalScreen extends StatelessWidget {
  final String title;

  const FestivalScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // The image background
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/HMF_plattegrond_1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Path visualization with GestureDetector
                  GestureDetector(
                    onTap: () => context.go('/festival/hormonen'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  final Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.3) // Red overlay to visualize the path
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
