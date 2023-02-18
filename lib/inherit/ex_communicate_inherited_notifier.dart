import 'package:flutter/material.dart';

/*
мы меняем наш инхерит на InheritedNotifier
class SimpleCalcWidgetProvider extends InheritedWidget
class SimpleCalcWidgetProvider extends InheritedNotifier
InheritedNotifier - это такой интересный инхерит, который заточен на то чтобы 
ему передавали вэлью

InheritedNotifier<T extends Listenable>
в нашем случае это будет InheritedNotifier<SimpleCalcWidgetModel> потому что 
SimpleCalcWidgetModel extends ChangeNotifier
а ChangeNotifier имплементирует Listenable

InheritedNotifier - это такая штука, которая берет значение, которое должно 
имплементировать Listenable
в нашем случае ChangeNotifier подходит
и вызывает обновление тех кто на него подписан, если в этом нотифайере вызывался
notifyListeners
то есть теперь оно за нас оптимизирует. каждый раз когда мы вызываем у модели 
notifyListeners - наш InheritedNotifier это понимает, и понимает что именно теперь
что-то поменялось и те кто на него подписан должны дернуть метод билд
теперь когда мы изменились на нотифайере
теперь ResultWidget можно вернуть обратно как стейтлис виджет

изначально мы использовали метод of во всех виджетах, чтобы отправить значения 
инхериту
но метод dependOnInheritedWidgetOfExactType кроме получения инхерита, еще и 
подписывается виджет на его изменения. когда у нас моделька меняется, и когда в 
пользовательском методе summ() вызывается метод notifyListeners(),
то все кто подписался - пересобираются, вызывается метод билд у них. К ним относятся
FirstNumverWidget(), SecondNumverWidget(), SumButtonWidget(), ResultWidget().
мы использовали метод of() во всех этих 4-х виджетах.
но на самом деле мне не нужно обновлять вот эти первые три виджета. а нужно обновлять
только последний
в остальных нужен был только доступ к модельки получить, чтобы туда добавить даные, записать
чтобы вызвать метод, перерисовывать эти виджеты не нужно

в итоге во всех виджетах вызывается метод билд
static SimpleCalcWidgetModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.model;
  }

поэтому будем использовать другой метод
final widget = context
        .getElementForInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.widget;
с его помощью мы получим элемент и через него виджет

поэтому переделаем наш метод на два метода watch  и read
в методе read  будет использоваться другой метод контекста
 */
class ExIngeritedNotifier extends StatelessWidget {
  const ExIngeritedNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SimpeCalcWidget(),
      ),
    );
  }
}

class SimpeCalcWidget extends StatefulWidget {
  const SimpeCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpeCalcWidget> createState() => _SimpeCalcWidgetState();
}

class _SimpeCalcWidgetState extends State<SimpeCalcWidget> {
  final _model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalcWidgetProvider(
          model: _model,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FirstNumverWidget(),
              SizedBox(
                height: 10,
              ),
              SecondNumverWidget(),
              SizedBox(
                height: 10,
              ),
              SumButtonWidget(),
              SizedBox(
                height: 10,
              ),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNumverWidget extends StatelessWidget {
  const FirstNumverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) =>
          SimpleCalcWidgetProvider.read(context)?.firstNumber = value,
    );
  }
}

class SecondNumverWidget extends StatelessWidget {
  const SecondNumverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) =>
          SimpleCalcWidgetProvider.read(context)?.secondNumber = value,
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => SimpleCalcWidgetProvider.read(context)?.sum(),
        child: Text('Посчитать сумму'));
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcWidgetProvider.watch(context)?.sumResult ?? '-1';
    return Text('Результат $value');
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void sum() {
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = null;
    }
    if (this.sumResult != sumResult) {
      this.sumResult = sumResult;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider
    extends InheritedNotifier<SimpleCalcWidgetModel> {
  final SimpleCalcWidgetModel model;
  SimpleCalcWidgetProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child) {
    print('created inherit');
  }

  static SimpleCalcWidgetModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.notifier;
  }

  static SimpleCalcWidgetModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.widget;
    return widget is SimpleCalcWidgetProvider ? widget.notifier : null;
  }
}
