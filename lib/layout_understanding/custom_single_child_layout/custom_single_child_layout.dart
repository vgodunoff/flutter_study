import 'package:flutter/material.dart';

/*

*/
class ExampleCustomSingleChildLayout extends StatelessWidget {
  const ExampleCustomSingleChildLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          color: Colors.blue,
          child: CustomSingleChildLayout(
            delegate: OwnCustomSingleChildLayout(),
            child: Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
/*
*/

class OwnCustomSingleChildLayout extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }

  @override

  /// The size of this object given the incoming constraints.
  ///
  /// Defaults to the biggest size that satisfies the given constraints.
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.biggest.width, constraints.biggest.width);
  }

  @override

  /// The constraints for the child given the incoming constraints.
  ///
  /// During layout, the child is given the layout constraints returned by this
  /// function. The child is required to pick a size for itself that satisfies
  /// these constraints.
  ///
  /// Defaults to the given constraints.
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints;
  }

  @override

  /// The position where the child should be placed.
  ///
  /// The `size` argument is the size of the parent, which might be different
  /// from the value returned by [getSize] if that size doesn't satisfy the
  /// constraints passed to [getSize]. The `childSize` argument is the size of
  /// the child, which will satisfy the constraints returned by
  /// [getConstraintsForChild].
  ///
  /// Defaults to positioning the child in the upper left corner of the parent.
  Offset getPositionForChild(Size size, Size childSize) {
    final yOffset = size.height / 2 - childSize.height / 2;

    return Offset(120, yOffset);
  }
}

/*
              метод getSize()
установим точку останова в методе getSize(BoxConstraints constraints)
и запустим отладчика
в переменных можно видеть, что мы имеем constraints:
minWidth=0, minHeight = 0, maxWidth = 411, maxHeight = 683.
то есть мы определили размеры CustomSingleChildLayout
свойство biggest равно Size (Size(411.4, 683.4))
то есть getSize() возвращает самые бОльшие значения размеров - Size(411.4, 683.4)

В инспекторе значения виджетов следующие:
Center w=411, h=683
Container blue w=411, h=683
CustomSingleChildLayout w=411, h=683
Container red w=100, h=100

метод getSize(), как и другие методы, можно переопределить (@override)
и в возвращаемом значении поставить не constraints.biggest, а, например,

return Size(500, 100) и наш CustomSingleChildLayout примет размер в длину на весь
экран(экран 411, больше не сможет), и высотой 100

или
return Size(constraints.biggest.width, constraints.biggest.width) и 
наш CustomSingleChildLayout станет квадратным - его ширина = высоте

            
            метод getConstraintsForChild ()
метод возвращает ограничения для чилда виджета CustomSingleChildLayout, 
для Container red
также установим точку останова в методе и запустим отладчик
также в переменных можно видеть, что мы имеем constraints:
minWidth=0, minHeight = 0, maxWidth = 411, maxHeight = 683.

вместо значения по умолчанию (return constraints) можно вернуть, например, 
BoxConstraints.tight(Size(50,50))  
или BoxConstraints.tight(constraints.biggest)
или BoxConstraints.loose(Size(200, 200))


          getPositionForChild(Size size, Size childSize)
  по умолчанию данный метод располагает чилда в левом верхнем углу родителя,
  то есть Offset(0,0) = Offset.zero

  мы можем переопределить метод и расположить чилда в нужном нам месте,
например, Offset(100,150)
Offset(dx,dy)
dx - это смещение по оси Х, (горизонтально)
dу - это смещение по оси У(вертикально), 
можно ниже родителя опустить Offset(100, 350);

установим в методе точку останова и запустим отладчик.
если в первых двух методах нам были доступны ограничения,
то здесь нам доступны конкретные размеры
оперируя этими размеры можно какую-то математику посчитать,
например сместить наш элемент(чилд) на его же ширину - Offset(childSize.width,0)


поместить чилда в центр
берем высоту родителя (из входящих параметров метода 
getPositionForChild(Size size, Size childSize)) 

size.height делим на 2  - size.height/2
но это будет точкой от которой будет расположен чилд, то есть начнется от середины
и к низу. а нам нужно посередине расположить чилда
поэтому еще нужно отнять высоту чилда, деленную на 2:
final yOffset = size.height/2 - childSize.height/2
size.height/2 - экватор, середина
childSize.height/2 - половину чилда будет на одной половине родителя, половина 
на другой. чилд будет на середине, вертикально

Offset(120,yOffset)


*/