import 'package:flutter/material.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/tetris_piece.dart';

class Bit extends StatelessWidget {
  final TetrisPiece currentPiece;

  Bit({required this.currentPiece});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4, // Number of columns in the grid
      children: List.generate(16, (index) {
        // Get the bit value at the corresponding index
        int bitValue = (currentPiece.value >> index) & 1;

        if (bitValue == 1) {
          return Pixel(
            color: currentPiece.color,
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return Pixel(
          color: Colors.grey[900],
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
