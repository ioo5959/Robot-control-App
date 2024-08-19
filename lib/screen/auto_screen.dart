import 'package:flutter/material.dart';
import 'package:f_app/const/colors.dart';
import 'package:f_app/screen/bluetooth_screen.dart';

class AutomaticControl extends StatelessWidget {
  const AutomaticControl({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MachineControlScreen(),
    );
  }
}

class MachineControlScreen extends StatefulWidget {
  @override
  _MachineControlScreenState createState() => _MachineControlScreenState();
}

class _MachineControlScreenState extends State<MachineControlScreen> {
  String status = '정지'; // 기계의 상태를 나타내는 변수

  void startMachine() { // 작동 함수
    setState(() {
      status = '작동 중';
      // 작동을 위한 실제 로직 추가
      // 기계와의 통신, 명령 전송 등
    });
  }

  void stopMachine() { //정지 함수
    setState(() {
      status = '정지';
      // 정지를 위한 실제 로직 추가
      // 기계와의 통신, 명령 전송 등
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('자동모드'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '상태: $status',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: startMachine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    child: Text('작동'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: stopMachine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    child: Text('중지'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
