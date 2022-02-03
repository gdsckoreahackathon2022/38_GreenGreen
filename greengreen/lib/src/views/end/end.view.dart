import 'package:flutter/material.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:provider/provider.dart';

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

    return const Scaffold(
      body: Center(
        child: Text("결과페이지"),
      ),
    );
  }
}
