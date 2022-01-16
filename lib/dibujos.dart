import 'package:canvas_animated/modelos.dart';
import 'package:flutter/material.dart';

class DibujaPunto extends CustomPainter{
  List<Punto> vPunto;

  DibujaPunto(this.vPunto);

  @override
  void paint(Canvas canvas, Size size) {
    Paint pintura = Paint()
        ..style = PaintingStyle.fill;

    for(var item in vPunto){
      pintura.color = item.color;
      canvas.drawCircle(Offset(item.x, item.y), item.radio, pintura);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}