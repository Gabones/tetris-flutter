import 'package:flutter/material.dart';
import 'package:tetris/components/game_board.dart';

void main() {
  runApp(const MyApp());
}

// TODO! impedir um elemento de girar dentro de outro
// TODO! implementar uma mecânica de gameOver

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const GameBoard(),
    );
  }
}
