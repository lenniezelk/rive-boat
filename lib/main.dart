import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:statsfl/statsfl.dart';

void main() {
  runApp(StatsFl(align: Alignment.bottomCenter, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taggy Boat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'AArgh Matey!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fileName = 'assets/boat.riv';
  Artboard artboard;
  SimpleAnimation controller;
  SimpleAnimation controller2;
  SimpleAnimation controller3;
  SimpleAnimation controller4;
  SimpleAnimation controller5;
  SimpleAnimation controller6;

  _loadRive() async {
    final bytes = await rootBundle.load(fileName);
    final file = RiveFile();
    if (file.import(bytes)) {
      setState(() {
        controller = SimpleAnimation("waves");
        controller2 = SimpleAnimation("pistons");
        controller3 = SimpleAnimation("boat");
        controller4 = SimpleAnimation("smoke");
        controller5 = SimpleAnimation("stars 2 3");
        controller6 = SimpleAnimation("stars 4 5");

        artboard = file.mainArtboard
          ..addController(controller)
          ..addController(controller2)
          ..addController(controller3)
          ..addController(controller4)
          ..addController(controller5)
          ..addController(controller6);
      });
    }
  }

  @override
  void initState() {
    _loadRive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: artboard != null
                    ? Rive(
                        artboard: artboard,
                        fit: BoxFit.cover,
                      )
                    : Container())
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
