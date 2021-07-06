import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'models/Animal.dart';
import 'API.dart';
import 'models/Cuidador.dart';
import 'models/PlanAlimentacion.dart';
import 'models/PlanMedicacion.dart';

class ManejaMedicacion extends StatefulWidget {
  final Animal a;
  ManejaMedicacion(this.a);
  @override
  _ManejaMedicacionState createState() => new _ManejaMedicacionState(a);
}

class _ManejaMedicacionState extends State<ManejaMedicacion> {
  final Animal a;
  _ManejaMedicacionState(this.a);
  final _formKey = GlobalKey<FormState>();
  var correoController = TextEditingController();
  DateTime? fechaIngreso = DateTime.now();
  late Future<List<PlanMedicacion>> lc;

  @override
  initState(){
    super.initState();
    lc= API.getMedicamentos(a.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Medicación para ${a.nombre}", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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
                      padding: const EdgeInsets.only(top:10,left:25.0, right:25, bottom:20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                        FutureBuilder(
                          future:lc,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.hasData){
                              if(snapshot.requireData.length==0) return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No hay medicamentos registrados.", style:TextStyle(color: Colors.grey)),
                              );
                              else return ListBody(

                                  children: snapshot.data.map<Widget>(
                                      (l) => Card(
                                        elevation: 8,
                                        clipBehavior: Clip.antiAlias,
                                        margin: EdgeInsets.only(top:10, bottom:10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                        child: (
                                        ExpansionTile(leading:Icon(LineIcons.capsules),
                                          title: Text("${l.nombre} (\#${l.idPlan!})"),
                                          children:[
                                            Text("Cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${l.dosis}"),
                                            Text("Periodicidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${l.periodicidad}"),
                                            Text("Fecha de Inicio:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${fechabonita(l.fechaInicio)}"),
                                            Text("Fecha de Termino:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${fechabonita(l.fechaTermino)}"),
                                            Text("Periodicidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${l.periodicidad}"),
                                            Text("Observaciones:", style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text("${l.observaciones}"),

                                            ElevatedButton(child: Row(mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.delete_forever, color: Colors.white),
                                                Text("Eliminar", style: TextStyle(color:Colors.white)),
                                              ],
                                            ), onPressed: () async {
                                              print("Borrando ${l.nombre}");
                                              bool valor= await API.deletePMedicacion(l.idPlan!);
                                              if(valor){
                                                final snackbar = SnackBar(content: Text("Medicación eliminada."));
                                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                setState(() {
                                                  lc= API.getMedicamentos(a.id!);
                                                }
                                                );
                                              }
                                              else{
                                                final snackbar = SnackBar(content: Text("Error al eliminar Medicación."));
                                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                              }
                                            },)
                                          ],
                                        )
                                        ),
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
                        /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de animal:", textAlign: TextAlign.start, )),
                        ),*/
                      ]),
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
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM-yyyy HH:mm', 'es_US').format(dt);
  }

}
