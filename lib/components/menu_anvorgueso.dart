import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:michi_manager/registrarse.dart';
import 'package:michi_manager/viewListadoMascotas.dart';
import 'package:michi_manager/viewGraficos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../add_alimentacion.dart';
import '../add_mascota.dart';
import '../add_medicamento.dart';
import '../add_peso.dart';
import '../login.dart';
import '../test_charts.dart';

class MenuAnvorgueso extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MenuAnvorguesoState();
}

class MenuAnvorguesoState extends State<MenuAnvorgueso>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Future<String> nombre;
  late Future<String> correo;
  late Future<int> id;
  var f = SharedPreferences.getInstance();

  @override
  initState() {
    super.initState();
    nombre=getNombre();
    correo=getCorreo();
    id=getId();
  }

  Future<String> getNombre() async {
    var p= await f;
    return p.getString("nombre")??'Sinnombre';
  }
  Future<String> getCorreo() async {
    var p= await f;
    return p.getString("correo")??'sin@mail.fail';
  }
  Future<int> getId() async {
    var p= await f;
    return p.getInt("id_cuidador")??-1;
  }

  @override
  Widget build(BuildContext context){
    return
      Drawer(
        key:_scaffoldKey,
          child: ListView(children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: CircleAvatar(backgroundColor: Color(0xff6f86d6),
                      child:FutureBuilder(
                        future: nombre ,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData) return Text("${snapshot.requireData[0]}", style:TextStyle(color: Colors.white, fontSize: 30));
                          else return Text("Error1234", style:TextStyle(color: Colors.red, fontSize: 25));
                        },),
                      /*backgroundImage: new AssetImage('fotos/logo.png'),*/
                      radius: 40,
                    ),
                  ),
                  FutureBuilder(future: Future.wait([nombre,id]),
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if(snapshot.hasData) return Text("${snapshot.requireData[0]} (#${snapshot.requireData[1]})", style:TextStyle(color: Colors.white, fontSize: 20));
                    else return Text("SinNombre", style:TextStyle(color: Colors.red, fontSize:20));
                  },),
                  //Text("Nombre Cuidador", style: TextStyle(fontSize: 20)),
                  FutureBuilder(future: correo, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData) return Text("${snapshot.data}", style:TextStyle(color: Colors.white60, fontSize: 12));
                    else return Text("sin@correo.cl", style:TextStyle(color: Colors.red, fontSize: 12));
                  },),

                ],
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            AbsorbPointer(child: ListTile(title: Text('Animales'))),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar mascota"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AgregaPaciente()));


              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted),
              title: Text("Listado de Animales"),
              //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListaAnimales()));
              },
            ),
            Divider(),
            AbsorbPointer(child: ListTile(title: Text('Eventos'))),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar Alimentación"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAlimentacion()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar Medicación"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicamento()));
              },
            ),
            /*ListTile(
              leading: Icon(Icons.playlist_add_check),
              title: Text("Ver eventos"),
              //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaEventos()));
              },
            ),*/
            Divider(),
            AbsorbPointer(child: ListTile(title: Text('Registro de Peso'))),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Agregar peso"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPeso()));
              },
            ),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text("Gráficos de Peso"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGraficos()));
              },
            ),
            /*Divider(),
            AbsorbPointer(child: ListTile(title: Text('Alimentos'))),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Registrar alimento"),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddAlimento()));
              },
            ),*/
            Divider(),
            AbsorbPointer(child: ListTile(title: Text('Logins'))),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Registrarse"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrarseScreen()));
              },
            ),

            AbsorbPointer(child: ListTile(title: Text('Extras'))),
            ListTile(
              leading: Icon(Icons.precision_manufacturing_rounded),
              title: Text("Experimentos"),
              //title: Row(children: <Widget>[Icon(Ionicons.ios_rocket), Text("Experimentos")],),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TestCharts()));
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
                    applicationName: "Maneja tus Michis",
                    applicationVersion: "0.2-dev",
                    applicationLegalese: "Todos los derechos reservados. (?)");
              },
            ),

          ]))
    ;
  }

}
