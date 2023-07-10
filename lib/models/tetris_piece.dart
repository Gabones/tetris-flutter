import 'package:flutter/material.dart';
import 'package:tetris/models/model.dart';

class TetrisPiece {
  Tetromino type;
  late int value;
  int positionX = -3;
  int positionY = 3;
  List<int> position = [];
  int rotationState = 0;

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  TetrisPiece({required this.type}) {
    value = binaryPositions[type]?[rotationState] ?? 0;
  }

  void initializePosition() {
    position = [];
    for (int index = 0; index < 16; index++) {
      int row = (index / 4).floor() + positionX;
      int col = (index % 4) + positionY;

      int bitValue = (value >> index) & 1;
      if (bitValue == 1) {
        position.add((row) * 10 + (col));
      }
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        positionX += 1;
        initializePosition();
        break;
      case Direction.left:
        positionY -= 1;
        initializePosition();
        break;
      case Direction.right:
        positionY += 1;
        initializePosition();
        break;
      default:
    }
  }

  void rotateRight() {
    rotationState = (rotationState + 1) % 4;
    value = binaryPositions[type]?[rotationState] ?? 0;
    checkBounds();
  }

  void checkBounds() {
    for (int index = 0; index < 16; index++) {
      int col = (index % 4) + positionY;
      int bitValue = (value >> index) & 1;
      if (bitValue == 1) {
        if (col < 0) {
          positionY++;
          checkBounds();
        }
        if (col >= 10) {
          positionY--;
          checkBounds();
        }
      }
    }
    initializePosition();
  }
}
