import 'package:flutter/material.dart';

class PloggingProvider extends ChangeNotifier {
  String test = "Test";

  startPlogging() {
    // 플로깅 시작
  }

  pausePlogging() {
    // 플로깅 일시중지
  }

  stopPlogging() {
    // 플로깅 종료
  }

  resetMyLocation() {
    // 지도를 본인위치로 변경
  }
}
