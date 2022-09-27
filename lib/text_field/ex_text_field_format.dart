import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
inputFormatters: принимает лист форматоров
FilteringTextInputFormatter.digitsOnly - только цифры могут быть введены в текстовое поле,
то есть другие символы не будут вписываться, какие символы не нажимай, только цифры останутся 
в поле текстфилда

FilteringTextInputFormatter.allow(filterPattern) - позволяет символы
filterPattern - можно использовать так назыв. РЕГУЛЯРНЫЕ ВЫРАЖЕНИЯ RegExp
FilteringTextInputFormatter.allow(RegExp('r[\d]+'))
 FilteringTextInputFormatter.deny(RegExp('r[rty]+'),replacementString: '*') - запрещаются символы
 r, t, y 
 и заменяются звездочками

 можно сделать свой форматер, в нашем случае класс PhoneInputFormatter


*/
class ExTextFieldInputFormat extends StatelessWidget {
  const ExTextFieldInputFormat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onTap: () {},
              inputFormatters: [PhoneInputFormatter()],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//будем делать формат номера телефона
//123 456 78 90
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
//replaceAll(RegExp('r[^\d]+'), ''); заменяет все что не цифры на пустую строку
//то есть удаляются в текстовом поле все символы, которые не являются цифрами
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]+'), '');
    //newValue.selection - selection показывает место курсора
//чтобы определить точное место курсора, нужно определить сколько мы пробелов добавили
// используем метод класса TextSelection (к которому относится selection) textBefore() - то есть определяем какой текст до курсора
// и убираем у него все цифры, остаются только искусствено вставленные пробелы,
//и они подсчитываются свойством строки length
    final initialSpecialSymbolCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'\d+'), '')
        .length;
//далее определяем позицию курсора с учетом пробелов
//selection.start - start определяет позицию курсора, который находится после текста
    final cursorPosition = newValue.selection.start - initialSpecialSymbolCount;

    var finalCursorPosition = cursorPosition;

    final digitOnlyChars = digitsOnly.split('');

//корректное удаление цифры, стоящая перед пробелом

    var newStrings = <String>[];

    for (int i = 0; i < digitOnlyChars.length; i++) {
      if (i == 3 || i == 6 || i == 8) {
        newStrings.add(' ');
        newStrings.add(digitOnlyChars[i]);
        if (i <= cursorPosition) finalCursorPosition += 1;
      } else
        newStrings.add(digitOnlyChars[i]);
    }
    final resultString = newStrings.join();
    print('oldValue.text ${oldValue.text}');
    print(oldValue.selection);
    var textInside = newValue.selection.textBefore(newValue.text).contains(' ');
    print(textInside);
    if (textInside) {
      digitOnlyChars.removeAt(cursorPosition - 1);
      finalCursorPosition -= 2;
    }
    return TextEditingValue(
        text: resultString,
// offset: resultString.length - курсор в конце строки
        selection: TextSelection.collapsed(offset: finalCursorPosition));
  }
}
