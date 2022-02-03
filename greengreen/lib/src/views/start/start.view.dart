import 'package:flutter/material.dart';
import 'package:greengreen/src/repository/permission.rep.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 위치권한 요청
    final PermissionRepository _permissionRepository = PermissionRepository();
    _permissionRepository.requestLocationPermission();

    return const Scaffold(
      body: Center(
        child: Text("시작페이지"),
      ),
    );
  }
}
