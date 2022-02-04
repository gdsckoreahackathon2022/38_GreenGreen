import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';

class CircleButton extends StatelessWidget {
  CircleButton({Key? key, required this.icon, required this.method})
      : super(key: key);

  Function() method;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: method,
      child: Container(
        width: 45,
        height: 45,
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
        child: Icon(
          icon,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
