import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {

  final _currencies = [ 'Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController distantController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String result = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;
    return Scaffold (
      appBar: AppBar(
        title:Text("Hello"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container (
        padding: EdgeInsets.all(15.0),
        child: Column(
        children: <Widget> [
          Padding(
           padding: EdgeInsets.only(top: _formDistance,
           bottom: _formDistance),
           child:TextField(
            controller: distantController,
            decoration: InputDecoration(
              labelText: 'Distance',
              hintText: 'e.g 124',
              labelStyle: textstyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
            keyboardType: TextInputType.number,
          ),
          ),
        Padding(
         padding: EdgeInsets.only(top: _formDistance,
         bottom: _formDistance),
         child: TextField(
            controller: avgController,
            decoration: InputDecoration(
                labelText: 'Distance per Unit',
                hintText: 'e.g 17',
                labelStyle: textstyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
         padding: EdgeInsets.only(top: _formDistance,
         bottom: _formDistance),
         child: Row(children: <Widget>[
          Expanded (child: TextField(
            controller: priceController,
            decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'e.g 1.65',
                labelStyle: textstyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
            keyboardType: TextInputType.number,
          )),
          Container(width: _formDistance*5),
          Expanded(
              child: DropdownButton<String>(
            items: _currencies.map((String value){
              return DropdownMenuItem<String> (
              value: value,
              child: Text(value)
              );
            }).toList(),
            value: _currency,
            onChanged: (String value) {
              _onDropdownChanged(value);
            },
              ))])
        ),
          Row(children: <Widget>[
            Expanded( child: RaisedButton(
            color: Theme.of(context).primaryColorDark,
            textColor: Theme.of(context).primaryColorLight,
            onPressed: () {
              setState(() {
                result = _calculate();
              });
            },
            child: Text(
              'Submit',
              textScaleFactor: 1.5,
            )
          )),
          Expanded( child: RaisedButton(
              color: Theme.of(context).buttonColor,
              textColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                setState(() {
                  result = _reset();
                });
              },
              child: Text(
                'Reset',
                textScaleFactor: 1.5,
              )

          )),
          ]),
          Text(result),
       ]
        ),
    ));
  }

_onDropdownChanged(String value) {
    setState((){
      this._currency = value;
    });
}

String _calculate(){

    double _distance = double.parse(distantController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of your trip is ' + _totalCost.toStringAsFixed(2) + ' ' + _currency;
    return _result;
}

    _reset () {
    distantController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
       result = '';
    });
  }

}