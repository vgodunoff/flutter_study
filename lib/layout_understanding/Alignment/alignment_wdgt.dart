import 'package:flutter/material.dart';

/*
  Alignment  и AlignmentDirectional расширяют класс 
  AlignmentGeometry.   
​​​​​​​Alignment используется для определения способа выравнивания (align) 
положения дочернего widget внутри его родителя.
    конструктор 
const Alignment(double x, double y)

Flutter помещает систему координат в центр родительского виджета, 
и вы можете создать объект Alignment из двух параметров 
x и y, чтобы описать, как выровнять (align) положение 
дочернего виджета.
    
    чаще используются константы
bottomCenter	Alignment(0.0, 1.0)
bottomLeft	Alignment(-1.0, 1.0)
bottomRight	Alignment(1.0, 1.0)
center	Alignment(0.0, 0.0)
centerLeft	Alignment(-1.0, 0.0)
centerRight	Alignment(1.0, 0.0)
topCenter	Alignment(0.0, -1.0)
topLeft	Alignment(-1.0, -1.0)
topRight	Alignment(1.0, -1.0)
*/

class Example152 extends StatelessWidget {
  const Example152({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          image: DecorationImage(image: AssetImage('assets/images/align.png')),
        ),
        //width: 200.0,
        //height: 200.0,

        child: Align(
          alignment: const Alignment(0.0555, 0.8),
          child: Container(
            child: Text(
              'Alignment(0.0555, 0.8)',
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
