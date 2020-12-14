import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'BMI Calculator'),
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
  //TextEditingController weightController = TextEditingController();
  //TextEditingController heightController = TextEditingController();

  double _weight = 0.0;
  double _height = 0.0;
  double _bmi = 0.0;

  void _setWeight(String weight) {
    setState(() {
      _weight = double.tryParse(weight) ?? 0.0;
    });
  }

  void _setHeight(String height) {
    setState(() {
      _height = double.tryParse(height) ?? 0.0;
    });
  }

  void _calculateBMI() {
    setState(() {
      _bmi = (_weight / pow(_height, 2)) * 10000;
    });

    if (_bmi < 18.5) {
      _showDialog('You are underweight!');
    } else if (_bmi >= 18.8 && _bmi <= 24.9) {
      _showDialog('You are having normal weight. Well done!');
    } else if (_bmi >= 25 && _bmi <= 29.9) {
      _showDialog('You are overweight!');
    } else if (_bmi >= 30) {
      _showDialog('You are obese. Please watch your diet!');
    }
  }

  void _showDialog(String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("BMI Status", textAlign: TextAlign.center),
          content: new Text(status),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(widget.title, textAlign: TextAlign.center)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  //controller: weightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Weight (kg)',
                  ),
                  onChanged: (text) {
                    _setWeight(text);
                  },
                  keyboardType: TextInputType.number,
                )),
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  //controller: heightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Height (cm)',
                  ),
                  onChanged: (text) {
                    _setHeight(text);
                  },
                  keyboardType: TextInputType.number,
                )),
            Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text('Calculate'),
                  onPressed: _calculateBMI,
                )),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(_bmi.toStringAsFixed(2)),
            )
          ],
        ),
      ),
    );
  }
}
