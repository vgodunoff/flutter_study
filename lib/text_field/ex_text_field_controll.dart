import 'package:flutter/material.dart';

/*
обработка событий через замыкания
обработка событий и управление с помощью контроллера
работа с фокусом focusNode
*/
class ExTextFieldControll extends StatefulWidget {
  ExTextFieldControll({Key? key}) : super(key: key);

  @override
  State<ExTextFieldControll> createState() => _ExTextFieldControllState();
}

class _ExTextFieldControllState extends State<ExTextFieldControll> {
  final controllerOne = TextEditingController(text: 'start text');
  final controllerTwo = TextEditingController(text: 'start string');

  final nodeOne = FocusNode();
  final nodeTwo = FocusNode();

//   //вызывается когда мы вводим текст в поле
//   void _onChanged(value) {
//     print('onChanged $value');
//   }

// //вызывается по нажатию  done/go  и так далее
//   void _onEditingComlete() {
//     print('onEditingComlete ');
//   }

//   // вызывается когда нажимаем на клавиатуре кн. done/go/next и так далее
//   void _onSubmitted(value) {
//     print('submitted value $value');
//   }

//   void _onTap() {
//     print('onTap');
//   }

  void _onButtonTapNode() {
    // print(nodeOne.hasFocus);
    // print(nodeTwo.hasFocus);
    // nodeOne.unfocus();
    // nodeOne.requestFocus();
    //nodeOne.nextFocus();
    // nodeOne.previousFocus();
    nodeTwo.addListener(() {
      print(nodeTwo.hasFocus);
    });
  }

  void _onButtonTap() {
    //controllerOne.text = 'неккий тексе';
    // controllerTwo.clear();
    // controllerOne.value = TextEditingValue(
    //     text: 'sdfsfgsdssv',
    //     selection: TextSelection(baseOffset: 0, extentOffset: 7));
// в selection: можно установить позицию курсора,
//TextSelection.collapsed(offset: 5)
//TextSelection(baseOffset: 0, extentOffset: 7) - выделяем с первого по 7 символы
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: _onButtonTapNode, child: Text('Жми')),
              TextField(
                focusNode: nodeOne,
                controller: controllerOne,
                //onTap: _onTap,
                // onChanged: _onChanged,
                // onEditingComplete: _onEditingComlete,
                // onSubmitted: _onSubmitted,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                focusNode: nodeTwo,
                controller: controllerTwo,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
