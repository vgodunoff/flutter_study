import 'package:flutter/material.dart';

/*
keep this in mind first, when setting width or height of a Container, 
it’s same as setting min-width and max-width (а точнее они равны) or 
min-height and max-height for it’s BoxConstraints at the same time.
*/

/*
1 случай
If the widget has no child, 
no height, no width, no constraints, 

and the parent provides unbounded constraints, 
then Container tries to size as small as possible.
 */
class ExampleContainer1 extends StatelessWidget {
  const ExampleContainer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //будет пустой экран, точнее будет Container
    //с шириной и высотой равными НОЛЬ, его не будет видно
    return UnconstrainedBox(
      child: Container(
        color: Colors.red,
      ),
    );
  }
}

/*
2 случай
If the widget has no child and no alignment, 
but a height, width, or constraints are provided, 
then the Container tries to be as small as possible 
given the combination of those constraints and 
the parent's constraints.
*/
class ExampleContainer2 extends StatelessWidget {
  const ExampleContainer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('demo'),
        ),
        body: Container(
          //padding: EdgeInsets.all(15),
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
          color: Colors.red,
          child: Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.all(15),
              // constraints: BoxConstraints(
              //     minHeight: 40, maxHeight: 200, minWidth: 40, maxWidth: 200),
              //width: 200,
              //height: 200,
              color: Colors.green,
              child: Container(
                  child: Text('blut cont'),
                  alignment: Alignment.bottomRight,
                  width: 150,
                  height: 150,
                  color: Colors.blue)),
        ),
      ),
    );
/*
В нашем случае виджет у которого нет чилда, 
нет выравнивания, но есть ширина и высота является синий Контейнер.
Он должен стараться быть как можно меньше, но с учетом ограничений спускаемых родителем.

Поскольку родитель(зеленый контейнер) предлагает ограничения minwidth=maxwidth=200 
и то же самое по высоте(), 
то синий контейнер может принять минимальное значение только 200.
зеленый контейнер без изменений-будет 200х200
и красный контейнер может быть от 0 до 300: поскольку имеет чилда - принимает размер чилда,
зеленого контейнера и тоже становится 200х200
 В условии говорится о чилде и выравнивании:
если же добавить чилда синему контейнеру(Текст) и свойство alignment,
то изменений в отношении размеров всех контейнеров не происходит. Только лишь 
отрисовывается Текст по выравниванию, указанному в свойстве alignment.

Ожидаемо произойдут изменения в случае, если обернуть синий  контейнер 
в виджет Align (или добавить свойство алинмент зел. конт.). Тогда будет видет зеленый контейнер 200х200. 
И синий конт. 50х50, выравненный в соответствии со свойством alignment виджета Align.
красный принимает также размер чилда, 200х200, и его не видно.

О свойстве alignment (виджета Container):
https://api.flutter.dev/flutter/widgets/Container/alignment.html
Align the child within the container.
If non-null, the container will expand to fill its parent and position its 
child within itself according to the given value. If the incoming constraints 
are unbounded, then the child will be shrink-wrapped instead.
Ignored if child is null.

https://stackoverflow.com/questions/56262634/alignment-property-container-in-flutter
First, you have to understand that the alignment property doesn't refer to 
Container alignment, but to its child's alignment.

Imagine that what defines the alignment of the child is the corner it is touching. 
If you align it to the left, the child will touch the left corner. 
However, a child cannot be properly aligned if the parent doesn't fill all the 
space available, since if the parent takes the minimum possible space, 
the child will touch all corners of the parent. That's why the Container has 
to fill all the space when you set an alignment, otherwise the child won't be 
able to respect that alignment.

В кратце: если есть свойство alignment, то этот конт. стремится заполнить себя до 
размеров родителя, и выравнивает чилда (выравнивание применяется к чилду).
чтобы выровнить конт. можно обернуть в другой конт со свойством алинмент
Container(
  alignment: Alignment.center,
  Container(
    child: Text

Чтобы синий контейнер был все-таки 50х50, нужно в родителе убрать width / height. 
И заменить на, например, 
constraints: BoxConstraints(minHeight: 40, maxHeight: 200, 
minWidth: 40, maxWidth: 200). 
В этом случае опять-таки зеленый конт. примет размер синего и станет 50х50,
а красный также примет размер чилда(зел.конт.) и тоже будет 50х50
              

*/
  }
}

/*
3 случай
If the widget has no child, no height, no width, no constraints, 
and no alignment, but the parent provides bounded constraints, 
then Container expands to fit the constraints provided by the parent.
*/
class ExampleContainer3 extends StatelessWidget {
  const ExampleContainer3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('demo'),
        ),
        body: Container(
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
          color: Colors.red,
          child: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
/*
зеленый конт. не имеет чилда, своих размеров и выравнивания.
поэтому зел.конт. расширяется до ограничений родителя,
до 300х300
*/
  }
}

/*
4 случай
If the widget has an alignment, no constraints, and the parent provides 
unbounded constraints, 
then the Container tries to size itself around the child.
*/

class ExampleContainer4 extends StatelessWidget {
  const ExampleContainer4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('demo'),
            ),
            body: UnconstrainedBox(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.green,
                  child: Container(width: 50, height: 50, color: Colors.blue)),
            )));
/*
зеленый конт. не имеет своих размеро, есть свое свойство выравнивания, родитель 
предоставляет неогранич. ограничения.
поэтому зел.конт. принимает размеры чилда.

Если убрать виджет UnconstrainedBox, то ограничения уже будут ограниченные и в итоге
весь бади будет заполнен зеленым конт., а снизу по центру синий конт., 50х50
это относится 
            к следующему случаю (5 случай)
If the widget has an alignment, no constraints, and the parent provides bounded 
constraints, then the Container tries to expand to fit the parent, 
and then positions the child within itself as per the alignment.

body: Container(
              constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
              color: Colors.red,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.green,
                  child: Container(width: 50, height: 50, color: Colors.blue)),
            )));
только здесь автор вместо ограничений от body (Scaffold) явно добавил родителя с 
ограниченными размерами
          Container(constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
если в нашем эксперименте зел. конт. заполнил все пространство body, то в этом 
примере (от автора статьи) зел.конт. будет 300х300, а снизу синий 50х50          
*/
  }
}

/*
6 случай
If the widget has an alignment, constraints, and the parent provides bounded 
constraints, then the Container tries to be as small as possible given the 
combination of those constraints and the parent’s constraints, and then 
positions the child within itself as per the alignment.
*/

class ExampleContainer6 extends StatelessWidget {
  const ExampleContainer6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('demo'),
            ),
            body: Container(
              constraints: BoxConstraints(
                  // minHeight: 100,
                  // minWidth: 100,
                  maxHeight: 300,
                  maxWidth: 300),
              color: Colors.red,
              child: Container(
                  //alignment: Alignment.bottomCenter,
                  // width: 200,
                  // height: 200,
                  color: Colors.green,
                  child: Container(width: 50, height: 50, color: Colors.blue)),
            )));
/*
 здесь решающее значение имеет свойство алинмент зеленого конт. оно действует как 
 отдельный виджет Align (or Center), то есть принимает на себя минимальные размеры
 , а они же являются максимальными 200х200 зеленого 
 конт. и Align становится 200х200. А син. конт. уже может быть того размера, какое хочет.,
 и становится 50х50 

 Otherwise, the widget has a child but no height, no width, no constraints, 
 and no alignment, and the Container passes the constraints from the parent 
 to the child and sizes itself to match the child. 
 Когда нет размеров и выравнивания конт. принимает размеры чилда      
*/
  }
}
