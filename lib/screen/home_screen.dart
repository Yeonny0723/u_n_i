import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  final msgController = TextEditingController();
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              // -- 이미지 링크 삽입
              'https://plus.unsplash.com/premium_photo-1671578324515-b7c3a68c0002?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            fit: BoxFit.cover, // -- 화면 너비 fit
            opacity: 0.8,
          )),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(),
              _MiddlePart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
                onTapMsg: onTapMsg,
                message: _message,
              ),
              _BottomPart()
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    final DateTime now = DateTime.now();

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _updateMsg() {
    setState(() {
      _message = msgController.text;
    });
  }

  void onTapMsg() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('메시지를 입력해주세요.'),
          content: Container(
            color: Colors.white,
            height: 100.0,
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '메시지',
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                _updateMsg();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _TopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Expanded(
        flex: 2,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'U&I',
            style: textTheme.displayLarge,
          )
        ]));
  }
}

class _MiddlePart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;
  final VoidCallback onTapMsg;
  final String message;

  _MiddlePart({
    required this.selectedDate,
    required this.onPressed,
    required this.onTapMsg,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final now = DateTime.now();

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: onTapMsg,
                child: Text(
                  message.trim() == "" ? "클릭하여 메시지 입력" : message,
                  style: textTheme.bodyMedium,
                ),
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).difference(selectedDate).inDays + 1}',
            style: textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(""));
  }
}
