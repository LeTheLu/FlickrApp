import 'package:flickr_app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const OverlaySupport.global(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ));
}
