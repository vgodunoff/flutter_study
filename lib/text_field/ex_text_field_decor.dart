import 'package:flutter/material.dart';

/*
https://stacksecrets.com/flutter/flutter-textfield-decoration-in-depth



*/
class ExTextFieldDecoration extends StatelessWidget {
  const ExTextFieldDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.ac_unit),
                labelText: 'Label text',
                labelStyle: TextStyle(color: Colors.amber),
                helperText: 'Help text',
                helperStyle: TextStyle(color: Colors.green),
                helperMaxLines: 1,
                //hintText: "Enabled decoration text ...",
                hintMaxLines: 1,
                hintStyle: TextStyle(fontSize: 14),
                hintTextDirection: TextDirection.ltr,
                //errorText: 'error text',
//если есть ерортекст, то не видно хинта
                //
                prefixIcon: Icon(Icons.phone),
//prefixIcon принимает любой виджет
                // prefixIconConstraints: BoxConstraints.loose(Size(40, 40)),
                // prefixIcon: Container(
                //   color: Colors.amber,
                //   width: 10,
                //   height: 10,
                // ),
                //prefix: Text('8(705)'),//также принимает любой виджет
                prefixText: '+7',
                prefixStyle: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.bold),
                //suffixIcon: Icon(Icons.monitor),
                suffixIconConstraints:
                    BoxConstraints.expand(width: 40, height: 40),
                //suffix: Text('suffix'),
                // suffixText: 'Suffix Text',
                // suffixStyle: TextStyle(color: Colors.purpleAccent),
                // suffixIconColor: Colors.teal,
                floatingLabelBehavior: FloatingLabelBehavior.always,
//поведение label, по умолчанию FloatingLabelBehavior.auto
// always всегда показывается лэйбл
//none - не показывает лэйбл, а только как хинт
                //isCollapsed: true,
//схлопывает поле ввода, не использовать с иконкой и вспомогат.надписями
/*
Whether the decoration is the same size as the input field.
A collapsed decoration cannot have [labelText], [errorText], 
an [icon]. To create a collapsed input decoration, 
use [InputDecoration.collapsed].
*/
                isDense: true, //немного сжимает по вертикали
                contentPadding: EdgeInsets.all(10),
//если включить isCollapsed или isDense,
//то падингом можно подобрать нужные размеры поля ввода
                filled: true,
                fillColor: Colors.amber,
//заливка поля ввода, работает в паре с filled: true,
                focusColor: Colors.pink,
                border: OutlineInputBorder(),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black, width: 2.0),
                //   borderRadius: BorderRadius.circular(1.0),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
