import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  List<MenuRowData> firstMenuRowData = [
    MenuRowData(Icons.label, 'Избранное'),
    MenuRowData(Icons.call, 'Звонки'),
    MenuRowData(Icons.computer, 'Устройства'),
    MenuRowData(Icons.favorite, 'Папка с чатами'),
  ];

  List<MenuRowData> secondMenuRowData = [
    MenuRowData(Icons.notifications, 'Уведомления и звуки'),
    MenuRowData(Icons.privacy_tip, 'Конфиденциальность'),
    MenuRowData(Icons.data_array, 'Данные и память'),
    MenuRowData(Icons.brush, 'Оформление'),
    MenuRowData(Icons.language, 'Язык'),
    MenuRowData(Icons.sticky_note_2, 'Стикеры')
  ];

  List<MenuRowData> thirdMenuRowData = [
    MenuRowData(Icons.lock_clock, 'Apple watch'),
  ];

  List<MenuRowData> fourthMenuRowData = [
    MenuRowData(Icons.help, 'Помощь'),
    MenuRowData(Icons.question_answer, 'Вопросы о Telegram'),
  ];

  UserProfile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('настройки'),
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: [
              _UserInfo(),
              SizedBox(
                height: 15,
              ),
              _MenuWidget(
                menuRow: firstMenuRowData,
              ),
              SizedBox(
                height: 15,
              ),
              _MenuWidget(
                menuRow: secondMenuRowData,
              ),
              SizedBox(
                height: 15,
              ),
              _MenuWidget(
                menuRow: thirdMenuRowData,
              ),
              SizedBox(
                height: 15,
              ),
              _MenuWidget(
                menuRow: fourthMenuRowData,
              )
            ],
          ),
        ));
  }
}

class MenuRowData {
  final IconData icon;
  final String text;

  MenuRowData(this.icon, this.text);
}

class _MenuWidgetRow extends StatelessWidget {
  final MenuRowData data;

  const _MenuWidgetRow({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(data.icon),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text(data.text)),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}

class _MenuWidget extends StatelessWidget {
  final List<MenuRowData> menuRow;
  const _MenuWidget({Key? key, required this.menuRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: menuRow.map((data) => _MenuWidgetRow(data: data)).toList(),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _UserAvatarWidget(),
            SizedBox(
              height: 8,
            ),
            _UserNickWidget(),
            SizedBox(
              height: 8,
            ),
            _UserPhoneWidget(),
            SizedBox(
              height: 8,
            ),
            _UserTelegramNickWidget(),
          ],
        ),
      ),
      Positioned(
        top: 25,
        right: 25,
        child: Text(
          'Изм.',
          style: TextStyle(color: Colors.blue, fontSize: 17),
        ),
      )
    ]);
  }
}

class _UserTelegramNickWidget extends StatelessWidget {
  const _UserTelegramNickWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '@wgodunoff',
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
    );
  }
}

class _UserPhoneWidget extends StatelessWidget {
  const _UserPhoneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '+7(705)123 45 67',
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
    );
  }
}

class _UserNickWidget extends StatelessWidget {
  const _UserNickWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Vyacheslav Godunov',
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}

class _UserAvatarWidget extends StatelessWidget {
  const _UserAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 90, height: 90, child: Placeholder());
  }
}
