import 'package:flutter/material.dart';

/*
Row принимает размер экрана (h=683, w=411)
Row также как и UnconstraindeBox не накладывает никаких ограничений
на своих чилдов, и позволяет им иметь любой размер. Распологает 
чилдов рядом, а свободное место остается пустым.
Также как и UnconstraindeBox у Row тоже в случае, если чилды больше чем ширина 
строки, то будет ошибка переполнения - Overflow (желто-черные полоски)
*/
class ExampleRow extends StatelessWidget {
  const ExampleRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(textDirection: TextDirection.ltr, children: <Widget>[
      Expanded(
        child: Container(
            color: Colors.red,
            child: Text(
              'This is a very long text that won’t fit the line.',
              textDirection: TextDirection.ltr,
            )),
      ),
      Flexible(
        child: Container(
            color: Colors.green,
            child: Text(
              'Goodbye!',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 40),
            )),
      ),
    ]);
  }
}
/*
Если использовать Expanded (обернуть один из чилдов строки, то второй чилд будет 
отрисован по ширине текста, а текст обернутый в экпандид займет оставшееся место, 
то есть по остаточному принципу). Если второй текст без Экспандид будет очень 
длинный, он не переносится на следующую строку, появляется ошибка переполнения

"Если у Row все дочерние элементы обернуты в Expanded, то каждый Expanded будет 
иметь размер, пропорциональный его параметру flex, и затем каждый Expanded 
виджет приведет ширину дочернего элемента к своей.
"

Когда у Row все дочерние элементы обернуты в Expanded, текст переносится во всех 
чилдах, если не хватает места, не происходит ошибки переполнения, текст виден не 
весь, последняя видимая буква видна частично

Монжно использовать Flexible вместо Expanded. Единственное отличие, в том что 
Flexible позволяет своему дочернему элементу иметь ту же или меньшую ширину, 
чем у самого Flexible, в то время как Expanded заставляет дочерний элемент 
иметь точно такую же ширину, что и Expanded.
*/