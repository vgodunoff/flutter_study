import 'package:flutter/material.dart';

/*
чаще SingleChildScrollView используют если контент не влезает в экран.
Например, когда у нас форма, и может вылезти экранная клавиатура.

Для длинных таблиц и списков лучше использовать другие виджеты, напр. ListView

 */
class ExampleSingleChildScrollView extends StatefulWidget {
  const ExampleSingleChildScrollView({Key? key}) : super(key: key);

  @override
  State<ExampleSingleChildScrollView> createState() =>
      _ExampleSingleChildScrollViewState();
}

class _ExampleSingleChildScrollViewState
    extends State<ExampleSingleChildScrollView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      print(controller.offset);
    });
    controller.addListener(() {
      print(controller.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    for (var i = 0; i < 200; i++) {
      final text = Text(
        '$i',
        textDirection: TextDirection.ltr,
      );
      items.add(text);
    }
    return MaterialApp(
      home: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        controller: controller,
        reverse: false,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items,
          ),
        ),
      ),
    );
  }
}
