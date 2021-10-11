part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;

  // Es la linea con todos sus puntos y priopiedades.
  final Map<String, Polyline> polylines;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = true,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    Map<String, Polyline> polylines,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        polylines: polylines ?? this.polylines,
      );
}
