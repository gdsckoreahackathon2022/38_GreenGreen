import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greengreen/src/models/plogging.model.dart';
import 'package:greengreen/src/repository/location.rep.dart';
import 'package:greengreen/src/repository/photo.rep.dart';
import 'package:greengreen/src/views/end/end.view.dart';
import 'package:image_picker/image_picker.dart';

class PloggingProvider extends ChangeNotifier {
  List<double>? _myLocation;
  // 쓰레기 주운 위치
  final List<List<double>> _takeTrashLocationList = [];
  // 내가 걸은 경로
  final List<List<double>> _walkingPathList = [];
  final PloggingModel _plogging = PloggingModel();
  GoogleMapController? _controller;

  int _walkingStatus = 2;

  bool _isLoading = true;

  XFile? _image;

  Set<Marker> _marker = {};

  List<double> get myLocation => _myLocation ?? [37.556797, 126.923703];
  List<List<double>> get takeTrashLocationList => _takeTrashLocationList;
  List<List<double>> get walkingPathList => _walkingPathList;
  PloggingModel get plogging => _plogging;
  GoogleMapController? get mapController => _controller;

  int get walkingStatus => _walkingStatus;

  bool get isLoading => _isLoading;

  XFile? get image => _image;

  Set<Marker> get marker => _marker;

  final LocationRepository _locationRepository = LocationRepository();
  final PhotoRepository _photoRepository = PhotoRepository();

  late Timer _timer;
  late Timer _mapRefresher;
  initPlogging() async {
    // 첫 시작
    await resetMyLocation();
    _mapRefresher = Timer.periodic(const Duration(seconds: 2), (timer) {
      resetMyLocation();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _plogging.walkTime++;
      notifyListeners();
    });
    _walkingStatus = 0;

    _isLoading = false;
    notifyListeners();
  }

  startPlogging() {
    // 플로깅 시작
    if (_walkingStatus != 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _plogging.walkTime++;
        notifyListeners();
      });
    }
    _walkingStatus = 0;
  }

  pausePlogging() {
    // 플로깅 일시중지
    _timer.cancel();
    _walkingStatus = 1;
    notifyListeners();
  }

  stopPlogging(BuildContext context) {
    // 플로깅 종료
    _timer.cancel();
    _walkingStatus = 2;

    _mapRefresher.cancel();
    notifyListeners();

    finishPlogging(context);
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
  }

  initMapController(GoogleMapController controller) {
    _controller = controller;
    notifyListeners();
  }

  resetMyLocation() async {
    // 지도를 본인위치로 변경
    List<double> location = await _locationRepository.getCurrentLocation();

    // 마커 찍기
    getMaker(location[0], location[1]);

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location[0], location[1]),
          zoom: 17,
        ),
      ),
    );

    if (_walkingStatus == 0) {
      // 경로 저장
      _walkingPathList.add([location[0], location[1]]);
    }

    notifyListeners();
  }

  finishPlogging(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("이제 그만 걸으시나요?")),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("아니 더 걸을래"),
            ),
            TextButton(
              onPressed: () async {
                await getPhoto();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EndView()),
                );
              },
              child: const Text("응 그만할래"),
            ),
          ],
        );
      },
    );
  }

  getPhoto() async {
    _image = await _photoRepository.getPhoto();
  }

  getMaker(double lat, long) async {
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/my_location.png', 100);
    Marker marker = Marker(
      markerId: MarkerId('0'),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    _marker = {marker};
    notifyListeners();
  }
}
