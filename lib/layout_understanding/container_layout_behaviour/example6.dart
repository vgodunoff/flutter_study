import 'package:flutter/material.dart';

/*
Center передает Container ограничения от 0 до всего экрана
Container если не имеет чилда, занимает максимальные размеры, в данном случае весь экран
*/

class Example6 extends StatelessWidget {
  const Example6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Container(
          color: Colors.blueAccent,
          width: 50,
          height: 50,
        ),
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
