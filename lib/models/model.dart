import 'dart:ui';

int rowLength = 10;
int colLength = 15;

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T
}

enum Direction {
  left,
  right,
  down,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color(0xFF008000),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};

const Map<Tetromino, List<int>> binaryPositions = {
  Tetromino.I: [
    0x0F00,
    0x2222,
    0x00F0,
    0x4444
  ],
  Tetromino.J: [
    0x44C0,
    0x8E00,
    0x6440,
    0x0E20
  ],
  Tetromino.L: [
    0x4460,
    0x0E80,
    0xC440,
    0x2E00
  ],
  Tetromino.O: [
    0xCC00,
    0xCC00,
    0xCC00,
    0xCC00
  ],
  Tetromino.S: [
    0x06C0,
    0x8C40,
    0x6C00,
    0x4620
  ],
  Tetromino.T: [
    0x0E40,
    0x4C40,
    0x4E00,
    0x4640
  ],
  Tetromino.Z: [
    0x0C60,
    0x4C80,
    0xC600,
    0x2640
  ]
};
