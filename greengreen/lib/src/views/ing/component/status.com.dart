import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';

class StatusComponent extends StatelessWidget {
  StatusComponent({Key? key, this.walkCount, this.walkTime}) : super(key: key);

  int? walkCount = 0;
  Duration? walkTime = const Duration();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      height: 100,
      width: MediaQuery.of(context).size.width / 2 - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000029),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/step 1.png",
                width: 20,
              ),
              const SizedBox(width: 2),
              Text(
                "걸음수 $walkCount",
                style: TextStyle(
                  fontSize: 18,
                  color: greenColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/watch 1.png",
                width: 20,
              ),
              const SizedBox(width: 2),
              Text(
                "시간 ${walkTime!.inHours}:${walkTime!.inMinutes.remainder(60)}:${walkTime!.inSeconds.remainder(60)}",
                style: TextStyle(
                  fontSize: 18,
                  color: greenColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
