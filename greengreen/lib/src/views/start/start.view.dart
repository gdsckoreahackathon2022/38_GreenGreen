import 'package:flutter/material.dart';
import 'package:greengreen/src/repository/permission.rep.dart';
import 'package:flutter/material.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 위치권한 요청
    final PermissionRepository _permissionRepository = PermissionRepository();
    _permissionRepository.requestLocationPermission();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset(
          'assets/images/Logo.png',
          width: 50,
          height: 50,
        ),
        title: Text("줍깅줍깅", style: TextStyle(color: Colors.green)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 줍깅 시작하기
                Text(
                  "줍깅 시작하기",
                  style: TextStyle(color: Colors.green, fontSize: 30),
                ),
                SizedBox(height: 20),
                // 이중선

                // 스타트버튼
                MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  textColor: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 300,
                      width: 200,
                      child: Center(
                          child: Text(
                        "Start",
                        style: TextStyle(fontSize: 50),
                      )),
                    ),
                  ),
                  shape: CircleBorder(),
                )

                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     color: Colors.red,
                //     height: 300,
                //     width: 300,
                //   ),
                // ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/main_image.png',
            fit: BoxFit.cover,
            height: 300,
            width: 500,
          ),
        ],
      ),
    );
  }
}
