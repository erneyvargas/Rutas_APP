import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SerachResult {
  final bool cancelo;
  final bool manual;
  final LatLng position;
  final String nombreDestino;
  final String description;

  SerachResult({
    @required this.cancelo,
    this.manual,
    this.position,
    this.nombreDestino,
    this.description,
  });
}
