import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import 'manage_cuidadores.dart';
import 'models/Animal.dart';
import 'API.dart';

class ListaAnimales extends StatefulWidget {
  @override
  _ListaAnimalesState createState() => new _ListaAnimalesState();
}

class _ListaAnimalesState extends State<ListaAnimales> {
  late Future<Animal> an;
  late Future<List<Animal>> listadoanimalitos;
  late var proveedor;



  @override
  initState(){
    super.initState();
    listadoanimalitos = API.getMisAnimales("amonardezt@alumnosuls.cl", "1234");
    //listadoanimalitos = Provider.of<MascotasProvider>(context).refrescar;
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

                  if(snapshot.hasData && snapshot.requireData.length == 0) return Padding(
                    padding: const EdgeInsets.only(top:20, left: 15.0, right:15),
                    child: Center(child: Text("No tienes animales a cargo.", style: TextStyle(color:Colors.grey))),
                  );
                    else if (snapshot.hasData) {
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
                                    Text("ID:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(snapshot.requireData[index].id!.toString()),
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
                                          Icon(LineIcons.drumstickWithBiteTakenOut),
                                          Spacer(flex:2),
                                          Icon(LineIcons.capsules),
                                          Spacer(flex: 2),
                                          InkWell(child: Icon(LineIcons.nurse),

                                            onTap: () {
                                                print(snapshot.requireData[index].nombre.toString());
                                                //List<Cuidador> lcc= await API.getCuidadoresAnimal(snapshot.requireData[index].id!);
                                                //for(var l in lcc) print(l.toString());
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ManejaCuidadores(snapshot.requireData[index])));
                                              }
                                          ),
                                          Spacer(flex: 2),
                                          InkWell(child: Icon(LineIcons.trash),
                                          onTap: () async {
                                            bool valor= await API.deleteAnimal(snapshot.requireData[index].id!);
                                            if(valor){
                                              snapshot.requireData.removeAt(index);
                                              final snackbar = SnackBar(content: Text("Mascota eliminada."));
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                              setState(() {
                                                listadoanimalitos = API.getMisAnimales("", "");
                                              });
                                            }
                                            else{
                                              final snackbar = SnackBar(content: Text("Error al eliminar a la mascota."));
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                            }


                                          }),
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
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),




          ],
        )






        );
  }

/*

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Confirme los datos"),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                    Text("ID animal:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(idAnimal!),
                    Text("Peso:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(t.text),
                    Text("Fecha:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(fecha.toString()),
                  ])),
              actions: [
                TextButton(
                    child: Text(
                      "CANCELAR",
                      style: TextStyle(color: Theme.of(context).backgroundColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                TextButton(child: Text("OK", style:TextStyle(color:Theme.of(context).accentColor)), onPressed:() async {
                  RegistroPeso rp= RegistroPeso(fecha: fecha, idAnimal: int.parse(idAnimal!), peso: double.parse(t.text));
                  bool resultado = await API.guardarRegistroPeso(rp);
                  if(resultado){
                    final snackbar = SnackBar(content: Text("Peso registrado exitosamente."));
                    //TO-DO: Cambiar por ruta nombrada en vez de pop().
                    Navigator.pop(context);
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  else {
                    final snackbar = SnackBar(content: Text("Falló al registrar el peso."), backgroundColor: Colors.red);
                    //TO-DO: Cambiar por ruta nombrada en vez de pop().
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);

                  }

                }
                )
              ]);
        });
  }
*/



  static String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }


}
