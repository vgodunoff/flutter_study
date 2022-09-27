import 'package:flutter/material.dart';

class ExButtons extends StatefulWidget {
  const ExButtons({Key? key}) : super(key: key);

  @override
  State<ExButtons> createState() => _ExButtonsState();
}

class _ExButtonsState extends State<ExButtons> {
  String text = 'Ни одна кнопка не нажата';

  void printFirst() {
    setState(() {
      text = 'Нажата первая или вторая кнопка';
    });
  }

  void printSecond() {
    setState(() {
      text = 'Нажата третья кнопка';
    });
  }

  void printLast() {
    setState(() {
      text = 'Нажата последняя кнопка';
    });
  }

  void printLongPressed() {
    setState(() {
      text = 'Долгое нажатие на одну из кнопок';
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(Colors.red), //цвет кнопки
        //   foregroundColor:
        //       MaterialStateProperty.all(Colors.black), //цвер текста/иконок
        //   overlayColor: MaterialStateProperty.all(Colors.green), //цвет сплеша
        //   //то есть когда нажимаешь на кн.
        //   shadowColor: MaterialStateProperty.all(Colors.blue), //цвет тени
        //   elevation: MaterialStateProperty.all(10),
        //   padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        //   minimumSize: MaterialStateProperty.all(Size(100,
        //       100)), //мин. размер кн., по умолчанию кнопка принимает размер или
        //   //растягивается от текста внутри кнопки
        //   shape: MaterialStateProperty.all(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(50.0),
        //       side: BorderSide(color: Colors.black),
        //     ),
        //   ),
        //   alignment: Alignment.bottomRight,
        );

//первые 3 кнопки с одним стилем становятся одинаковыми. по умолчанию они имеют 3 разных стиля
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            ElevatedButton(
//Clip.hardEdge - обрезает текст по краям. то что выходит за кн.
//Clip.antiAlias также обрезает то что выходит за кн., более плавно, но дороже
              clipBehavior: Clip.antiAlias,
              onPressed: printFirst,
              onLongPress: printLongPressed,
              child: Row(
//если не минимизировать размер, то кн. растянется на всю ширину экрана
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.ac_unit),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Нажми меня'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.ac_unit)
                ],
              ),
              style: style,
            ),
            OutlinedButton(
              onPressed: printFirst,
              onLongPress: printLongPressed,
              child: Text('Нажми меня'),
              style: style,
            ),
            TextButton(
              onPressed: printSecond,
              onLongPress: printLongPressed,
              child: Text('Нажми меня'),
              style: style,
            ),
            IconButton(
              color: Colors.amber, //цвет иконки
              iconSize: 48, //по умолчанию 24
              padding: EdgeInsets.all(
                  40), //позволяет увеличить площадь кнопки, по умолч. - 8
              splashRadius: 30, //радиус пятна от нажатия
              splashColor: Colors.green, //цвет пятна при нажатии
              highlightColor:
                  Colors.red, //сначала виден цвет хайлайт, а затем сплэш
              disabledColor:
                  Colors.orange, //если в онпрессд нул, тогда кн. не активна
              //в disabledColor указываем цвет не акт. кнопки
              enableFeedback: true, // вибро при нажатии
              onPressed: printLast,

              icon: Icon(Icons.ac_unit),
            ),
          ],
        ),
      ),
    );
  }
}
