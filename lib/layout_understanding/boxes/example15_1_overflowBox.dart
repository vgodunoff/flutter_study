import 'package:flutter/material.dart';

/*
    

*/

class Example151 extends StatelessWidget {
  const Example151({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.black,
          child: OverflowBox(
            maxWidth: 412,
            child: SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Color.fromARGB(100, 0, 128, 128),
                ),
                child: Text('Woolha', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );

    // MaterialApp(
    //   home: UnconstrainedBox(
    //     child: Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.black38,
    //       child: SizedBox(
    //         width: 300,
    //         height: 50,
    //         child: ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             primary: Color.fromARGB(100, 0, 128, 128),
    //           ),
    //           child: Text('Woolha', style: TextStyle(color: Colors.white)),
    //           onPressed: () {},
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
/*

*/
}
