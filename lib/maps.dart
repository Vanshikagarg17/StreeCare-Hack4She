import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _mapController = Completer();

  final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-20.3000, -40.2990),
    zoom: 14.0000,
  );
  String key = "key=AIzaSyBrK5fmXcOwsKWm9xlSycoXiTDKq8IOQsE";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SearchMapPlaceWidget(
      apiKey: key,
      // The language of the autocompletion
      language: 'en',
      // The position used to give better recomendations. In this case we are using the user position
      //location: userpo.coordinates,
      //radius: 30000,
      onSelected: (Place place) async {
        final geolocation = await place.geolocation;

        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
        final GoogleMapController controller = await _mapController.future;
        controller
            .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
        controller
            .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
      },
    ));
  }
}
