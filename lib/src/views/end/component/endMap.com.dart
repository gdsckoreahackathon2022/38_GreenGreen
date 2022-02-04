import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:provider/provider.dart';

class Position {
  final double latitude;
  final double longitude;

  Position.fromMap(Map<String, dynamic> map)
      : latitude = map['latitude'],
        longitude = map['longitude'];
}

class EndMapComponent extends StatefulWidget {
  const EndMapComponent({Key? key}) : super(key: key);

  @override
  _EndMapComponentState createState() => _EndMapComponentState();
}

class _EndMapComponentState extends State<EndMapComponent> {
  // const EndMapComponent({Key? key}) : super(key: key);
  late PloggingProvider _ploggingProvider;

  /** 더미 데이터 */
  // final List<Position> positions = [
  //   Position.fromMap(
  //       {'latitude': 37.651669032361724, 'longitude': 127.04899659034416}),
  //   Position.fromMap(
  //       {'latitude': 37.65149064892912, 'longitude': 127.04671671273363})
  // ];
  late List<Position> walkPositions;
  late List<Position> takePositions;

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
    PloggingProvider _ploggingProvider =
        Provider.of<PloggingProvider>(context, listen: false);

    walkPositions = _ploggingProvider.walkingPathList.map((e) {
      return Position.fromMap({'latitude': e[0], 'longitude': e[1]});
    }).toList();

    takePositions = _ploggingProvider.takeTrashLocationList.map((e) {
      return Position.fromMap({'latitude': e[0], 'longitude': e[1]});
    }).toList();

    var makers = getMarkers(takePositions);
    var polylines = getPolylines(walkPositions);

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _myLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          // 중심으로 좌표 이동
          double lat;
          double long;
          if (_ploggingProvider.walkingPathList.length > 3) {
            int centerIndex =
                (_ploggingProvider.walkingPathList.length / 2).round();
            lat = _ploggingProvider.walkingPathList[centerIndex][0];
            long = _ploggingProvider.walkingPathList[centerIndex][1];
          } else {
            lat = 37.65307909584109;
            long = 127.04812755460252;
          }
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(lat, long),
                zoom: 15,
              ),
            ),
          );
        },
        /** 마커 */
        markers: makers,
        /** 경로 선 */
        polylines: polylines,
      ),
    );
  }

/** 모든 마커들 가져오기 메서드*/
  Set<Marker> getMarkers(List<Position> positions) {
    final Set<Marker> results = {};

    // BitmapDescriptor myIcon;
    // Future<BitmapDescriptor> futureMyIcon;

    setCustomMarker() {
      return BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/images/trash.png');
    }

    setCustomMarker().then((value) {
      for (var i = 0; i < positions.length; i++) {
        Marker marker = Marker(
            markerId: MarkerId('$i'),
            position: LatLng(positions[i].latitude, positions[i].longitude),
            icon: value);
        results.add(marker);
        setState(() {});
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
}
