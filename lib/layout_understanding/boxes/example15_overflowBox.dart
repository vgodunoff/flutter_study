import 'package:flutter/material.dart';

/*
   With UnconstrainedBox, you can impose different constraints to a child widget. 
However, the size of the child cannot be bigger than its parent's constraints.
    What if you want a child widget to be bigger than the constraints of its parent. 
You can use a widget called OverflowBox. 
It allows you to impose different constraints to the child and makes it 
possible for the child to overflow its parent. 

*/

class Example15 extends StatelessWidget {
  const Example15({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0.0,
      minHeight: 0.0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Container(color: Colors.red, width: 4000, height: 50),
    );
    //buildCont(context);
  }
/*
    

OverflowBox принимает размеры "экрана"
и позволяет дочернему конт. быть желаемого размера
конт. будет 4000 х 50
    OverflowBox просто покажет, то что может,
    без каких-либо предупреждений.


*/
}

Widget buildCont(BuildContext context) {
  return Center(
    child: Container(
      width: 200.0,
      height: 200.0,
      color: Colors.blue[50],
      child: Align(
        alignment: const Alignment(1.0, 1.0),
        child: SizedBox(
          width: 10.0,
          height: 20.0,
          child: OverflowBox(
            minWidth: 0.0,
            maxWidth: 100.0,
            minHeight: 0.0,
            maxHeight: 50.0,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ),
  );
  /*

  */
}
