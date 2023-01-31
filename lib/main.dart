import 'package:flutter/material.dart';
import 'package:flyme/game_screen.dart';
import 'package:flyme/utils/color_util.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
              colors: [
                HexColor("E6C89B").withOpacity(0.8),
                // HexColor("E3C9A5").withOpacity(1),
                HexColor("E6C89B").withOpacity(0.95),
                // HexColor("E3C9A5").withOpacity(0.9),
                HexColor("E6C89B").withOpacity(1)
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp),),
          child: const GameScreen()),
    );
  }
}

