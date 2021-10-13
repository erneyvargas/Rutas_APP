// implementacion de un search delegate

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:rutas_app/models/search_response.dart';
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
    return this._construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
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
    return this._construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    if (this.query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: this
          ._trafficService
          .getResuladosPorQuery(this.query.trim(), proximedad),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final lugares = snapshot.data.results;

        if (lugares.length == 0) {
          ListTile(
            title: Text('No hay Resultados con $query'),
          );
        }
        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (_, i) => Divider(),
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.name),
              subtitle: Text(lugar.formattedAddress),
              onTap: () {
                print(lugar);
              },
            );
          },
        );
      },
    );
  }
}
