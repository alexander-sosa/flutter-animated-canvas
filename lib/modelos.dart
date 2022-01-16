import 'package:flutter/material.dart';

class Punto{
  double x, y, radio;
  Color color;

  int dirHorizontal = 1;
  int dirVertical = -1;
  bool flag = true;

  Punto(this.x, this.y, this.radio, this.color);
}