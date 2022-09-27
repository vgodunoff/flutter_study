import 'package:flutter/material.dart';

class ExampleCustomMultiChildLayout extends StatelessWidget {
  const ExampleCustomMultiChildLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          color: Colors.blue,
          child: CustomMultiChildLayout(
            delegate: OwnCustomMultiChildDelegate(),
            children: [
              LayoutId(
                id: 1,
                child: Text(
                  'left dtgh',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              LayoutId(
                id: 2,
                child: Text(
                  'midle',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              LayoutId(
                id: 3,
                child: Text(
                  'right sfggsdttfg',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OwnCustomMultiChildDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.biggest.width, 100);
  }

  @override
  void performLayout(Size size) {
    //задача: расположить тексты по краям и по середине так, в том числе при
//условии что будет меняться их длина
    if (hasChild(1) && hasChild(2) && hasChild(3)) {
//за основу возьмем первый текст, от него будем отталкиваться
//определим минимальный размер для среднего и правого текста
      final minOtherElementWidth = 50;

//определим макс ширину для первого (левого) текста
//взяли всю длину(родителя, экрана) и отняли минимальный размер для среднего и
//для правого текстов
      final firstElementMaxWidth = size.width - minOtherElementWidth * 2;

//отрисуем левый текст с полученными для него шириной и высотой
//кроме того метод layoutChild возвращает значение (Size), которое можно
//присвоить переменной
      final firstElementSize = layoutChild(
          1, BoxConstraints.loose(Size(firstElementMaxWidth, size.height)));

//определим макс ширину для третьего (правого) текста
//взяли всю длину(родителя, экрана) и отняли минимальный размер для среднего и
//для правого текстов
      final thirdElementMaxWidth =
          size.width - firstElementSize.width - minOtherElementWidth;
      final thirdElementSize = layoutChild(
          3, BoxConstraints.loose(Size(thirdElementMaxWidth, size.height)));

//определим макс ширину для среднего текста
      final secondElementMaxWidth =
          size.width - firstElementSize.width - thirdElementSize.width;
      final secondElementSize = layoutChild(
          2, BoxConstraints.loose(Size(secondElementMaxWidth, size.height)));

      //разместим наши чилды
      final firstElementYOffset = size.height / 2 - firstElementSize.height / 2;
      positionChild(1, Offset(0, firstElementYOffset));

      final thirdElementHOffset = size.width - thirdElementSize.width;
      final thirdElementYOffset = size.height / 2 - thirdElementSize.height / 2;
      positionChild(3, Offset(thirdElementHOffset, thirdElementYOffset));

      var secondElementHOffset = size.width / 2 - secondElementSize.width / 2;
      if (firstElementSize.width > secondElementHOffset) {
//если ширина первого текста больше чем точка начала второго текста
//то есть если левый текст налезает на средний, то начальная точка среднего текста
// должна быть равна ширине левого текста,
//то есть будет начинаться после левого текста
        secondElementHOffset = firstElementSize.width;
      } else if (secondElementHOffset + secondElementSize.width >
          thirdElementHOffset) {
//если ширина среднего текста, с учетом расположения ее начальной точки,
//больше чем положение начальной точки правого текста
// то есть если средний текст налезает на правый
//тогда начало среднего текста будет равно разнице между положением начала
//правого текста и шириной среднего текста
//то есть начальную точку среднего текста нужно поместить так, чтобы
//с учетом ширины средний текст не налазил на правый
//в математике если у нас есть выражение
//secondElementHOffset + secondElementSize.width = thirdElementHOffset
// переносим secondElementSize.width за знак равно со знаком минус
//secondElementHOffset = thirdElementHOffset - secondElementSize.width
        secondElementHOffset = thirdElementHOffset - secondElementSize.width;
      }
      final secondElementYOffset =
          size.height / 2 - secondElementSize.height / 2;
      positionChild(2, Offset(secondElementHOffset, secondElementYOffset));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

/*

CustomMultiChildLayout(
            delegate: OwnCustomMultiChildDelegate(),
            children: [
              LayoutId(
                id: 1,
                child: Container(width: 100, height: 100, color: Colors.pink),
              ),
              LayoutId(
                id: 2,
                child: Container(width: 1000, color: Colors.red),
              ),
              LayoutId(
                id: 3,
                child: Text(
                  'data',
                  style: TextStyle(color: Colors.black),
                  textDirection: TextDirection.ltr,
                ),
              )
            ],
          ),



      метод hasChild
в него в качестве аргумента функции вводим id чилда - hasChild(1), 
в данном случае id=1
этот метод проверяет существует ли чилд с таким id

Допустим, объявим переменные и присвоим им значения результатов 
выполнения метода hasChild();
void performLayout(Size size) {
    final d = hasChild(1);
    final a = hasChild(2);
    final c = hasChild(3);
    final x = hasChild(4);
  }
установим точку останова в методе performLayout и запустим отладчик
переменные d, a, c будут значение true
переменная x = false

      метод layoutChild(Object childId, BoxConstraints constraints)
метод layoutChild(id, constraints) принимает два параметра
id чилда и его ограничения 
В качестве размеров мы использовали конструктор BoxConstraints.loose(size)
loose позволяет быть чилду размером от 0 до size, то есть не обязывает
быть строго определенного размера(как это при tight), а можно быть меньше

size мы получаем из прилетаемого аргумента в метод performLayout(Size size)
void performLayout(Size size) {
    if (hasChild(1) && hasChild(2) && hasChild(3)) {
      layoutChild(1, BoxConstraints.loose(size));
    }

в метод performLayout(Size size) size прилетает из метода
getSize.
мы переопределили этот метод, getSize
@override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.biggest.width, 100);
  }

ширина осталась по умолчанию (biggest), 411,
а высоту поменяли на 100 (вместо 683)

исходя из этих ограничений
наши чилды будут следующих размеров

красн. конт
Container(width: 1000, color: Colors.red),
хочет быть шириной 1000, но ограничение по ширине 411
поэтому он становится w=411, h=100

розовый конт.
Container(width: 100, height: 100, color: Colors.pink),
соответствует входящим ограничениям и становится 100 х 100

имеет значение какой порядок чилдов в 
CustomMultiChildLayout(
     children: [
      LayoutId(1),
      LayoutId(2),
      LayoutId(3),
      ]
последний в списке LayoutId(3) будет отображен на переднем плане,
под ним LayoutId(2), внизу LayoutId(1),
*/
