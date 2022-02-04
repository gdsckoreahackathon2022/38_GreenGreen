import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:greengreen/src/views/end/component/endMap.com.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class EndView extends StatelessWidget {
  late PloggingProvider _ploggingProvider;

  EndView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _ploggingProvider = Provider.of<PloggingProvider>(context);

    // return Scaffold(
    //   body: Center(
    //     child: Text(_ploggingProvider.test),
    //   ),
    // );

    return Scaffold(
      body: Column(
        children: [
          /** map_sample Widget */
          Container(
            child: EndMapComponent(),
            width: 390,
            height: 400,
          ),
          /** 걸음수 */
          Container(
            padding: const EdgeInsets.fromLTRB(27, 7, 0, 7),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('asset/images/step2.png', height: 40, width: 40),
                Text(
                  '걸음수 10,000',
                  style: TextStyle(fontSize: 37),
                )
              ],
            ),
          ),
          /** 타이머 */
          Container(
            padding: const EdgeInsets.fromLTRB(27, 7, 0, 7),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('asset/images/watch2.png', height: 40, width: 40),
                const Text(
                  '시간 15:20:12',
                  style: TextStyle(fontSize: 38),
                )
              ],
            ),
          ),
          /** 환경 커멘트 */
          Container(
            padding: const EdgeInsets.fromLTRB(27, 7, 0, 7),
            alignment: Alignment.centerLeft,
            child: const Text(
              '대충 친환경적이라고 한다.',
              style: TextStyle(
                  fontSize: 26,
                  color: Color(0xff6DCA37),
                  fontWeight: FontWeight.bold),
            ),
          ),
          /** 주운 쓰레기 개수 */
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(27, 7, 0, 7),
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              width: 150,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xff6DCA37),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              //  POINT: BoxDecoration
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("플라스틱 ",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xff707070))),
                  Text("종이 ",
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Color(0xff707070))),
                  Text("일반쓰레기 ",
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Color(0xff707070))),
                  Text("페트병 ",
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Color(0xff707070))),
                  Text("유리 ",
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Color(0xff707070))),
                ],
              ),
            ),
            /** 갤러리 */
            Container(
              margin: const EdgeInsets.fromLTRB(27, 7, 27, 7),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: 100,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xff6DCA37),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              //  POINT: BoxDecoration
              child: const Text("text", style: TextStyle(fontSize: 14.0)),
            ),
          ]),
        ],
      ),
    );
  }
}
