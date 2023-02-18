import 'package:flutter/material.dart';

/*
В ЭТОМ примере если использовать один инхерит у которого два значения, которые мы 
будем передавать потомкам,
то при нажатии на любую из двух кнопок билды будут вызываться у обоих виджетов-чилдов

поэтому нужно использовать инхеритМодел
InheritedModel<T> дженерик
InheritedModel<String> - String - это тип аспекта

если метод updateShouldNotify возвращает true, то запускается метод updateShouldNotifyDependent
он тоже принимает старый виджет и еще dependencies  или аспекты

 @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherited oldWidget, Set aspects) {
    
  }
когда мы подписываемся на инхерит теперь мы еще указываем аспект
.dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'one')
в качестве аспекта может быть любой объект, мы указываем типом Стринг
аспект выступает как идентификатор, ключ
который и определяет где именно произошли обновления, в привязке с Set aspects в 
методе updateShouldNotifyDependent

насколько можно понять из кода, который находится "под капотом", то есть если 
поставить точки останова в методах dependOnInheritedWidgetOfExactType и 
updateShouldNotifyDependent, то картина складывается примерно таким образом:

 */
class ExIngeritedModel extends StatelessWidget {
  const ExIngeritedModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _DataOwnerStatefull(),
      ),
    );
  }
}

class _DataOwnerStatefull extends StatefulWidget {
  const _DataOwnerStatefull({Key? key}) : super(key: key);

  @override
  State<_DataOwnerStatefull> createState() => _DataOwnerStatefullState();
}

class _DataOwnerStatefullState extends State<_DataOwnerStatefull> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _increamentOne() {
    _valueOne += 1;
    setState(() {});
  }

  void _increamentTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _increamentOne,
          child: Text('Жми раз'),
        ),
        ElevatedButton(
          onPressed: _increamentTwo,
          child: Text('Жми два'),
        ),
        DataProviderInherited(
          valueOne: _valueOne,
          valueTwo: _valueTwo,
          child: const _DataConsumerStateless(),
        )
      ],
    );
  }
}

class _DataConsumerStateless extends StatelessWidget {
  const _DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'one')
            ?.valueOne ??
        0;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('$value'), const DataConsumerStatefull()],
      ),
    );
  }
}

class DataConsumerStatefull extends StatefulWidget {
  const DataConsumerStatefull({Key? key}) : super(key: key);

  @override
  State<DataConsumerStatefull> createState() => _DataConsumerStatefullState();
}

class _DataConsumerStatefullState extends State<DataConsumerStatefull> {
  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'two')
            ?.valueTwo ??
        0;
    return Text('$value');
  }
}

// class DataProviderInherited extends InheritedWidget {
//   final int valueOne;
//   final int valueTwo;
//   DataProviderInherited(
//       {Key? key,
//       required this.valueOne,
//       required this.valueTwo,
//       required Widget child})
//       : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(DataProviderInherited oldWidget) {
//     return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
//   }
// }

class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;
  DataProviderInherited(
      {Key? key,
      required this.valueOne,
      required this.valueTwo,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherited oldWidget, Set<String> aspects) {
    final isValueOneUpdated =
        valueOne != oldWidget.valueOne && aspects.contains('one');
    final isValueTwoUpdated =
        valueTwo != oldWidget.valueTwo && aspects.contains('two');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}
