import 'dart:ui';

import 'package:flutter/material.dart';

import 'models/Animal.dart';
import 'API.dart';
import 'models/Cuidador.dart';

class ManejaCuidadores extends StatefulWidget {
  final Animal a;
  ManejaCuidadores(this.a);
  @override
  _ManejaCuidadoresState createState() => new _ManejaCuidadoresState(a);
}

class _ManejaCuidadoresState extends State<ManejaCuidadores> {
  final Animal a;
  _ManejaCuidadoresState(this.a);
  final _formKey = GlobalKey<FormState>();
  var correoController = TextEditingController();
  DateTime? fechaIngreso = DateTime.now();
  Future<List<Cuidador>> lc = new Future.value([]);

  @override
  initState(){
    super.initState();
    lc= API.getCuidadoresAnimal(a.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cuidadores para ${a.nombre}", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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
        body: ListView(
          children: [
              Column(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5,left:25.0, right:25, bottom:20),
                      child: Card(
                        elevation: 8.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          //margin: EdgeInsets.all(25.0),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Align(alignment: Alignment.centerLeft,child: Text("Cuidadores Asignados",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                              ),
                        Divider(),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future:lc,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if(snapshot.hasData){
                                  return ListBody(

                                      children: snapshot.data.map<Widget>(
                                          (l) => (
                                          ListTile(title: Text("${l.nombre} (\#${l.idCuidador})"),
                                          subtitle: Text("${l.correo}"),
                                            trailing: InkWell(child: Icon(Icons.delete_forever),
                                                onTap: () async {
                                                  print("Borrando a ${l.nombre} del cuidado de ${a.nombre}");
                                                  bool valor= await API.desasignarCuidadorAnimal(a.id!, l.idCuidador);
                                                  if(valor){
                                                    final snackbar = SnackBar(content: Text("Asignación eliminada."));
                                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                    setState(() {
                                                      lc= API.getCuidadoresAnimal(a.id!);
                                                    }
                                                    );
                                                  }
                                                  else{
                                                    final snackbar = SnackBar(content: Text("Error al eliminar Asignación."));
                                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                  }




                                                }
                                                )
                                          )
                                          )
                                      ).toList()

                                  );
                                }
                                else if(snapshot.hasError){
                                  return Text("Error");
                                }
                                else return SizedBox(height:100, width:100,child: Center(child: CircularProgressIndicator()));

                              },

                            ),
                        ),
                        /*Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de animal:", textAlign: TextAlign.start, )),
                        ),*/
                      ]),
                          )),
                    ),
                    Form(
                      key:_formKey,
                      child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          elevation:8,
                          margin: EdgeInsets.only(left:30.0, right:30, top:8, bottom:20),
                          child: ExpansionTile(
                            title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(alignment: Alignment.centerLeft,child: Text("Asignar un Cuidador",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                      ),
                            children: <Widget>[
                              Column(
                                children:[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: correoController,
                                      scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.alternate_email),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                        labelText: 'Correo del Cuidador',
                                      ),),

                                  ),
                                  MaterialButton(child: Text("Asignar"),onPressed: () async {
                                      bool valor = await API.asignaCuidadorAnimal(a.id!, correoController.text);
                                      if(valor){
                                        final snackbar = SnackBar(content: Text("Asignación exitosa."));
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                        correoController.text='';
                                        setState(() {
                                          lc= API.getCuidadoresAnimal(a.id!);
                                        }
                                        );
                                      }
                                      else{
                                        final snackbar = SnackBar(content: Text("Error al asignar."));
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                      }
                                  }
                                  )

                                  ]

                            ),]
                          )
                      ),
                    ),

                    /*Container(
                      width: 250,
                      height: 60,
                      decoration: ShapeDecoration(
                        shape: StadiumBorder(),
                        gradient: LinearGradient(begin: Alignment.topLeft, end:Alignment.bottomRight,
                            colors: [Color(0xff48c6ef), Color(0xff6f86d6)
                            ]),
                      ),
                      child: MaterialButton(
                          elevation: 10.0,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: StadiumBorder(),
                          onPressed: () {
                            if (_formKey.currentState!.validate())_showMyDialog();},
                          child: Text('Guardar Mascota', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Nunito'),)
                      ),
                    ),*/
                    SizedBox(height:50),
                  ],
                ),



            ],

        )]));
  }


 /* Future<void> _showMyDialog() async {
    return showDialog<void> (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog (title: Text("Confirme los datos"),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                    Text("Nombre:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(nombreController.text),
                    Text("Especie:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(especie),
                    Text("Raza:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(razaController.text.isEmpty?'No especificado':razaController.text),
                    Text("Sexo:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(sexo==0?'Macho':'Hembra'),
                    Text("Esterilizado:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(castrado?'Si':'No'),
                    Text("Fecha de Nacimiento:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(fechaNacimiento==null?'No especificado':fechabonita(fechaNacimiento!)),
                    Text("Color:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(colorController.text.isEmpty?'No especificado':colorController.text),
                    Text("Observaciones:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(observacionesController.text.isEmpty?'No especificado':observacionesController.text),

                  ]
                  )
              ),
              actions: [
                TextButton(child: Text("CANCELAR", style: TextStyle(color:Theme.of(context).backgroundColor),), onPressed:(){
                  Navigator.pop(context);
                }
                ),
                TextButton(child: Text("OK", style:TextStyle(color:Theme.of(context).accentColor)), onPressed:() async {
                  Animal an=Animal(nombre: nombreController.text,
                                  especie: especie,
                                  sexo: sexo==0?'Macho':'Hembra',
                                  raza: razaController.text.isEmpty?'No especificado':razaController.text,
                                  esterilizado: castrado,
                                  color: colorController.text.isEmpty?'No especificado':colorController.text,
                                  fechaNacimiento: fechaNacimiento,
                                  observaciones: observacionesController.text.isEmpty?'No especificado':observacionesController.text
                  );
                  bool resultado = await API.guardarAnimal(an);
                  if(resultado){
                    final snackbar = SnackBar(content: Text("Mascota registrada exitosamente."));
                    //TO-DO: Cambiar por ruta nombrada en vez de pop().
                    Navigator.pop(context);
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  else {
                    final snackbar = SnackBar(content: Text("Falló al registrar la mascota."), backgroundColor: Colors.red);
                    //TO-DO: Cambiar por ruta nombrada en vez de pop().
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);

                  }

                }
                )
              ]

          );
        }
    );
  }
*/
  String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}
