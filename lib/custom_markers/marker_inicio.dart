import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double circuloNegroR = 20;
    final double circuloBalncoR = 7;

    Paint paint = new Paint()..color = Colors.black;

    //Dibujar circulo negro
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      circuloNegroR,
      paint,
    );

    paint.color = Colors.white;

    //Dibujar circulo Blanco
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      circuloBalncoR,
      paint,
    );
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
