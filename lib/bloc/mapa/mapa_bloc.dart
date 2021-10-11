import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/themes/uber_maps_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());

  //Controlador del mapa
  GoogleMapController _googleMapController;

  // Polylines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId("mi_ruta"),
    width: 4,
  );

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._googleMapController = controller;
      this._googleMapController.setMapStyle(jsonEncode(uberMapTheme));

      //Cambiar el estilo del mapa

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng latLng) {
    final cameraUpdate = CameraUpdate.newLatLng(latLng);
    this._googleMapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapaListo) {
      yield state.copyWith(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      // Listado de todos los puntos para la ruta
      // Se extrae los puntos con el operador spreed ...
      List<LatLng> points = [...this._miRuta.points, event.ubicacion];
      this._miRuta = this._miRuta.copyWith(pointsParam: points);

      // Añadir polyline al state
      final currentPolynes = state.polylines;
      currentPolynes['mi_ruta'] = this._miRuta;

      // Emitir el nuevo estado
      yield state.copyWith(polylines: currentPolynes);
    }
  }
}
