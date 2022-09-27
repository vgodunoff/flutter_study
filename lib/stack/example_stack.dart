import 'package:flutter/material.dart';

class ExampleStack extends StatelessWidget {
  const ExampleStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Woolha.com Flutter Tutorial'),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(width: 100, height: 150, color: Colors.red),
              Container(width: 150, height: 50, color: Colors.green),
              Positioned(
                top: 20,
                bottom: 20,
                left: 130,
                right: 20,
                child: Container(width: 1, height: 1, color: Colors.blue),
              ),
            ],
          )

          // child: Container(
          //   width: 200,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     border: Border.all(),
          //   ),
          //   child: IndexedStack(
          //     index: null,
          //     children: [
          //       Container(width: 100, height: 150, color: Colors.red),
          //       Container(width: 150, height: 50, color: Colors.green),
          //       Positioned(
          //         top: -50,
          //         bottom: 20,
          //         left: 130,
          //         right: 20,
          //         // width: 100,
          //         // height: 50,
          //         child: Container(width: 1, height: 1, color: Colors.blue),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
