import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

  final _geloacator = new Geolocator();
  StreamSubscription<Position> _positionSubscription;

  void iniciarSeguiminto() {
    // validar la precicion de la ubicacion,
    final geoLocatorOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    this._positionSubscription =
        this._geloacator.getPositionStream(geoLocatorOptions).listen(
      (Position position) {
        print(position);
      },
    );
  }

  void cancelarSeguimiento() {
    this._positionSubscription?.cancel();
  }
}
