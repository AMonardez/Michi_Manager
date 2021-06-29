import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'models/Animal.dart';
import 'API.dart';

//TODO: Arreglar que no se inserta la fecha de nacimiento.

class AgregaPaciente extends StatefulWidget {
  @override
  _AgregaPacienteState createState() => new _AgregaPacienteState();
}

class _AgregaPacienteState extends State<AgregaPaciente> {
  final _formKey = GlobalKey<FormState>();
  List<String> listaEspecies = ["Perro", "Gato", "Hamster", "Tortuga", "Iguana", "Otro"];
  List<String> sexos = ["Macho", "Hembra", "No lo sé"];

  var nombreController = TextEditingController();
  var especie;
  var razaController = TextEditingController();
  int? sexo=0;
  bool castrado=false;
  DateTime? fechaNacimiento;//= DateTime.now();
  var colorController = TextEditingController();
  var observacionesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Registrar Mascota", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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
              Form(
                key: _formKey,
                child: Column(children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircleAvatar(backgroundColor: Colors.cyan,
                            child: Icon(Icons.camera_alt, color:Colors.white),
                            backgroundImage: new AssetImage('fotos/logo.png'),
                          radius: 80,
                        ),
                      ),

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
                                  child: Align(alignment: Alignment.centerLeft,child: Text("Datos básicos de la Mascota",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                                ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: nombreController,
                                  scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.edit_rounded),

                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                    labelText: 'Nombre',
                                  ),
                                validator: (String? value){
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre de la mascota no puede estar vacío.';
                                  }
                                  return null;
                                }
                              ),
                          ),
                          /*Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de animal:", textAlign: TextAlign.start, )),
                          ),*/
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                //icon: Icon(Icons.workspaces_filled),
                                hint: especie == null ? Text("") : Text(especie),
                                value: especie,
                                onChanged: (var value) {
                                  setState(() {
                                    especie = value;
                                  });
                                },
                                items: listaEspecies.map((String animal) {
                                  return DropdownMenuItem<String>(value: animal, child: Text(animal));
                                }).toList(),
                                validator: (value) => value == null
                                ? 'Seleccione una especie de la lista.': null,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.pets),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                    labelText: 'Especie',

                                  )

                              ),
                          ),

                          Divider(),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(alignment: Alignment.centerLeft,child: Text("Seleccione el sexo de la mascota:")),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                Row(
                                    mainAxisSize: MainAxisSize.min,
                                children:[
                                  Expanded(
                                    child: ListTile(
                                          title: const Text('Macho'),
                                          leading: Radio<int>(
                                          value: 0,
                                          groupValue: sexo,
                                          onChanged: (int? value) {
                                            setState(() {
                                              sexo = value;
                                            });
                                          },
                                      ),
                                    ),
                                  ),
                                    Expanded(
                                      child:
                                    ListTile(
                                      title: const Text('Hembra'),
                                      leading: Radio<int>(
                                        value: 1,
                                        groupValue: sexo,
                                        onChanged: (int? value) {
                                          setState(() {
                                            sexo = value;
                                          });
                                        },
                                      ),

                                  ),),
                                ],
                              ),
                          ),


                        ]),
                            )),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          elevation:8,
                          margin: EdgeInsets.only(left:30.0, right:30, top:8, bottom:20),
                          child: ExpansionTile(
                            title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(alignment: Alignment.centerLeft,child: Text("Datos opcionales",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                      ),
                            children: <Widget>[
                              Column(
                                children:[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      controller: razaController,
                                      scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.edit_rounded),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                        labelText: 'Raza',
                                      ),),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: colorController,
                                      scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.color_lens_outlined),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                        labelText: 'Color',
                                      ),),),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DateTimePicker(
                                        icon: Icon(Icons.calendar_today),
                                        type: DateTimePickerType.date,
                                        initialValue: fechaNacimiento.toString(),
                                        firstDate: DateTime(2015),
                                        lastDate: DateTime(2100),
                                        dateLabelText: 'Fecha de Nacimiento',
                                        onChanged: (val) => fechaNacimiento = DateTime.parse(val),
                                        validator: (val) {
                                          print(val);
                                          return null;
                                        },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.calendar_today),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                            labelText: 'Fecha de Nacimiento',
                                          )
                                        //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: observacionesController,
                                      maxLines: 5,
                                      scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.text_snippet_outlined),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                        labelText: 'Observaciones',
                                      ),),),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("¿Esterilizado?"),
                                      Checkbox(
                                        value: this.castrado,

                                        onChanged: (bool? value) {
                                          setState(() {
                                            if(value==null || value==false) this.castrado=false;
                                            else this.castrado=true;
                                          });
                                        },
                                      ),],),]

                            ),]
                          )
                      ),
                      Container(
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
                      ),
                      SizedBox(height:50),
                    ],
                  ),



            ],

        ))]));
  }


  Future<void> _showMyDialog() async {
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

  String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}
