import 'package:flutter/material.dart';
import 'package:f_app/const/colors.dart';
import 'package:f_app/screen/bluetooth_screen.dart';

//ManualControl 위젯: Text, Slider
class ManualControl extends StatelessWidget {
  final int threshold; //Slider의 현잿값

  final ValueChanged<int> onThresholdChange; //Slider가 변경될 때마다 실행되는 함수.
  // onThresholdChange함수는 연결된 기기의 속도를 제어함. 해당 값의 데이터를 아두이노에  블루투스로 전송함.

  const ManualControl({
    Key? key,
    //threshold와 onThresholdChange는 manual screen에서 입력
    required this.threshold,
    required this.onThresholdChange,

  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //앱바 위젯
        backgroundColor: backgroundColor, //배경색 지정
        title: Text('수동모드'), //앱 타이틀 지정
        centerTitle: true, // 가운데 정렬
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Flexible(flex: 3,
                  child: Container(
                    color: backgroundColor,
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // 위쪽 방향키 동작 구현
                                // 누르면 기기의 방향이 앞으로 설정됨. 아두이노에 키값 데이터 전송.
                              },
                              iconSize: 100, //아이콘 크기 조정
                              icon: Icon(
                                Icons.arrow_drop_up_rounded,
                                color: Colors.white, //흰색으로 변경
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // 왼쪽 방향키 동작 구현
                                // 누르면 기기의 방향이 왼쪽으로 설정됨. 아두이노에 키값 데이터 전송.
                              },
                              iconSize: 100, //아이콘 크기 조정
                              icon: Icon(
                                Icons.arrow_left_rounded,
                                color: Colors.white, //흰색으로 변경
                              ),
                            ),
                            SizedBox(width: 100.0),
                            IconButton(
                              onPressed: () {
                                // 오른쪽 방향키 동작 구현
                                // 누르면 기기의 방향이 오른쪽으로 설정됨. 아두이노에 키값 데이터 전송.
                              },
                              iconSize: 100, //아이콘 크기 조정
                              icon: Icon(
                                Icons.arrow_right_rounded,
                                color: Colors.white, //흰색으로 변경
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // 아래쪽 방향키 동작 구현
                                // 누르면 기기의 방향이 뒤로 설정됨. 아두이노에 키값 데이터 전송.
                              },
                              iconSize: 100, //아이콘 크기 조정
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.white, //흰색으로 변경
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ),

              SizedBox(width: 8.0), // 텍스트와 슬라이더 사이 간격 조절
              Flexible(flex: 1,
                child: Container(
                  color: backgroundColor,
                  child: Column(
                      children: [
                        Row( //왼쪽 정렬
                          children:[
                            Padding( //해당 위젯 왼쪽에 공백 만드는 위젯
                              padding: EdgeInsets.only(left: 30.0),
                              child: Flexible(
                                child: Text( //text 위젯
                                  '속도',
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          min: 30, //최솟값
                          max: 250, //최댓값
                          divisions: 8, //최솟값과 최댓값 사이 구간 개수
                          value: threshold.toDouble(), //슬라이더 선택값
                          onChanged: (double value) {
                            int intValue = value.toInt(); // 슬라이더 값인 double을 정수형으로 변환
                            onThresholdChange(intValue); // 변환한 정수형 값을 콜백 함수에 전달
                          }, //값 변경 시 실행되는 함수
                          label: threshold.toStringAsFixed(1),//표싯값
                        ),
                      ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
