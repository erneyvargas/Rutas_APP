import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/models/traffic_response.dart';

class TrafficService {
  // Singleton
  TrafficService._privateConstuctor();
  static final TrafficService _instance = TrafficService._privateConstuctor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  final _baseUrl = "https://maps.googleapis.com/maps/api";
  final _apyKey = "AIzaSyAXjrjXYVm0d282RPGjheCR8yNpmFZMLQk";

  Future<TrafficResponse> geoCoordsInicioDestino(
      LatLng inicio, LatLng destino) async {
    print("inicio: $inicio");
    print("destino: $destino");

    //final coordString =
    //"${inicio.latitude},${inicio.longitude};${destino.latitude},${destino.longitude}";

    final url = "${this._baseUrl}/directions/json";

    final resp = await this._dio.get(url, queryParameters: {
      'destination': '${inicio.latitude},${inicio.longitude}',
      'origin': "${destino.latitude},${destino.longitude}",
      'key': this._apyKey,
      'language': 'es',
    });
    final data = TrafficResponse.fromMap(resp.data);
    return data;
  }
}
