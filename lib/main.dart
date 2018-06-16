import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const access_token = "7903602242.1677ed0.9e0e7f7042bd49b1af78756769486c86";

const api_url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=$access_token";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _image_url;

  @override
  void initState() {
    _incrementCounter();
  }

  Future<void> _updateImage() async {
    final results_response = await http.get(api_url);
    final results_map = json.decode(results_response.body);
    final image_url = results_map['data'][0]['images']['standard_resolution']['url'];
    setState(() {
      _image_url = image_url;
    });
    await new Future.delayed(new Duration(seconds: 10));
    _updateImage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _image_url == null ? new Container (): new Image.network(_image_url, fit: BoxFit.cover),
    );
  }
}
