import 'package:flutter/material.dart';

/*
использование ключевого слова const позволяет создавать объект из конструктора
на стадии компиляции у программиста
все классы по возможности должны быть константными
каждый раз когда вызываются билды, вызывается то что в них есть
то есть вызывается конструктор, получаем новый виджет, старый выкидывается 
а константы говорят что  вот этот виджет может сконтструироваться на этапе 
компайл тайм, на компьютере у программиста, а у пользователя он уже не будет он 
уже будет прекомпилирован, кэширован

флаттер перед вызовом метода билд сравнивает старый виджет, который здесь был и 
новый который появился в результате
если эти виджеты одинаковые, то он не вызывает метод билд.
это оптимизация, то есть подразумевается
если виджет не поменялся то и метод билд вызывать не нужно

расставим консты, точки вызова в дебаге на методе билд 
во всех наших классах-виджетах
рестарт
нажимаем кнопку жми, в ней срабатывает функция increase, метод setState, который 
запускает ребилд
вызывается первый билд стейтфул виджета и БОЛЬШЕ НИЧЕГО НЕ ВЫЗВАЛОСЬ 
почему?
потому что мы расставили везде константы
он посмотрел - все те же самые виджеты - оптимизируем - билды вызывать не нужно


НО ПРОБЛЕМА - мы ничего не обновляем, два текста с числом
и выйти из этой ситуации нам поможет инхерит

добавили инхерит DataProviderInherited
поставили брейкпоинты в методе билд 
в _DataConsumerStateless и в DataConsumerStatefull
и мы увидим, что в одном месте значение обновляется, а в другом нет
в _DataConsumerStateless билд вызывается, несмотря на то что он константный виджет
потому что инхерит вызывает у него билд, НО ТОЛЬКО КОГДА У НЕГО ОБНОВЛЯЕТСЯ
ЗНАЧЕНИЕ

А в DataConsumerStatefull мы не подписывались, виджет константный и ничего не работает
getElementForInheritedWidgetOfExactType получает элемент,
но в отличие от dependOnInheritedWidgetOfExactType не подписывается на изменения

в DataConsumerStatefull getElementForInheritedWidgetOfExactType
получает только одно значение, то которое мы инициализируем в _DataOwnerStatefull
 например var _value = 7;
 
чаще используется метод dependOnInheritedWidgetOfExactType
но метод getElementForInheritedWidgetOfExactType нужен когда, мы получаем только
один раз данные , и нам больше не нужно данные
если нужно постоянно получать обновленные данные то нужна подписка
и нужно использовать dependOnInheritedWidgetOfExactType

в случае использования метода getElementForInheritedWidgetOfExactType
можно видеть что есть многословность
и поэтому можно отдельно написать код в виде функции
с использованием дженерика


          итоги по инхеритам
Инхерит - это просто виджет, который в нашем примере управляется 
стейтфул виджетом
он позволяет любому из потомков легко получить значения, которые с ним 
связаны. в нашем случае интежер int, которые он предоставляет
в нем есть функции, в которых мы можем описать, что нужно ли уведомлять потомков
то есть произошло ли реальное изменение данных в этом инхерите или нет
потомки обязательно получают это уведомление и вызывают метод билд, даже если они 
константные.
      какие профиты у этого подхода
1 мы можем предоставлять данные по всей длине дерева
это можно делать и другими способами:
 - глобал кей, но это плохо с архитектурной точки
зрения
- можно передавать через конструктор, но каждому конструктору нужно передавать эти 
аргументы
 - уведомляет подписчика(если подписан) и может вызвать метод билд когда изменится
 это полезно только для конст виджетов, потому что не конст и так обновятся

 использование конст виджетов с инхеритами позволяет контролировать производительность
 ребилдить только то что обновилось, изменилось

 провайдер, блок, гетИкс - все они используют инхериты, просто дают другой синтаксис
 инхериты могут быть многословными, нужно писать много кода
 а эти библиотеки делают так чтобы это не нужно было, то есть более удобно

 мы сами можем писать себе хелперы, например как  мы написали себе функцию
 
 T? getInherit<T>(BuildContext context) {
  final element =
      context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
  final widget = element?.widget;
  if (widget is T) {
    return widget as T;
  } else {
    return null;
  }
}


 */
class ExIngeritedWidget extends StatelessWidget {
  const ExIngeritedWidget({Key? key}) : super(key: key);

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
  var _value = 7;

  void _increament() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _increament,
          child: Text('Жми'),
        ),
        DataProviderInherited(
            value: _value, child: const _DataConsumerStateless())
      ],
    );
  }
}

class _DataConsumerStateless extends StatelessWidget {
  const _DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final value =
    //     context.findAncestorStateOfType<_DataOwnerStatefullState>()?._value ??
    //         0;

    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>()
            ?.value ??
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
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>()
            ?.value ??
        0;
    return Text('$value');

//     // final value =
//     //     context.findAncestorStateOfType<_DataOwnerStatefullState>()?._value ??
//     //         0;

//     // final value = getInherit<DataProviderInherited>(context)?.value ?? 0;

// //здесь использую 2 метода мы получаем элемент и подписываемся на изменения
//     final element = context
//         .getElementForInheritedWidgetOfExactType<DataProviderInherited>();
//     if (element != null) {
//       context.dependOnInheritedElement(element);
//     }
//     final dataProvider = element?.widget as DataProviderInherited;
//     final value = dataProvider.value;
//     return Text('$value');
  }
}

T? getInherit<T>(BuildContext context) {
  final element =
      context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
  final widget = element?.widget;
  if (widget is T) {
    return widget as T;
  } else {
    return null;
  }
}

class DataProviderInherited extends InheritedWidget {
  final int value;
  DataProviderInherited({Key? key, required this.value, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return value != oldWidget.value;
  }
}
