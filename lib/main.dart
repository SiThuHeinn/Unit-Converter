import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _numberFrom;
  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;
  var fruits = ['Apple', 'Orange', 'Mango', 'Grape', 'Guava'];

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];


  final Map<String, int> _measureMap = {
    'meters' : 0,
    'kilometers' : 1,
    'grams' : 2,
    'kilograms' : 3,
    'feet' : 4,
    'miles' : 5,
    'pounds (lbs)' : 6,
    'ounces' : 7
  };

  final dynamic _formulas = {
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };



  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.blue[900],
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Unit Converter'),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child:  Column(
              children: [
                Spacer(),
                Text(
                  'Value',
                  style: labelStyle,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Please insert the measure",
                  ),
                  style: inputStyle,
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberFrom = rv;
                      });
                    }
                  },
                ),
                Spacer(
                  flex: 2,
                ),
                Text(
                  'From',
                  style: labelStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures
                      .map(
                        (measure) => DropdownMenuItem(
                        value: measure, child: Text(measure)),
                  )
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _startMeasure = newValue;
                    });
                  },
                  value: _startMeasure,
                ),
                Spacer(),
                Text(
                  'To',
                  style: labelStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  style: inputStyle,
                  isExpanded: true,
                  items: _measures
                      .map(
                        (measure) => DropdownMenuItem(
                        value: measure, child: Text(measure)),
                  )
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _convertedMeasure = newValue;
                    });
                  },
                  value: _convertedMeasure,
                ),
                Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom == 0){
                      return;
                    }else{
                      convert(_numberFrom, _startMeasure, _convertedMeasure);
                    }
                  },
                  child: Text('Convert'),
                ),
                Spacer(),
                Text(
                  (_resultMessage == null) ? '' : _resultMessage.toString(),
                  style: labelStyle,
                ),
                Spacer(
                  flex: 10,
                ),
              ],
            ),
          )),
    );
  }


  void convert(double value, String from, String to){
    int nFrom = _measureMap[from];
    int nTo = _measureMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    double result = value * multiplier;

    if(result == 0){
      _resultMessage = 'This conversion can not be performed';
    }else{
      _resultMessage = '${_numberFrom.toString()} ${_startMeasure.toString()} are ${result.toString()} ${_convertedMeasure.toString()}';
    }

    setState(() {
      _resultMessage = _resultMessage;
    });

  }

}
