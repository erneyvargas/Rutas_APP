import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors, Offset;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/helpers/helpers.dart';
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
    color: Colors.transparent,
  );

  Polyline _miRutaDestino = new Polyline(
    polylineId: PolylineId("mi_ruta_destino"),
    width: 4,
    color: Colors.black87,
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
      yield* this._onNuevaUbicacion(event);
    } else if (event is OnMarcarRecorrido) {
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRutaInicioDestino) {
      yield* this._onCrearRutaInicioDestino(event);
    }
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }

    List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    // A??adir polyline al state
    final currentPolynes = state.polylines;
    currentPolynes['mi_ruta'] = this._miRuta;
    yield state.copyWith(polylines: currentPolynes);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    if (!state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    } else {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }

    // A??adir polyline al state
    final currentPolynes = state.polylines;
    currentPolynes['mi_ruta'] = this._miRuta;
    yield state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polylines: currentPolynes,
    );
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion) {
      //Mover la camara para seguir la ubicacion
      this.moverCamara(this._miRuta.points[this._miRuta.points.length - 1]);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }

  Stream<MapaState> _onCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event) async* {
    this._miRutaDestino =
        this._miRutaDestino.copyWith(pointsParam: event.rutaCoordenadas);

    final currentPolylines = state.polylines;
    currentPolylines["mi_ruta_destino"] = this._miRutaDestino;

    //final iconInicio = await getAssetImageMarker();
    final iconInicio = await getMarkerInicioIcon(event.duracion);

    // final iconDestino = await getNetworkImageMarker();
    final iconDestino =
        await getMarkerDestinoIcon(event.nombreDestino, event.distancia);
    // Marcadores
    final markerInicio = new Marker(
        anchor: Offset(0.0, 1.0),
        markerId: MarkerId("inicio"),
        icon: iconInicio,
        //position: event.rutaCoordenadas[0],
        position: event.rutaCoordenadas[event.rutaCoordenadas.length - 1],
        infoWindow: InfoWindow(
          title: "Mi Ubicacion",
          snippet: "Duarcion: ${event.duracion}",
        ));

    final markerDestino = new Marker(
        anchor: Offset(0.1, 0.9),
        markerId: MarkerId("destino"),
        position: event.rutaCoordenadas[0],
        icon: iconDestino,
        infoWindow: InfoWindow(
          title: event.nombreDestino,
          snippet: "Distancia: ${event.distancia}",
        ));

    final newMarkers = {...state.markers};
    newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerDestino;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      //_googleMapController.showMarkerInfoWindow(MarkerId("inicio"));
      //_googleMapController.showMarkerInfoWindow(MarkerId("destino"));
    });

    yield state.copyWith(
      polylines: currentPolylines, markers: newMarkers,
      //Marcadores perzonalizados
    );
  }
}
