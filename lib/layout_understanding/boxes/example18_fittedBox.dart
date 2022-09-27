import 'package:flutter/material.dart';

/*
"Экран" приводит FittedBox к своему размеру. Ширина Text зависит от 
количества текста, его размера шрифта и т.д.
FittedBox будет масштабировать текст до тех пор, пока не заполнит всю 
доступную ширину.

Если в этом примере обернуть FittedBox в Center, то Центр принимает на себя 
ограничения от экрана, и позволяет FittedBox быть любого размера, до размеров 
экрана. 
      "В итоге размер FittedBox будет в соответствии с Text, и Text может 
быть любого размера, которого захочет. Поскольку и FittedBox, и Text имеют 
одинаковый размер, никакого масштабирования не произойдет.".
    Если текст слишком большой, то FittedBox уменьшить размер текста, так чтобы
    текст влез в экран.
    Text('This is some very very very large text that is too big to fit a regular 
    screen in a single line.', textDirection: TextDirection.ltr,),
Однако, если убрать FittedBox, то Text получит максимальную ширину от "экрана" 
и затем перенесет текст на новую строку, чтобы влезть в "экран".

Center(
      child: Text(
              'This is some very very very large text that is too big to fit a regular screen in a single line.',
              textDirection: TextDirection.ltr),
    );


FittedBox может масштабировать только виджет, который ограничен 
(имеет не бесконечную ширину и высоту). В противном случае он ничего не будет 
рендерить, и вы получите ошибку в консоли: RenderConstrainedBox object was 
given an infinite size during layout.
 */

class ExampleFittedBox extends StatelessWidget {
  const ExampleFittedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: FittedBox(
    //       child: Text(
    //           'This is some very very very large text that is too big to fit a regular screen in a single line.',
    //           textDirection: TextDirection.ltr)),
    // );

    return FittedBox(
        child: Container(
      height: 20.0,
      width: double.infinity,
    ));
  }
}
