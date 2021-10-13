import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/helpers/debouncer.dart';
import 'package:rutas_app/models/search_response.dart';
import 'package:rutas_app/models/traffic_response.dart';

class TrafficService {
  // Singleton
  TrafficService._privateConstuctor();
  static final TrafficService _instance = TrafficService._privateConstuctor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream =>
      this._sugerenciasStreamController.stream;

  final _baseUrl = "https://maps.googleapis.com/maps/api";
  final _apyKey = "AIzaSyAXjrjXYVm0d282RPGjheCR8yNpmFZMLQk";

  Future<TrafficResponse> geoCoordsInicioDestino(
      LatLng inicio, LatLng destino) async {
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

  Future<SearchResponse> getResuladosPorQuery(
      String busqueda, LatLng proximedad) async {
    print("buscando........");
    final url = "${this._baseUrl}/place/textsearch/json";

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'location': '${proximedad.latitude},${proximedad.longitude}',
        'query': '$busqueda',
        'radius': 10000,
        'key': this._apyKey,
        'language': 'es',
      });

      final searchResponse = SearchResponse.fromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(results: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResuladosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }
}
