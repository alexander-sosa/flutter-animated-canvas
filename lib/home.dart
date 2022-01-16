import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dibujos.dart';
import 'modelos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Punto> vPunto = [];
  var rnd = Random();
  var screen;

  bool flag = false;

  // para el movimiento
  Future moverObjeto(){
    Completer c = Completer();
    Timer(Duration(milliseconds: 5), (){
      repetir();
    });
  }

  repetir(){
    if(flag) {
      moverPuntos();
      moverObjeto();
    }
  }

  void moverPuntos(){
    setState(() {
      for(var item in vPunto){
        if(item.dirHorizontal == 1){
          // derecha
          if(item.x >= screen.width){
            item.dirHorizontal = -1;
          }
        }
        else{
          // izquierda
          if(item.x <= 0){
            item.dirHorizontal = 1;
          }
        }

        if(item.dirVertical == 1){
          // abajo
          if(item.y >= screen.height){
            item.dirVertical = -1;
          }
        }
        else{
          // arriba
          if(item.y <= 0){
            item.dirVertical = 1;
          }
        }
        item.x += item.dirHorizontal;
        item.y += item.dirVertical;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(painter: DibujaPunto(vPunto),),
            GestureDetector(
              onPanDown: (desplazamiento){
                setState(() {
                    tryStop(desplazamiento.globalPosition.dx, desplazamiento.globalPosition.dy);
                });
              },
            )
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: (){
                    setState(() {
                      // Position
                      double x = rnd.nextDouble() * screen.width;
                      double y = rnd.nextDouble() * screen.height;
                      double radio = rnd.nextDouble() * (screen.width / 8);

                      // Color
                      int r = rnd.nextInt(256);
                      int g = rnd.nextInt(256);
                      int b = rnd.nextInt(256);

                      // Creation
                      vPunto.add(Punto(x, y, radio, Color.fromARGB(500, r, g, b)));
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.flag, color: flag ? Colors.green : Colors.red,),
                  onPressed: (){
                    setState(() {
                      flag = !flag;
                      if(flag)
                          moverObjeto();
                    });
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tryStop(x, y){
    int posicion = -1;
    Punto selected;
    for(var i = 0; i<vPunto.length; i++){
      double distancia = sqrt(pow(x - vPunto[i].x, 2) + pow(y - vPunto[i].y, 2));
      if(distancia < vPunto[i].radio){ // menor al radio
        posicion = i;
        selected = vPunto[i];
      }
    }
    if(posicion != -1 && selected.flag){
      selected.dirVertical = 0;
      selected.dirHorizontal = 0;
      selected.flag = false;
    }
    else if(posicion != -1 && !selected.flag){
      selected.dirVertical = -1;
      selected.dirHorizontal = 1;
      selected.flag = true;
    }
  }
}
