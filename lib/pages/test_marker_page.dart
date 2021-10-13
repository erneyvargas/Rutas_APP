import 'package:flutter/material.dart';
import 'package:rutas_app/custom_markers/marker_destino.dart';
import 'package:rutas_app/custom_markers/marker_inicio.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerDestino1Painter(
              "kdkdkkd, ",
              "2500",
            ),
          ),
        ),
      ),
    );
  }
}

class MarkerDestinoPainter {}
