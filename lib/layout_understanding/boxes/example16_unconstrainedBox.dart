import 'package:flutter/material.dart';

/*
 3) UnconstrainedBox: он не налагает никаких ограничений на своих дочерних 
 элементов и позволяет им рисовать в их собственном размере

Обычно используется для удаления родительских ограничений   

*/

class Example16 extends StatelessWidget {
  const Example16({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
        child: Container(
      color: Colors.red,
      width: double.infinity,
      height: 100,
    ));
  }
}


/*

На экране ничего не отобразистя, и вы получите ошибку в консоли.
UnconstrainedBox позволяет своему ребенку иметь любой размер, который он хочет, 
однако, у его дочернего виджета Container ширина бесконечна 
(width: double.infinity).
Flutter не может визуализировать бесконечные размеры, поэтому он выдаст 
ошибку со следующим сообщением: 
Box Constraints forces an infinite width.
  Аналогичная ошибка выйдет, если в ListView вставить
  конт. с бесконечным размером (ширина или высота)

  MaterialApp(
      home: ListView(scrollDirection: Axis.horizontal, children: [
        Container(
          color: Colors.red,
          width: double.infinity,
          height: 200,
        ),
      ]),
    );

    То есть в статье виджет UnconstrainedBox
    взят для примера, чтобы показать общую проблему
    для всех виджетов, которые предоставляют 
    неогранич. ограничения
    
*/