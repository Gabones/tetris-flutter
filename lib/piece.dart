import 'dart:ui';

import 'package:tetris/board.dart';
import 'package:tetris/model.dart';

class Piece {
  // tipo da peça de tetris
  Tetromino type;
  Piece({required this.type});

  // a peça é uma lista de inteiros que representa sua posição
  List<int> position = [];
  int rotationState = 1;

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        print(binaryPositions[type]![0].toRadixString(2).split("").map((e) => int.parse(e)).toList());
        position = [
          -26,
          -16,
          -6,
          -5
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        position = checkSides(position);
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  bool checkValidPosition(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || row > 14 || gameBoard[row][col] != null) {
      return false;
    }

    return true;
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!checkValidPosition(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }

  List<int> checkSides(List<int> piecePosition) {
    for (int pos in piecePosition) {
      int col = pos % rowLength;

      if (col == 0) {
        return piecePosition.map((e) => e + 1).toList();
      }
      if (col == rowLength - 1) {
        return piecePosition.map((e) => e + 1).toList();
      }
    }

    return piecePosition;
  }
}
