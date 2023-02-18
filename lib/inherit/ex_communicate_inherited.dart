import 'package:flutter/material.dart';

/*
метод updateShouldNotify не срабатывает, потому что модель не меняется,
а изменились значения в модели
bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
    return model != oldWidget.model;
  }
так как модель  та же самая, то инхерит не видит отличий и не считает, что
подписчики должны быть уведомлены
соответственно нам приходиться как-то самим подписываться на изменения модели
потому что модель это changeNotifier, ей можно добавить листнера, который
будет вызван когда мы внутри нее вызовем notifylisteners
то есть мы вызвали notifylisteners, уведомили листнеров
вызывается листенер (model?.addListener)
поэтому нужно в методе didChangeDependencies() добавить к модели слушателя
didChangeDependencies() {
    super.didChangeDependencies();
    final model = SimpleCalcWidgetProvider.of(context)?.model;
    model?.addListener(() {
      _value = '${model.sumResult}';
      setState(() {});
    });

didChangeDependencies() будет вызываться каждый раз когда у нас будет меняться 
модель И ТОЛЬКО когда поменятся модель
то есть модель поменялась вызвался дидченж нотифайлистенер
если модель поменялась - что это значит? или впервые появилась 
то это значит что на новую модель, которой пока не было и которой не было листенера,
мы подписываемся - делаем model?.addListener
говорим что теперь когда она меняется - будем изменять вэлью нашего стейта и вызывать
сетСтейт
почему мы это не делали в билде, а сделали в didChangeDependencies()?
билд тоже бы вызвался
но билд вызывается не один раз и по некоторым причинам
в реальных проектах может быть он был еще на что-то подписан
например вызывался сетСтейт и вызывался бы билд
каждый вызов билда добавлял бы листенера (model?.addListener)
а листенера нужно добавлять один раз
вот поэтому нам нужен didChangeDependencies()

 */
class ExCommunicateIngerited extends StatelessWidget {
  const ExCommunicateIngerited({Key? key}) : super(key: key);

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
          SimpleCalcWidgetProvider.of(context)?.model.firstNumber = value,
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
          SimpleCalcWidgetProvider.of(context)?.model.secondNumber = value,
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => SimpleCalcWidgetProvider.of(context)?.model.sum(),
        child: Text('Посчитать сумму'));
  }
}

class ResultWidget extends StatefulWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  String _value = '-1';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = SimpleCalcWidgetProvider.of(context)?.model;
    model?.addListener(() {
      _value = '${model.sumResult}';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcWidgetProvider.of(context)?.model.sumResult ?? 0;
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

class SimpleCalcWidgetProvider extends InheritedWidget {
  final SimpleCalcWidgetModel model;
  SimpleCalcWidgetProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, child: child);

  static SimpleCalcWidgetProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>();
  }

  @override
  bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
    return model != oldWidget.model;
  }
}
