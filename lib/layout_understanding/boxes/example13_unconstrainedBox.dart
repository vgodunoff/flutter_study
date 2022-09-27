import 'package:flutter/material.dart';

/*
    

*/

class Example13 extends StatelessWidget {
  const Example13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      //alignment: Alignment.centerLeft,
      //constrainedAxis: Axis.horizontal,
      child: Container(color: Colors.red, width: 4000, height: 50),
    );
  }
}

/*
UnconstrainedBox принимает размеры "экрана"
и позволяет дочернему конт. быть желаемого размера
конт. будет 20 х 50
    Если у чилда размер будет больше чем у UnconstrainedBox,
например,Container(color: Colors.red, width: 4000, height: 50),
то будет ошибка Оверфлоу.
*/