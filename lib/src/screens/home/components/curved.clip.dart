import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  const CurvedAppBar({super.key, required this.height, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, height),
      painter: CurvedPainter(),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
            TextButton(
              onPressed: () {},
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            )
          ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.transparent;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.001, size.height * 0.85, size.width * 0.05, size.height * 0.8);
    path.lineTo(size.width * 0.95, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.999, size.height * 0.85, size.width, size.height);
    // path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
