part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnSeguirUbicacion extends MapaEvent {}

class OnCrearRutaInicioDestino extends MapaEvent {
  final List<LatLng> rutaCoordenadas;
  final String distancia;
  final String duracion;
  final String nombreDestino;

  OnCrearRutaInicioDestino(
      this.rutaCoordenadas, this.distancia, this.duracion, this.nombreDestino);
}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);
}

class OnNuevaUbicacion extends MapaEvent {
  // Recibe la nueva ubicacion
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);
}
