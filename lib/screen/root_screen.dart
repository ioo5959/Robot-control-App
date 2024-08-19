import 'package:flutter/material.dart';
import 'package:f_app/screen/auto_screen.dart';
import 'package:f_app/screen/manual_screen.dart';
import 'package:f_app/screen/bluetooth_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with
TickerProviderStateMixin{
  TabController? controller;
  int threshold = 100; //속도의 기본값 설정

  @override
  void initState(){
    super.initState();

    controller = TabController(length: 3, vsync: this); //컨트롤러 초기화하기

    //컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    controller!.addListener(tabListener);
  }

  tabListener(){ //리스너로 사용할 함수
    setState(() {

    });
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener); //리스너에 등록한 함수 등록 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: TabBarView( //탭 화면을 보여줄 위젯
        controller: controller, //컨트롤러 등록하기
        children: renderChildren(),
      ),
      //아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren(){
    return [
      //자동모드 탭 선택시 함수실행
      AutomaticControl(),
      //수동모드 탭 선택시 실행
      ManualControl( //기존에 있던 Contaniner 코드를 통째로 교체
        threshold: threshold, //threshold 값을 전달
        onThresholdChange: onThresholdChange,
      ),
      //블루투스 설정 탭 선택시 실행
      BluetoothSetting(
        threshold: threshold, // threshold 값을 수동모드 페이지로 전달
      ),
    ];
  }


  void onThresholdChange(int val){ //속도 슬라이더 변경 시 실행할 함수
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation(){
    //탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      //현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
        onTap: (int index){ //탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
          //애니메이션으로 지정한 탭으로 TabBarView가 전환됨
        });
        },
        items: [
          BottomNavigationBarItem( //하단 탭바의 각 버튼을 구현
            icon: Icon(
              Icons.auto_mode,
            ),
            label: '자동',
          ),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.touch_app,
          ),
            label: '수동',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bluetooth,
            ),
            label: '블루투스',
          ),
        ],
    );
  }
}
