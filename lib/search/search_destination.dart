// implementacion de un search delegate

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:rutas_app/models/search_result.dart';
import 'package:rutas_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SerachResult> {
  // sobreescribe el datafield
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximedad;
  SearchDestination(this.proximedad)
      : this.searchFieldLabel = "Buscar...",
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, SerachResult(cancelo: true)));
  }

  @override
  Widget buildResults(BuildContext context) {
    this._trafficService.getResuladosPorQuery(this.query.trim(), proximedad);
    return Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Colocar ubicacion Manualemnete"),
          onTap: () {
            this.close(context, SerachResult(cancelo: false, manual: true));
          },
        )
      ],
    );
  }
}
