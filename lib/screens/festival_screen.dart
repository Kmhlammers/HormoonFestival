import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FestivalScreen extends StatelessWidget {
  final String title;

  FestivalScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Image size from the original SVG
        final double originalWidth = 2863;
        final double originalHeight = 4533;

        // Scale factors to map the original SVG coordinates to the displayed image
        final double scaleX = constraints.maxWidth / originalWidth;
        final double scaleY = constraints.maxHeight / originalHeight;

        // Define the scaled path based on your SVG coordinates
        final Path scaledPath = Path()
          ..moveTo(1431 * scaleX, 863 * scaleY)
          ..lineTo((1431 - 356) * scaleX, 863 * scaleY)
          ..lineTo((1431 - 356 - 6) * scaleX, (863 + 371) * scaleY)
          ..lineTo((1431 - 356 - 6 - 241) * scaleX, (863 + 371 + 123) * scaleY)
          ..lineTo((1431 - 356 - 6 - 241 - 200) * scaleX, (863 + 371 + 123 - 306) * scaleY)
          ..lineTo((1431 - 356 - 6 - 241 - 200 + 165) * scaleX, (863 + 371 + 123 - 306 - 672) * scaleY)
          ..lineTo((1431 - 356 - 6 - 241 - 200 + 165 + 447) * scaleX, (863 + 371 + 123 - 306 - 672 - 259) * scaleY)
          ..lineTo((1431 - 356 - 6 - 241 - 200 + 165 + 447 + 271) * scaleX, (863 + 371 + 123 - 306 - 672 - 259 + 100) * scaleY)
          ..close();

        return Stack(
          children: [
            // The image background
            Positioned(
              top: 0, // Ensure the GestureDetector covers the image completely
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTapUp: (details) {
                  // Check if the tapped position is inside the path
                  if (scaledPath.contains(details.localPosition)) {
                    context.go('/festival/hormonen');
                  }
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/HMF_plattegrond_1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Optional for debugging path alignment
                    CustomPaint(
                      painter: PathPainter(scaledPath),
                      size: Size.infinite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PathPainter extends CustomPainter {
  final Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withAlpha(30) // Red overlay to visualize the path
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
