import 'package:flutter/material.dart';

/*

*/
class ExampleScaff extends StatelessWidget {
  const ExampleScaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SizedBox.expand(
                child: Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Text('Hello!'),
                        Text('Goodbye!'),
                      ],
                    )))));

    // return MaterialApp(
    //   home: Scaffold(
    //     body: Container(
    //       color: Colors.blue,
    //       child: Column(children: [
    //         SizedBox(
    //           height: 40,
    //           //width: 100,
    //         ),
    //         Text('Hello!'),
    //         Text('Goodbye!'),
    //       ]),
    //     ),
    //   ),
    // );
  }
}
/*
1 пример
"Экран" приводит Scaffold к своему размеру. Так что Scaffold заполняет весь 
"экран".
Scaffold говорит Container, что он может быть любого размера, но не больше 
"экрана".
Примечание: когда виджет сообщает своему дочернему элементу, что он может быть 
меньше определенного размера, мы говорим, что виджет предоставляет "loose" 
(пер. свободные) ограничения своему дочернему элементу. 
Конт. не имеет размеров, но у него есть чилд. поэтому конт. принимает размер
чилда.
В свою очередь колонка определяется в ширине длинной текстов (размером чилдов),
высота по умолчанию макс, то есть на всю страницу

2 пример
Если мы хотим, чтобы ребенок у Scaffold был точно такого же размера, 
как и сам Scaffold, мы можем обернуть этот дочерний виджет в SizedBox.expand.
Примечание: когда виджет сообщает своему дочернему элементу, что он должен 
иметь определенный размер, мы говорим, что виджет предоставляет "tight" 
(пер. жесткие) ограничения своему дочернему элементу.
*/