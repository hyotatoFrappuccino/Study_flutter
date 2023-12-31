import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'sendDataExample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(home: CupertinoNativeApp());
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NativeApp(),
      );
    }
  }
}

class CupertinoNativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NativeApp();
  }
}

class NativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NativeApp();
}

class _NativeApp extends State<NativeApp> {
  // 안드로이드와 통신 채널로 사용할 MethodChannel
  static const platform = const MethodChannel('com.flutter.dev/info');
  static const platform3 = const MethodChannel('com.flutter.dev/dialog');
  String _deviceInfo = 'Unknown info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native 통신 예제'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                _deviceInfo,
                style: TextStyle(fontSize: 30),
              ),
              TextButton(
                onPressed: () {
                  _showDialog();
                },
                child: Text('네이티브 창 열기')
              ),
            ],
          ),
          // child: Text(
          //   _deviceInfo,
          //   style: TextStyle(fontSize: 30),
          // ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      // platform.invokeMethod > 네이티브 API 호출
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info: ${e.message}';
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _showDialog() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch (e) {}
  }
}

