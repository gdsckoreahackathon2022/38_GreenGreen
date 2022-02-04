import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greengreen/src/models/plogging.model.dart';
import 'package:greengreen/src/repository/location.rep.dart';

class PloggingProvider extends ChangeNotifier {
  List<double>? _myLocation;
  // 쓰레기통 위치
  final List<List<double>> _trashcanLocationList = [];
  // 쓰레기 주운 위치
  final List<List<double>> _takeTrashLocationList = [];
  final PloggingModel _plogging = PloggingModel();
  GoogleMapController? _controller;

  List<double> get myLocation => _myLocation ?? [37.556797, 126.923703];
  List<List<double>> get trashcanLocationList => _trashcanLocationList;
  List<List<double>> get takeTrashLocationList => _takeTrashLocationList;
  PloggingModel get plogging => _plogging;
  GoogleMapController get mapController => _controller!;

  final LocationRepository _locationRepository = LocationRepository();

  late Timer _timer;
  startPlogging() {
    // 플로깅 시작
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _plogging.walkTime++;
      notifyListeners();
    });
  }

  pausePlogging() {
    // 플로깅 일시중지
    _timer.cancel();
    notifyListeners();
  }

  stopPlogging() {
    // 플로깅 종료
    _timer.cancel();
    notifyListeners();
  }

  countTakeTrash(int type, int value) async {
    // 0: 플라스틱, 1: 종이, 2: 일반쓰레기, 3: 패트병, 4: 유리
    switch (type) {
      case 0:
        _plogging.plasticCount += value;
        _plogging.plasticCount =
            _plogging.plasticCount < 0 ? 0 : _plogging.plasticCount;
        break;
      case 1:
        _plogging.paperCount += value;
        _plogging.paperCount =
            _plogging.paperCount < 0 ? 0 : _plogging.paperCount;
        break;
      case 2:
        _plogging.wasteCount += value;
        _plogging.wasteCount =
            _plogging.wasteCount < 0 ? 0 : _plogging.wasteCount;
        break;
      case 3:
        _plogging.bottleCount += value;
        _plogging.bottleCount =
            _plogging.bottleCount < 0 ? 0 : _plogging.bottleCount;
        break;
      case 4:
        _plogging.glassCount += value;
        _plogging.glassCount =
            _plogging.glassCount < 0 ? 0 : _plogging.glassCount;
        break;
      default:
    }

    notifyListeners();

    // 현재 위치 저장하기
    List<double> location = await _locationRepository.getCurrentLocation();
    _takeTrashLocationList.add(location);
    print(_takeTrashLocationList);
  }

  resetMyLocation() async {
    // 지도를 본인위치로 변경
    List<double> location = await _locationRepository.getCurrentLocation();

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location[0], location[1]),
          zoom: 16.5,
        ),
      ),
    );

    notifyListeners();
  }
}
