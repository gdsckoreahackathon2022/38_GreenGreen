import 'dart:ffi';

class LocationModel {
  // 쓰레기통 위치
  List<List<Float>>? trashcanLocationList;
  // 쓰레기 주운 위치
  List<List<Float>>? takeTrashLocationList;

  LocationModel({
    this.trashcanLocationList,
    this.takeTrashLocationList,
  });
}
