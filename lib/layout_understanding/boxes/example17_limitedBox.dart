import 'package:flutter/material.dart';

/*
    

*/

class Example17 extends StatelessWidget {
  const Example17({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
        child: LimitedBox(
      maxWidth: 100,
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: 100,
      ),
    ));
  }
}


/*
Как уже показывалось в прошлом примере (пример 16): если родитель предоставляет 
безграничные ограничения по размеру (UnconstrainedBox, ListView и другие), 
а чилд (конт.) хочет быть с бесконечной шириной/высотой,  то такой конт. не будет 
отрисован, вернее его не будет видно.
    В таком случае можно использовать виджет LimitedBox.
    The constructor of a LimitedBox Widget will look like Below :
LimitedBox({
   Key key,
   double maxWidth: double.infinity,
   double maxHeight: double.infinity,
   Widget child,
 });
  
Если родитель дает ограничения, то LimitedBox не дает эффекта. Например,
если вместо UnconstrainedBox поставить Center, то конт. уже может быть 
того размера какой хочет, в данном случае width: double.infinity.
    
    
    Если же здесь заменить LimitedBox на SizedBox, то мы получим
    желаемый результат: конт. 100 х 100 
    Center(
        child: SizedBox(
      width: 100,
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: 100,
    
LimitedBox в отличие от  SizedBox работает когда родитель предоставляет 
неограниченные размеры.
Другое отличие - LimitedBox в отличие от  SizedBox предоставляет не фиксированный
размер, а предел maxWidth/maxHeight. Например
child: LimitedBox(
      maxWidth: 100,
      child: Container(
        color: Colors.red,
        width: 80,
Здесь конт. будет шириной 80, так как входит в ограничение - не больше 100
А если поменять на SizedBox
child: SizedBox(
      maxWidth: 100,
      child: Container(
        color: Colors.red,
        width: 80,
то конт. будет шириной не 80, а 100
*/