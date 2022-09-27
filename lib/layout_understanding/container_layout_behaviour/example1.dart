import 'package:flutter/material.dart';

/*
- виджет получает от родителя ограничения
minWidth  maxWidth
minHight maxHight

- виджет собирает информацию от своих чилдов, 
на какие размеры они претендуют
и сообщает им каковы их ограничения

- виджет с этими знаниями сообщает своему родителю свой размер
- нужно учитывать все дерево в целом
*/

/*
В примере 1 Контейнер займет весь экран, 
так как ему спускаются ограничения 
ConstrainedBox( 
    constraints: BoxConstraints.tightFor(width: double.infinity, height: double.infinity), 
    child: example
)
 */
class Example1 extends StatelessWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 100,
      height: 100,
      // даже если добавить ширину и высоту,то все равно контейнер будет на весь экран,
      //так как МИНИМАЛЬНОЕ ограничение, спускаемое родителем является РАЗМЕР ВСЕГО экрана
    );
  }
}
