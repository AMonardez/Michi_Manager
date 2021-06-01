import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michi_manager/add_tratamiento.dart';
import 'test_screen.dart';
import 'package:timelines/timelines.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'add_mascota.dart';

void main() => runApp(MyApp());

class MenuAnvorgueso extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return
        Drawer(
            child: ListView(children: <Widget>[
              DrawerHeader(
                child: Text("Nombre usuario cuidador"),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              ),
              AbsorbPointer(child: ListTile(title: Text('Animales'))),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Agregar mascota"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AgregaPaciente()));
                },
              ),
              Divider(),
              AbsorbPointer(child: ListTile(title: Text('Eventos'))),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Agregar eventos"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTratamiento()));
                },
              ),
              Divider(),
              AbsorbPointer(child: ListTile(title: Text('Extras'))),
              ListTile(
                leading: Icon(Icons.precision_manufacturing_rounded),
                title: Text("Experimentos"),
                //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Testeos()));
                },
              ),
              Divider(),
              AbsorbPointer(child: ListTile(title: Text('Otros'))),
              ListTile(
                leading: Icon(Icons.info_rounded),
                title: Text("Acerca de"),
                //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: "Maneja tus michitos",
                      applicationVersion: "0.1-dev",
                      applicationLegalese: "Blablabla");
                },
              )
            ]))
  ;
  }

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maneja tus michis',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
        appBar: AppBar(
          title: new Text(this.title),
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
              )
            ])));
  }
}
