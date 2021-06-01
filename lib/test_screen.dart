import 'package:flutter/material.dart';
import 'dart:math' as math;

class Testeos extends StatelessWidget {
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
                Text(
                  'Hola chico 20',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Hola grande 72',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 72,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);// Navigate back to first route when tapped.
                  },
                  child: Text('Volver'),

                ),
                Expanded(
                    child: Material(
                        child: ListView(children: [
                          for (int i = 0; i < 10; i++)
                            InkWell(
                                splashColor: Colors.white30,
                                child: ColoredBox(
                                  color: Theme.of(context).primaryColor,

                                    child: Container(
                                      width: 30,
                                        height:100,
                                        color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                            .withOpacity(1.0))),
                                onTap: () {
                                  print("Tocado");
                                })
                        ])))
              ])),
    );
  }
}
