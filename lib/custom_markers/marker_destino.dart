import 'package:flutter/material.dart';

class MarkerDestino1Painter extends CustomPainter {
  final String description;
  final String metros;

  MarkerDestino1Painter(this.description, this.metros);
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

    // Sombra
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Caja Blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja Negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar Textos
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      text: metros,
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70,
      );

    textPainter.paint(canvas, Offset(0, 35));

    // Minutos
    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'Km',
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
      );
    textPainter.paint(canvas, Offset(20, 67));

    // Mi Ubicacion
    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: this.description,
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...',
    )..layout(
        maxWidth: size.width - 100,
      );

    textPainter.paint(canvas, Offset(90, 35));
  }

  @override
  bool shouldRepaint(MarkerDestino1Painter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerDestino1Painter oldDelegate) => false;
}
