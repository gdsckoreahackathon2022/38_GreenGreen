import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:greengreen/src/repository/photo.rep.dart';
import 'package:flutter/material.dart';
import 'package:greengreen/src/views/ing/ing.view.dart';
import 'package:provider/provider.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset(
          'assets/images/Logo.png',
          width: 50,
          height: 50,
        ),
        title: Text(
          "줍깅줍깅",
          style: TextStyle(
            color: Colors.green,
            fontSize: 25,
          ),
        ),
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
                DottedBorder(
                  borderType: BorderType.Oval,
                  dashPattern: const [2.5, 5],
                  strokeWidth: 2,
                  color: greenColor,
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => IngView()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(
                        height: 190,
                        width: 190,
                        color: Colors.green,
                        child: Container(
                          child: Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              height: 3.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 스타트버튼
                // MaterialButton(
                //   onPressed: () {},
                //   color: Colors.green,
                //   textColor: Colors.white,
                //   child: InkWell(
                //     onTap: () {},
                //     child: Container(
                //       height: 300,
                //       width: 200,
                // child: Center(
                //     child: Text(
                //   "Start",
                //   style: TextStyle(fontSize: 50),
                // )),
                //     ),
                //   ),
                //   shape: CircleBorder(),
                // )

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
