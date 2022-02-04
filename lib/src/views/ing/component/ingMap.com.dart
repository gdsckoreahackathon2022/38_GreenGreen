import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:provider/provider.dart';

class MapComponent extends StatelessWidget {
  MapComponent({Key? key}) : super(key: key);

  GoogleMapController? controller;

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.556797, 126.923703),
    zoom: 16.5,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<PloggingProvider>(builder: (context, provider, child) {
      return GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          provider.initMapController(controller);
        },
        zoomControlsEnabled: false,
        buildingsEnabled: false,
      );
    });
  }
}
