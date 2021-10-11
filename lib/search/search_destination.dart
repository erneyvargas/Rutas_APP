// implementacion de un search delegate

import 'package:flutter/material.dart';
import 'package:rutas_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SerachResult> {
  // sobreescribe el datafield
  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = "Buscar...";

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
