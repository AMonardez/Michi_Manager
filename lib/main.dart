import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:michi_manager/menu_anvorgueso.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maneja tus Michis',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito'
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final String title='Inicio';

  @override
  Widget build(BuildContext context) {
    int numeros=10;
    return Scaffold(
        drawer: MenuAnvorgueso(),
        appBar: AppBar(title: Text(this.title, style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff48c6ef), Color(0xff6f86d6)
                    ])
            ),
          ),

        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //.center pega todo y lo junta
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text("Aqui va la timeline de los eventos"),
              Expanded(
                  child: Timeline(children: <Widget>[

                for (int i = 0; i < numeros; i++)
                  if(i==0)
                  TimelineTile(
                      oppositeContents: Text((i + 1).toString() + ":00"),
                      contents: Text("Evento" + (i+1).toString()),

                      node: TimelineNode(
                          indicator: OutlinedDotIndicator(),
                          endConnector: SizedBox(
                            height: 20.0,
                            child: DashedLineConnector(),
                          ))
                  )
                  else if(i==numeros-1)
                    TimelineTile(
                        oppositeContents: Text((i + 1).toString() + ":00"),
                        contents: Text("Evento" + (i+1).toString()),

                        node: TimelineNode(
                            indicator: OutlinedDotIndicator(),
                            startConnector: SizedBox(
                              height: 20.0,
                              child: DashedLineConnector(),
                            ),
                            )
                    )
                    else TimelineTile(
                        oppositeContents: Text((i + 1).toString() + ":00"),
                        contents: Text("Evento" + (i+1).toString()),

                        node: TimelineNode(
                            indicator: OutlinedDotIndicator(),
                            startConnector: SizedBox(
                              height: 20.0,
                              child: DashedLineConnector(),
                            ),
                            endConnector: SizedBox(
                              height: 20.0,
                              child: DashedLineConnector(),
                            ))
                    )

              ])),
              Divider(),
              Container(child: Text("Lista de recordatorios futuros")),
              Expanded(
                child: Material(
                    child: ListView(children: [
                  for (int i = 0; i < 40; i++)
                    Card(
                        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.bug_report_rounded),
                        title: Text('Alimentación:' + (i + 1).toString()),
                        subtitle: Text('Whiskas (200gr)'),
                      )
                    ]))
                ])),
              ),
              //ListaEventos(),
            ])));
  }
}
