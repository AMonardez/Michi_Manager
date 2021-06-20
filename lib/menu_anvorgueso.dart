import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michi_manager/pantalla_eventos.dart';
import 'package:michi_manager/test_screen.dart';
import 'package:michi_manager/testapi.dart';

import 'add_alimentacion.dart';
import 'add_foto.dart';
import 'add_mascota.dart';
import 'add_medicamento.dart';
import 'add_peso.dart';

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
              title: Text("Agregar Alimentación"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAlimentacion()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar Medicación"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicamento()));
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_check),
              title: Text("Ver eventos"),
              //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaEventos()));
              },
            ),
            Divider(),
            AbsorbPointer(child: ListTile(title: Text('Registro de Peso'))),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar peso"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPeso()));
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
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Test api"),
              //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TestApi()));
              },
            )
          ]))
    ;
  }

}
