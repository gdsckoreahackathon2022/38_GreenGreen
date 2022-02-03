import 'package:flutter/material.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:provider/provider.dart';

class IngView extends StatefulWidget {
  const IngView({Key? key}) : super(key: key);

  @override
  _IngViewState createState() => _IngViewState();
}

class _IngViewState extends State<IngView> {
  late PloggingProvider _ploggingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ploggingProvider = Provider.of<PloggingProvider>(context, listen: false);
    _ploggingProvider.startPlogging();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("기록페이지"),
      ),
    );
  }
}
