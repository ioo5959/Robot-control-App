import 'package:flutter/material.dart';
import 'package:f_app/const/colors.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// Flutter Blue Plus 패키지

import 'dart:convert';
import 'dart:typed_data';

class BluetoothSetting extends StatelessWidget {
  int threshold; // 속도값 데이터를 저장할 변수
  BluetoothSetting({Key? key, this.threshold = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothPage(), // BluetoothPage 위젯을 홈 페이지로 설정
    );
  }
}

class BluetoothPage extends StatefulWidget {
  final int threshold; //threshold 값을 전달받을 변수
  BluetoothPage({Key? key, this.threshold = 100}) : super(key: key);

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance; // FlutterBlue 인스턴스를 생성
  List<ScanResult> devices = []; // 검색된 장치 목록을 저장 하는 리스트
  late BluetoothDevice device; // 연결된 장치를 저장할 변수
  bool isConnected = false; // 연결 상태를 저장할 변수

  @override
  void initState() { //위젯이 생성될 때 호출되는 블루투스 검색을 시작하는 함수
    super.initState();
    startScan();
  }

  void startScan(){
    flutterBlue.scanResults.listen((scanResult) { // 블루투스 장치 검색 결과 수신
      setState(() {
        devices = scanResult.toList(); // 검색된 장치를 목록에 추가
      });
      connectToDevice(device);//??
    });

    flutterBlue.startScan();
  }

  void restartScan(){
    devices.clear(); // 기존 장치 목록 초기화
    startScan(); // 스캔 다시 시작
  }


  void connectToDevice(BluetoothDevice device) { // 장치에 연결하는 역할의 함수
    this.device = device; // 장치 저장

    device.connect().then((_){ //연결을 시도
      device.state.listen((connectionState) { //연결 상태 감시하고 업데이트함
        // 연결 상태를 수신
        if (connectionState == BluetoothDeviceState.connected) { // 연결 성공하면
          setState(() {
            isConnected = true; // 연결 여부를 true로 설정
          });
          showSnackBar('연결되었습니다.'); // 연결 성공 메세지


        } else if (connectionState == BluetoothDeviceState.disconnected) {
          // 연결이 해제되면
          setState(() {
            isConnected = false; // 연결 여부를 false로 설정
          });
          showSnackBar('연결이 해제되었습니다.'); // 연결 실패 메시지

        }
      });
    }).catchError((error){
      print('Connection falied: $error');
      showSnackBar('연결에 실패했습니다.'); // 연결 실패 메시지
    });
  }


  void showSnackBar(String message) { // 메세지 표시 함수
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void disconnectDevice() { // 장치와의 연결 해제 역할을 하는 함수
    if (device != null) { // 연결된 장치가 있으면
      device.disconnect(); // 연결 해제
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  void dispose() { //위젯이 해제될 때 호출되는 함수
    flutterBlue.stopScan();
    super.dispose(); // 스캔을 중지함
  }

  @override
  Widget build(BuildContext context) { //위젯 구성
    return Scaffold(
      appBar: AppBar( //AppBar 위젯
        backgroundColor: backgroundColor, //배경색 지정
        title: Text('Bluetooth'), //앱 타이틀 지정
        centerTitle: true, // 가운데 정렬
      ),
      body: ListView.builder(
        itemCount: devices.length, // 목록의 항목 수를 설정
        itemBuilder: (context, index) { // 목록의 각 항목을 생성
          ScanResult device = devices[index]; // 장치를 가져옴
          return ListTile(
            title: Text(device.device.name), // 장치의 이름 표시
            subtitle: Text(device.device.id.toString()), // 장치의 ID 표시
            onTap: () {
              if (isConnected){ // 기기가 블루투스에 연결되어 있으면
                disconnectDevice(); // 연결 해제
              } else { // 기기가 블루투스에 연결 안 되어 있으면
                connectToDevice(device.device); // 장치 연결
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        child: Icon(isConnected ? Icons.cancel : Icons.bluetooth), // 아이콘 설정
        onPressed: () { // 버튼이 눌리면
          if (isConnected){
            disconnectDevice();
          } else {
            restartScan(); // 재탐색 기능 추가
          }
        },
      ),
    );
  }
}
