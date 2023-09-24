import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100], // [<<opacity>>]
        body: SafeArea(
          bottom: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // -- Expanded로 비율 반반
                _TopPart(),
                _BottomPart()
              ],
            ),
          ),
        ));
  }
}

class _TopPart extends StatelessWidget {
  // _: Private
  const _TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // -- Expanded로 비율 반반
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          'U&I',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80,
          ),
        ),
        Column(children: [
          Text('우리 처음 만난날',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sunflower',
                fontSize: 30.0,
              )),
          Text('2021.12.27',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 20.0)),
        ]),
        IconButton(
            iconSize: 60.0,
            onPressed: () {
              // -- ios. dialog (화면을 덮는 또 다른 화면)
              showCupertinoDialog(
                  context: context,
                  barrierDismissible: true, // -- dialog 바깥을 누르면 꺼지도록
                  builder: (BuildContext context) {
                    // -- 플러터 특. 어디 정렬인지 말 안해주면 화면 다 잡아먹음.
                    return Align(
                      // -- 정렬해주기
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: 300.0,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime date){
                            print(date);
                          },
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            )),
        Text(
          'D+1',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'sunflower',
              fontSize: 50.0,
              fontWeight: FontWeight.w700),
        ),
      ]),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset('asset/img/middle_image.png'));
  }
}
