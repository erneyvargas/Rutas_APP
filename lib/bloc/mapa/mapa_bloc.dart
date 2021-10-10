import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/themes/uber_maps_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());

  GoogleMapController _googleMapController;

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
      print("Mapa Listo");
      yield state.copyWith(mapaListo: true);
    }
  }
}
