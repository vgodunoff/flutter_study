import 'package:flutter/material.dart';

/*
    В отличие от Container, SizedBox  - это прозрачный контейнер, для которого вы 
не можете установить стиль (например, цвет фона, поля, отступы и т. д.). 
    Если вы укажете определенный размер для SizedBox, этот размер также будет 
применяться к его дочернему widget. В противном случае, если ширина SizedBox 
не задана или равна null, то его дочерний widget будет иметь ширину по своей 
собственной настройке или равную 0 (если не задано). С высотой тоже имеет 
сходное поведение.
    Все параметры, такие как width, height, size, child, участвующие в создании 
SizedBox, являются опциональными (необязательными).

Конструкторы​​​​​​​ SizedBox:

const SizedBox(
    {Key key,
    double width,
    double height,
    Widget child}
)

SizedBox.fromSize(
    {Key key,
    Widget child,
    Size size}
)

const SizedBox.expand(
    {Key key,
    Widget child}
)

const SizedBox.shrink(
    {Key key,
    Widget child}
)


*/
class ExampleSizedBox extends StatelessWidget {
  const ExampleSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity, //Inside column this will produce error
                child: Container(
                  width: 100,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
1 пример
Scaffold(
        body: SizedBox(),
      ),
Scaffold w=411, h= 683
размеры не указаны, поэтому SizedBox w=0, h=0

2 пример
Scaffold(
        body: SizedBox(
          child: Container(),
          )
"...ширина SizedBox не задана или равна null, то его дочерний widget будет иметь ширину по своей 
собственной настройке или равную 0 (если не задано)..."
Scaffold w=411, h= 683
SizedBox w=411, h= 683
Container w=411, h= 683
МИНИМАЛЬНОЕ ограничение, спускаемое родителем является РАЗМЕР ВСЕГО экрана.
Конт. не имеет чилда, поэтому он стремится быть как можно больше. 
    
3 пример    
    Scaffold(
        body: SizedBox(
          child: Container(
            child: Text('text cont'),
          color: Colors.blue,
          ),
        ),
      ),
    
    Добавили контейнеру чилда, Текст, 
    конт. стал размером с  текст
Scaffold w=411, h= 683
SizedBox w=55, h= 16
Container w=55, h= 16

4 пример 
Scaffold(
        body: SizedBox(
          width: 200,
          height: 200,
          child: Container(
            child: Text('text cont'),
            //   //width: 50,
            color: Colors.blue,
          ),
        ),
      ),

" Если вы укажете определенный размер для SizedBox, этот размер также будет 
применяться к его дочернему widget."
Scaffold w=411, h= 683
SizedBox w=200, h= 200
Container w=200, h= 200

5 пример 
Scaffold(
        body: SizedBox(
          width: 200,
          height: 200,
          child: Container(
            child: Text('text cont'),
            width: 50,
            color: Colors.blue,
          ),
        ),
      ),
Добавили размер конт., изменений нет.,
так как родитель конт. спускает жесткие ограничения
мин=макс=200 ширина/высота

Scaffold w=411, h= 683
SizedBox w=200, h= 200
Container w=200, h= 200



6 пример
SizedBox.fromSize (
    size: Size(250, 100),
    child: ElevatedButton(
      child: Text("Button"),
      onPressed: (){},
    )
)
Вы также можете создать объект SizedBox с помощью конструктора 
SizedBox.fromSize


https://www.codewithhussain.com/flutter-sizedbox-widget
Where SizedBox.fromSize() is helpful.
When you are working with media query. You can get the size of the device from 
the media query by using.

MediaQuery.of(context).size;

And this size object that you get real time can be used like below snippet to 
assign the dynamic width or height to a widget.

var size = MediaQuery.of(context).size;
var dynamicSize = size/4;



7 пример
SizedBox (
    width:250,
    height: 50,
    child: ElevatedButton(
      child: Text("Button "),
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          shadowColor : Colors.redAccent,
          elevation: 10,
          minimumSize: Size(200,  200 )
      )
    )
)
    Например: ElevatedButton имеет минимальный размер 200x200, но при 
    размещении в SizedBox заданного размера (например, 250x50) она будет 
    подчиняться размеру SizedBox.

Scaffold w=411, h= 683
SizedBox w=250, h= 50
ElevatedButton w=250, h= 50 (хотя был указан minimumSize: Size(200,  200 ))


8 пример
SizedBox (
    width:250,
    child: ElevatedButton(
      child: Text("Button "),
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          shadowColor : Colors.redAccent,
          elevation: 10,
          minimumSize: Size(200,  200 )
      )
    )
)
"Если высота SizedBox не указана (или равна null), то высота его дочернего 
widget будет определяться его собственными настройками, либо она равна 0 
(если собственных настроек нет)."
У SizedBox есть ширина 200, но нет выстоты.
У дочернего виджета есть и ширина и высота (200), поэтому "высота его дочернего 
widget будет определяться его собственными настройками,"

ElevatedButton w=250, h= 200
SizedBox также - w=250, h= 200


9 пример - Use SizedBox to Make a Button Full Width
Если установите double.infinity (бесконечность) на ширину SizedBox, 
его ширина будет как можно больше в разрешении родительского widget.

SizedBox (
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
        child: Text("Button "),
        onPressed: (){}
    )
)


10 пример
Конструктор SizedBox.expand используется для создания SizedBox с шириной и 
высотой double.infinity. Это означает, что размер SizedBox будет как можно 
больше в разрешении родительского widget.
SizedBox.expand(
  child: ElevatedButton(child: Text("Button "), )
  )



11 пример
В этом примере у нас есть SizedBox, созданный конструктором SizedBox.shrink, 
а его родительский widget является ConstrainedBox, который имеет минимальный 
размер 80x20. SizedBox уменьшит (shrink) свой размер, чтобы наилучшим образом 
соответствовать минимальному размеру родительского widget.

ConstrainedBox(
    constraints: new BoxConstraints( // Min: 80x20
        minWidth: 80.0,
        minHeight: 20.0
    ),
    child: SizedBox.shrink(
      child: ElevatedButton(
        child: Text('Button'),
        onPressed: () {},
      ),
    )
)

ConstrainedBox w = 80, h=20
SizedBox.shrink w = 80, h=20
ElevatedButton w = 80, h=20

12 пример
BoxConstraints forces an infinite height.
Column(
        children: [
          SizedBox(
            height: double.infinity, //Inside column this will produce error
            child: Container(
              height: 100,
              color: Colors.red,
            ), 
          ),
        ],
      ),
чтобы убрать ошибку бесконечная высота, нужно SizedBox обернуть в Expanded
Column(
        children: [
	          Expanded(           //This will solve the problem
            child: SizedBox(
              height: double.infinity,
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),

SizedBox as padding
AppBar(
        title: const Text('MY PAGE'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 20,   //Here SizedBox will add some padding after search icon
          )
        ],
      )
*/