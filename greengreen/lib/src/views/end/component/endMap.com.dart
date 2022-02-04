import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Position {
  final double latitude;
  final double longitude;

  Position.fromMap(Map<String, dynamic> map)
      : latitude = map['latitude'],
        longitude = map['longitude'];
}

class EndMapComponent extends StatelessWidget {
  // const EndMapComponent({Key? key}) : super(key: key);

  /** 더미 데이터 */
  final List<Position> positions = [
    Position.fromMap(
        {'latitude': 37.651669032361724, 'longitude': 127.04899659034416}),
    Position.fromMap(
        {'latitude': 37.65149064892912, 'longitude': 127.04671671273363})
  ];

  // MapSampleState({this.positions})

  final Completer<GoogleMapController> _controller = Completer();

  /** 첫 좌표 (위도, 경도) */
  static const CameraPosition _myLocation = CameraPosition(
    target: LatLng(37.65307909584109, 127.04812755460252),
    zoom: 14.4746,
  );

  // EndMapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _myLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        /** 마커 */

        markers: getMarkers(positions),
        /** 경로 선 */
        polylines: getPolylines(positions),
      ),
    );
  }
}

/** 모든 마커들 가져오기 메서드*/
Set<Marker> getMarkers(List<Position> positions) {
  final Set<Marker> results = {};

  // BitmapDescriptor myIcon;
  // Future<BitmapDescriptor> futureMyIcon;

  setCustomMarker() {
    return BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'asset/images/trash.png');
  }

  setCustomMarker().then((value) {
    for (var i = 0; i < positions.length; i++) {
      Marker marker = Marker(
          markerId: MarkerId('$i'),
          position: LatLng(positions[i].latitude, positions[i].longitude),
          icon: value);
      results.add(marker);
    }
  });
  return results;
}

/** 마커 사이 경로선 가져오기 메서드 */
Set<Polyline> getPolylines(List<Position> positions) {
  final Set<Polyline> results = <Polyline>{};
  List<LatLng> latlngs = [];

  for (var i = 0; i < positions.length; i++) {
    latlngs.add(LatLng(positions[i].latitude, positions[i].longitude));
  }
  results.add(Polyline(
    polylineId: const PolylineId('marks'),
    visible: true,
    points: latlngs,
    color: const Color(0xff6DCA37),
  ));

  return results;
}
