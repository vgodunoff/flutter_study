import 'package:flutter/material.dart';

/*
в отличие от SingleChildScrollView билдит не все сразу чилды, 
а только часть. поэтому с точки зрения производительности, эффективней
На больших списках (чаты) желательно отключать addAutomaticKeepAlives: false,
который стоит по умолчанию true
Если не отключать, то будут запоминаться чилды, и не будут перерисовываться
Иногда это нужно.
но в больших списках нельзя.
Например, если в чилдах будет простой Text(), показывающий индекс
, то на 5-6 тыс чилде отчетливо видно, как возрастает затрачиваемая 
память. 

    ListView() используется для сравнительно небольших списков (~100-1000 ед.)
Хотя метод билд всех чилдов не вызывается сразу, как у СинглЧилдСкролВью
но сами классы чилдов создаются. 
      
      Для больших списков лучше использовать конструктор ListView.builder
Он принимает не чилды, а замыкание (){}
отрисовывает виджеты которые умещаются на экране (или другой зоне ЛистВью)
и еще немного прозапас.
например, если вначале запуска программы вмещаются только 2 конт
то в Инспекторе видно, что созданы 3 виджета.
при прокрутке создает еще новые виджеты, старые удаляет
это повышает производительность
И что же делать с теми виджетами, где нужно хранить данные, состояние
например, textField
если что-либо вписать в поле и затем прокрутить вниз и вернуться,
то наша писанина исчезнет, потому что старые виджеты были удалены
не помогает 
по умолчанию addAutomaticKeepAlives: true,
а также TextEditingController(text: widget.text);
нужно использовать миксин AutomaticKeepAliveClientMixin
 */

class ExampleListView extends StatelessWidget {
  const ExampleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return Ex(
            text: '$index',
          );
        },
      ),
    );
  }
}

class Ex extends StatefulWidget {
  final String text;
  const Ex({Key? key, required this.text}) : super(key: key);

  @override
  State<Ex> createState() => _ExState();
}

class _ExState extends State<Ex> with AutomaticKeepAliveClientMixin {
  late final TextEditingController controller; //late означает, что
  //позже эту переменную инициализирую

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
