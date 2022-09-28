import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintWidget extends StatefulWidget {
  const CustomPaintWidget({Key? key}) : super(key: key);

  @override
  State<CustomPaintWidget> createState() => _CustomPaintWidgetState();
}

class _CustomPaintWidgetState extends State<CustomPaintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: CustomPaint(
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
//для отрисовки дуги
//добавляем переменную, которая будет обозначать процент от всего круга
// 1.0 - полный круг, 0.5 - полкруга и так далее
//инициализируем со значением 0,72

  final double percent = 0.72;
  @override
  void paint(Canvas canvas, Size size) {
//рисуем индикатор на черном фоне

//рисуем фон
    final backgroundPaint = Paint();
    backgroundPaint.color = Colors.black;
    backgroundPaint.style = PaintingStyle.fill;
//нарисовали черный круг, который полностью вписался в квадрат(наш конт.)
    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2), size.width / 2, paint);

//вместо canvas.drawCircle можно использовать canvas.drawOval(rect, paint)
//здесь мы привяжем размер квадрата(конт.) с размером овала
//так как овал принимает rect
//и если мы изменим, например высоту квадрата, то и овал также изменится
    canvas.drawOval(Offset.zero & size, backgroundPaint);

// рисуем дугу
    final feelPaint = Paint();
    feelPaint.color = Colors.green;
    feelPaint.style = PaintingStyle.stroke;
    feelPaint.strokeWidth = 5;

    //рисуем дугу
//canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint)
//rect - Offset.zero & size
//
//Arc здесь работает в радианах, если градусы у круга от 0 до 360
// то в Пи 0 до 2Пи
//а радианы от 0 до ~6,3
//мы  выставим для нашей дуги начальную точку startAngle 0
//конечную точку на окружности sweepAngle 3,14 (pi)
//
//useCenter - false
    canvas.drawArc(Offset(2.5, 2.5) & Size(size.width - 5, size.height - 5),
        -pi / 2, pi * 2 * percent, false, feelPaint);

// рисуем оставшуюся часть дуги, которая будет другим цветом
    final filledPaint = Paint();
    filledPaint.color = Colors.yellow;
    filledPaint.style = PaintingStyle.stroke;
    filledPaint.strokeWidth = 5;
//смещение оставляем такое же как и у зеленой дуги
// начальная точка должна быть концом зеленой дуги pi * 2 * percent
    canvas.drawArc(
        Offset(2.5, 2.5) & Size(size.width - 5, size.height - 5),
        (3 * pi / 2) + (pi * 2 * percent),
        pi * 2 * (1 - percent),
        false,
        filledPaint);
  }

  void myPaint(Canvas canvas, Size size) {
// final paint = Paint(); - что-то вроде кисти
    final paint = Paint();
    final paintCircle = Paint();
    paintCircle.color = Colors.indigoAccent;
// PaintingStyle.fill - фигура заливается
//PaintingStyle.stroke; - только контур фигуры
    paintCircle.style = PaintingStyle.fill;
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
// если круг центр расположен в левом верхнем углу квадрата,
//то у ректангла-прямоугольника также  в левом верхнем углу квадрата родителя
//но уже не центр, а свой верх. лев. угол
//а точнее начальная точка диагонали, но не Offset.zero, а нужно учитывать толщину
//контура - то есть  Offset(1, 1)
//нужно делить пополам strokeWidth,
//например paint.strokeWidth = 10, то у дочернего прямоугольника
//должен быть Offset(5, 5)
    canvas.drawRect(Offset(1, 1) & Size(30, 30), paint);
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    //canvas.drawCircle(Offset(size.width, 0), 30, paintCircle);
//Offset(size.width / 2, size.height / 2) - центр круга в середине конт.
//по умолчанию центр круга в левом верхнем угле контейнера
//радиус круга size.width / 2 вписывает круг ровно ко всем сторонам конт.
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paintCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
