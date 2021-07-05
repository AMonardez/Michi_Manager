import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class TestCharts extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testeos")
      ),
      body: Center(
          child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, //.center pega todo y lo junta
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hola mediano 40',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                  ),
                ),
              ])),
    );
  }
}
