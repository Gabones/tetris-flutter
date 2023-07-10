import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/models/model.dart';
import 'package:tetris/components/pixel.dart';
import 'package:tetris/models/tetris_piece.dart';

/*
  Game Board
  Este é uma matriz 10x15 onde null representa espaços vazios.
  Um espaço preenchido contém a cor para representar a respectiva peça
*/

List<List<Tetromino?>> gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  TetrisPiece currentPiece = TetrisPiece(type: Tetromino.I);
  int currentScore = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePosition();
    Duration frameRate = const Duration(milliseconds: 1000);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          clearLines();
          checkLanding();
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // check collision in future position
  bool checkCollision(Direction direction) {
    for (int position in currentPiece.position) {
      int row = (position / rowLength).floor();
      int col = position % rowLength;

      switch (direction) {
        case Direction.left:
          col -= 1;
          break;
        case Direction.right:
          col += 1;
          break;
        case Direction.down:
          row += 1;
          break;
      }

      if (row >= colLength || col < 0 || col >= rowLength) {
        // out of bound
        return true;
      }

      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int position in currentPiece.position) {
        int row = (position / rowLength).floor();
        int col = position % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    // uma instancia da classe Random
    Random rand = Random();

    Tetromino randType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = TetrisPiece(type: randType);
    currentPiece.initializePosition();
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void rotateRight() {
    setState(() {
      currentPiece.rotateRight();
    });
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Game Board
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                if (currentPiece.position.contains(index)) {
                  // current piece
                  return Pixel(
                    color: currentPiece.color,
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[tetrominoType],
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  // blank pixel
                  return Pixel(
                    color: Colors.grey[900],
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          // Controls
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: rotateRight,
                      color: Colors.white,
                      icon: const Icon(Icons.rotate_left),
                    ),
                    IconButton(
                      onPressed: rotateRight,
                      color: Colors.white,
                      icon: const Icon(Icons.rotate_right),
                    ),
                    IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_downward),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
