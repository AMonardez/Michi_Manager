import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/Animal.dart';
import 'API.dart';


class ListaAnimales extends StatefulWidget {
  @override
  _ListaAnimalesState createState() => new _ListaAnimalesState();
}

class _ListaAnimalesState extends State<ListaAnimales> {
  late Future<Animal> an;
  late Future<List<Animal>> listadoanimalitos;


  @override
  initState(){
    super.initState();
    listadoanimalitos = API.getAnimales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mascotas Registradas", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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
        body:
        Column(
          children: [
            Flexible(
              child: FutureBuilder<List<Animal>>(
                future: listadoanimalitos,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    /*for(Animal a in snapshot.requireData) print (a.toString());*/
                    return new ListView.builder(
                      itemCount: snapshot.requireData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          margin: EdgeInsets.only(top:10, left:25, right:25, bottom:10),
                          elevation:8,
                          child: ExpansionTile(
                            /*leading: */
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(backgroundColor: Colors.cyan,
                                  child: Text(snapshot.requireData[index].nombre[0], style: TextStyle(fontSize: 30, color: Colors.white),),
                                  /*backgroundImage: new AssetImage('fotos/logo.png'),*/
                                  radius: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.requireData[index].nombre, style: TextStyle(fontSize: 24)),
                                      Text(snapshot.requireData[index].especie, style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            children: [Padding(
                              padding: const EdgeInsets.only(top:8.0, left:20, right:8, bottom:8),
                              child: ListTile(
                                title:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sexo:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].sexo),
                                    Text("Raza:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].raza==null?"No especificado":snapshot.requireData[index].raza!),
                                    Text("Esterilizado:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].esterilizado==true?'Si':'No'),
                                    Text("Fecha de Nacimiento:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].fechaNacimiento==null?'No especificado':fechabonita(snapshot.requireData[index].fechaNacimiento!)),
                                    Text("Color:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].color==null?'No especificado':snapshot.requireData[index].color!),
                                    Text("Observaciones:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].observaciones==null?'No especificado':snapshot.requireData[index].observaciones!),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15,left: 8.0, right:8, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Spacer(flex:1),
                                          Icon(Icons.edit),
                                          Spacer(flex:2),
                                          Icon(Icons.camera_alt),
                                          Spacer(flex: 2),
                                          Icon(Icons.delete_forever),
                                          Spacer(flex:1),


                                        ]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),]
                          ),
                        );
                      },
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16),

                    )
                    ;
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),




          ],
        )






        );
  }
  static String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }


}