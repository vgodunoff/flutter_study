import 'package:flutter/material.dart';

/*
    Вы могли бы предположить, что размер Container должен быть от 70 до 150 
пикселей, но это не так. ConstrainedBox только накладывает дополнительные 
ограничения к тем, что она получила от своего родителя.
    В данном случае "экран" приводит ConstrainedBox к своему размеру, 
поэтому дочерний Container также получит размеры "экрана", 
игнорируя полученные ограничения.

То есть здесь можно видеть такое же поведение как и с конт., когда конт. родитель 
получает размеры от "экрана".

Если обернуть ConstrainedBox в Center, то уже Центр растягивается на весь экран,
а чилд Центра, может иметь размер какой хочет. И конт. будет от 70 до 150. 
У него указаны размеры 10х10, но минимально он будет 70х70.

"В данном случае Center позволяет ConstrainedBox быть любого размера, 
но не больше "экрана". Дочерний виджет ConstrainedBox получит дополнительные 
ограничения от параметра constraints.
Таким образом, размер Container должен составлять от 70 до 150 пикселей. 
Он хочет иметь 10 пикселей в ширину и высоту, поэтому в конечном итоге у 
него будет (минимум) 70 х 70."

Аналогично, если увеличить размеры конт. до 1000 х 1000
Container(color: Colors.red, width: 1000, height: 1000),
то максимально конт. будет только 150 х 150.

В случае если размеры конт. будут 100 х 100
Container(color: Colors.red, width: 100, height: 100),
то он и будет таким, поскольку входит в диапазон 70 - 150

*/

class Example10 extends StatelessWidget {
  const Example10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: Container(color: Colors.red, width: 10, height: 10),
    );
  }
}

/*
ConstrainedBox
https://metanit.com/dart/flutter/2.5.php

Виджет ConstrainedBox задает параметры прямоугольной области (ширину и высоту), в которой 
размещается вложенный виджет. Для создания объекта ConstrainedBox применяется следующий конструктор:

ConstrainedBox({Key key, @required BoxConstraints constraints, Widget child})

Обязательный параметр constraints представляет класс BoxConstraints, 
который имеет следующие конструкторы:

BoxConstraints({double minWidth: 0.0, double maxWidth: double.infinity, 
double minHeight: 0.0, double maxHeight: double.infinity}): получает 
минимальную ширину (minWidth), максимальную ширину (maxWidth), 
минимальную (minHeight) и максимальную (maxHeight) длину

BoxConstraints.expand({double width, double height}): принимает ширину и длину, 
до которых может растягиваться контейнер

BoxConstraints.loose(Size size): создает контейнер, который должен иметь
 размер не больше, чем параметр size

BoxConstraints.tight(Size size): создает контейнер, который должен иметь в 
точности тот же размер, что и параметр size

BoxConstraints.tightFor({double width, double height}): принимает точные 
значения ширины и длины, которые должен иметь контейнер

BoxConstraints.tightForFinite({double width: double.infinity, 
double height: double.infinity}): принимает точные значения ширины и длины, 
если они не равны double.infinity

Данный тип контейнеров применяется, когда нам надо ограничить виджет 
определенной областью.
Если содержимое виджета занимает больше места, то оно усекается до видимой области. 

Center(
      child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 300, height: 100),
          child: Text(
            'Hello Flutter from metanit.com',
*/