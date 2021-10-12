// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromMap(jsonString);

import 'dart:convert';

class TrafficResponse {
  TrafficResponse({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  List<GeocodedWaypoint> geocodedWaypoints;
  List<Route> routes;
  String status;

  factory TrafficResponse.fromJson(String str) =>
      TrafficResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrafficResponse.fromMap(Map<String, dynamic> json) => TrafficResponse(
        geocodedWaypoints: List<GeocodedWaypoint>.from(
            json["geocoded_waypoints"].map((x) => GeocodedWaypoint.fromMap(x))),
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "geocoded_waypoints":
            List<dynamic>.from(geocodedWaypoints.map((x) => x.toMap())),
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
        "status": status,
      };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  String geocoderStatus;
  String placeId;
  List<String> types;

  factory GeocodedWaypoint.fromJson(String str) =>
      GeocodedWaypoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeocodedWaypoint.fromMap(Map<String, dynamic> json) =>
      GeocodedWaypoint(
        geocoderStatus: json["geocoder_status"],
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "geocoder_status": geocoderStatus,
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Route {
  Route({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  Polyline overviewPolyline;
  String summary;
  List<dynamic> warnings;
  List<dynamic> waypointOrder;

  factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Route.fromMap(Map<String, dynamic> json) => Route(
        bounds: Bounds.fromMap(json["bounds"]),
        copyrights: json["copyrights"],
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        overviewPolyline: Polyline.fromMap(json["overview_polyline"]),
        summary: json["summary"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
        waypointOrder: List<dynamic>.from(json["waypoint_order"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "bounds": bounds.toMap(),
        "copyrights": copyrights,
        "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
        "overview_polyline": overviewPolyline.toMap(),
        "summary": summary,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
        "waypoint_order": List<dynamic>.from(waypointOrder.map((x) => x)),
      };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Northeast northeast;
  Northeast southwest;

  factory Bounds.fromJson(String str) => Bounds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bounds.fromMap(Map<String, dynamic> json) => Bounds(
        northeast: Northeast.fromMap(json["northeast"]),
        southwest: Northeast.fromMap(json["southwest"]),
      );

  Map<String, dynamic> toMap() => {
        "northeast": northeast.toMap(),
        "southwest": southwest.toMap(),
      };
}

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Northeast.fromJson(String str) => Northeast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Northeast.fromMap(Map<String, dynamic> json) => Northeast(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Leg {
  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Step> steps;
  List<dynamic> trafficSpeedEntry;
  List<dynamic> viaWaypoint;

  factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        distance: Distance.fromMap(json["distance"]),
        duration: Distance.fromMap(json["duration"]),
        endAddress: json["end_address"],
        endLocation: Northeast.fromMap(json["end_location"]),
        startAddress: json["start_address"],
        startLocation: Northeast.fromMap(json["start_location"]),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        trafficSpeedEntry:
            List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
        viaWaypoint: List<dynamic>.from(json["via_waypoint"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "distance": distance.toMap(),
        "duration": duration.toMap(),
        "end_address": endAddress,
        "end_location": endLocation.toMap(),
        "start_address": startAddress,
        "start_location": startLocation.toMap(),
        "steps": List<dynamic>.from(steps.map((x) => x.toMap())),
        "traffic_speed_entry":
            List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
        "via_waypoint": List<dynamic>.from(viaWaypoint.map((x) => x)),
      };
}

class Distance {
  Distance({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory Distance.fromJson(String str) => Distance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Distance.fromMap(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "value": value,
      };
}

class Step {
  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
  });

  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  Polyline polyline;
  Northeast startLocation;
  String travelMode;

  factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Step.fromMap(Map<String, dynamic> json) => Step(
        distance: Distance.fromMap(json["distance"]),
        duration: Distance.fromMap(json["duration"]),
        endLocation: Northeast.fromMap(json["end_location"]),
        htmlInstructions: json["html_instructions"],
        polyline: Polyline.fromMap(json["polyline"]),
        startLocation: Northeast.fromMap(json["start_location"]),
        travelMode: json["travel_mode"],
      );

  Map<String, dynamic> toMap() => {
        "distance": distance.toMap(),
        "duration": duration.toMap(),
        "end_location": endLocation.toMap(),
        "html_instructions": htmlInstructions,
        "polyline": polyline.toMap(),
        "start_location": startLocation.toMap(),
        "travel_mode": travelMode,
      };
}

class Polyline {
  Polyline({
    this.points,
  });

  String points;

  factory Polyline.fromJson(String str) => Polyline.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Polyline.fromMap(Map<String, dynamic> json) => Polyline(
        points: json["points"],
      );

  Map<String, dynamic> toMap() => {
        "points": points,
      };
}
