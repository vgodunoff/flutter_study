import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
свойство enabled есть и текстфилда и у декоратора
у текстфилда главннее приоритет

*/
class ExTextFieldSettings extends StatelessWidget {
  const ExTextFieldSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
//TextAlign.center - центрирует текст
//start / end зависят от направления текста, имеет значение для арабского языка
//left /right не зависят от напр текста
          textAlign: TextAlign.center,
          // showCursor: false,
          //cursorColor: Colors.amber,
          //cursorHeight: 30,
          //cursorWidth: 20,
          //cursorRadius: Radius.circular(10),
          //
          //obscureText: true,
          obscuringCharacter:
              '1', //знак сокрытия (пароля)-  точки,  звездочки, и любые символы!
//
          enableSuggestions: true, //подсказки на клавиатуре
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
//characters - все буквы, sentences - В начале предложения первая буква слова заглавная
//words - во всех словах начальная буква заглавная
//
          smartDashesType: SmartDashesType.disabled,
          smartQuotesType: SmartQuotesType.disabled,
          //keyboardAppearance: Brightness.dark,
          //readOnly: true,// не будет открываться клавиатура и не можем вводить данные
//
          enableInteractiveSelection: true, //можно ли выделить текст
//если выделить текст, то появляется toolbar со словами copy cut paste selectall
// в конструкторе ToolbarOptions() все они по дефолту false
//поэтому нужно каждый включить/выключить
          toolbarOptions: ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
//??
          // selectionHeightStyle: BoxHeightStyle.max,
          // selectionWidthStyle: BoxWidthStyle.max,
//TextSelectionControls() - это абстрактный класс
//его реализации это CupertinoTextSelectionControls() для IOS
//и MaterialTextSelectionControls() для андроид
//если надо, то можно отнаследоваться от TextSelectionControls() и сделать свой toolbar
//
          style: TextStyle(),
//если текст не влезает он начинает прокручиваться
//если текст большой, то текстовое поле начинает расти
          //maxLines: null, //по умолчанию равен 1 и текст будет прокручиваться по горизонтали
          //minLines: null,
          //expands: true, //если maxLines: null и minLines: null, то при expands: true,
//текстовое поле занимает весь экран
          maxLength: 10, //макс. длина строки, снизу счетчик считает
          // в увязке с maxLengthEnforcement:
          maxLengthEnforcement: MaxLengthEnforcement.none,
//по умолчанию MaxLengthEnforcement.enforced - не позволяет ввести больше символов чем указано
// в maxLength:
//MaxLengthEnforcement.none - можно и больше символов ввести, но рамка будет красной,
//как в состоянии ошибки
          selectionControls: MaterialTextSelectionControls(),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
