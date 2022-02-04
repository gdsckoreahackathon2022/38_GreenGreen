import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';

class CircleArrowButton extends StatelessWidget {
  CircleArrowButton({Key? key, required this.icon, required this.method})
      : super(key: key);

  Function() method;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: method,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: greenColor,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000029),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 30,
          color: greenColor,
        ),
      ),
    );
  }
}
