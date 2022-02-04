import 'package:flutter/material.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:greengreen/src/views/end/end.view.dart';
import 'package:greengreen/src/views/ing/ing.view.dart';
import 'package:greengreen/src/views/start/start.view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PloggingProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Green',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "AppleSDGothicNeo",
      ),
      home: const StartView(),
      // home: IngView(),
      // home: EndView(),
    );
  }
}
