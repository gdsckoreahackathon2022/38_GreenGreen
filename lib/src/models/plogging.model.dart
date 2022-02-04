import 'package:flutter/material.dart';

class PloggingModel {
  AssetImage? image; // 인증 사진
  int walkTime; // 걷기 기록 시간
  int walkCount; // 만보기

  int plasticCount; // 플라스틱
  int wasteCount; // 일반쓰레기
  int paperCount; // 종이
  int bottleCount; // 페트병
  int glassCount; // 유리

  PloggingModel({
    this.image,
    this.walkTime = 0,
    this.walkCount = 0,
    this.plasticCount = 0,
    this.wasteCount = 0,
    this.paperCount = 0,
    this.bottleCount = 0,
    this.glassCount = 0,
  });
}
