part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

// Clase que esta pendiente si la ubicacion cambia
class OnUbicacionCambio extends MiUbicacionEvent {
  final LatLng ubicacion;
  OnUbicacionCambio(this.ubicacion);
}
