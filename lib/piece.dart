 //dimensions
  import 'package:flutter/material.dart';

int row=10;
  int column=15;

enum TetrisPiece{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}
enum Direction{
  left,
  right,
  down
}
const Map<TetrisPiece,Color> tetriscolor ={
    TetrisPiece.L:Colors.orange,
    TetrisPiece.J:Colors.blue,
    TetrisPiece.I:Colors.pink,
    TetrisPiece.O:Colors.yellow,
    TetrisPiece.Z:Colors.green,
    TetrisPiece.T:Colors.purple,
};