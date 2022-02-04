import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';
import 'package:greengreen/src/views/ing/component/circleArrowButton.com.dart';
import 'package:greengreen/src/views/ing/component/circleButton.com.dart';

class TrashRow extends StatelessWidget {
  TrashRow({
    Key? key,
    this.trashtype,
    this.count,
    this.upMethod,
    this.downMethod,
  }) : super(key: key);

  String? trashtype;
  int? count;
  Function()? upMethod;
  Function()? downMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            color: greenColor,
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
          child: Center(
            child: Text(
              trashtype ?? "쓰레기!",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 145,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: CircleArrowButton(
                  icon: Icons.play_arrow_rounded,
                  method: upMethod ?? () {},
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x16000029),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: CircleArrowButton(
                  icon: Icons.play_arrow_rounded,
                  method: downMethod ?? () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
