import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
//import 'package:numberpicker/numberpicker.dart';

class AgregaPaciente extends StatefulWidget {
  @override
  _AgregaPacienteState createState() => new _AgregaPacienteState();
}

class _AgregaPacienteState extends State<AgregaPaciente> {
  List<String> animalitos = ["Perro", "Gato", "Hamster", "Tortuga", "Iguana", "Otro"];
  List<String> sexos = ["Macho", "Hembra", "No lo sé"];
  DateTime fechaNacimiento = DateTime.now();
  int edad = 0;
  int? sexo=0;
  var nombreController = TextEditingController();
  var razaController = TextEditingController();
  var colorController = TextEditingController();
  var observacionesController = TextEditingController();
  var tipo;
  var color;
  bool castrado=false;

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Mascota"),
        ),
        body: ListView(
          children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                    border: OutlineInputBorder(),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de animal:", textAlign: TextAlign.start, )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,

                                icon: Icon(Icons.workspaces_filled),
                                hint: tipo == null ? Text("Seleccione tipo de animal") : Text(tipo),
                                value: tipo,
                                onChanged: (var value) {
                                  setState(() {
                                    tipo = value;
                                  });
                                },
                                items: animalitos.map((String animal) {
                                  return DropdownMenuItem<String>(value: animal, child: Text(animal));
                                }).toList(),
                                validator: (value) => value == null
                                ? 'Seleccione tipo de animal': null,
                              ),
                            ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: razaController,
                                      scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.edit_rounded),
                                        border: OutlineInputBorder(),
                                        labelText: 'Raza',
                                      ),
                                      validator: (String? value){
                                        if (value == null || value.isEmpty) {
                                          return 'La raza de la mascota no puede estar vacío.';
                                        }
                                        return null;
                                      }
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
                                Row(
                                  children: [
                                    SizedBox(width:10),
                                    Text("¿Esterilizado?"),
                                    Checkbox(
                                      value: this.castrado,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if(value==null || value==false) this.castrado=false;
                                          else this.castrado=true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Divider(),

                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DateTimePicker(
                                      icon: Icon(Icons.calendar_today),
                                      type: DateTimePickerType.date,
                                      initialValue: fechaNacimiento.toString(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2100),
                                      dateLabelText: 'Fecha de Nacimiento',
                                      onChanged: (val) => fechaNacimiento = DateTime.parse(val!),
                                      validator: (val) {
                                        print(val);
                                        return null;
                                      },
                                      //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                                    )
                                ),


                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text("Seleccionar Fecha de Nacimiento: "),
                                      SizedBox(height: 20.0,),
                                      *//*RaisedButton(
                                        onPressed: () => _selectDate(context),
                                        child: Text('Select date'),
                                      ),*//*
                                      ElevatedButton(
                                          onPressed: () => _selectDate(context),
                                          child: Text(fechabonita(fechaNacimiento)))

                                      ,
                                    ],
                                  ),
                                ) ,*/










                                /*Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(alignment: Alignment.centerLeft, child: Text("Edad en Años:", textAlign: TextAlign.start, )),
                            ),
                            NumberPicker(
                                axis: Axis.horizontal,
                                value: edad,
                                minValue: 0,
                                maxValue: 50,
                                step: 1,
                                haptics: true,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(16)),
                                onChanged: (value) => setState(() => edad = value)),*/
                            //Text("Valor actual: $edad"),


                          ])),
                          Card(
                              child: Column(
                                  children:[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(alignment: Alignment.centerLeft,child: Text("Datos opcionales de la Mascota",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: colorController,
                                        scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.color_lens_outlined),
                                          border: OutlineInputBorder(),
                                          labelText: 'Color',
                                        ),
                                        /*validator: (String? value){
                                    if (value == null || value.isEmpty) {
                                      return 'El nombre de la mascota no puede estar vacío.';
                                    }
                                    return null;
                                  }*/
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: observacionesController,
                                        maxLines: 5,
                                        scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.text_snippet_outlined),
                                          border: OutlineInputBorder(),
                                          labelText: 'Observaciones',
                                        ),
                                        /*validator: (String? value){
                                    if (value == null || value.isEmpty) {
                                      return 'El nombre de la mascota no puede estar vacío.';
                                    }
                                    return null;
                                  }*/
                                      ),
                                    )
                                  ]
                              )
                          )







                        ],
                      ),


                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showMyDialog(nombreController.text, tipo, edad);
                        }
                        //print('Boton clickeado');
                      },
                      child: Text('Guardar Mascota'))
                  /*ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red), enableFeedback: true),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Volver'))*/
                ]),
              ),
            ],

        ));
  }


  Future<void> _showMyDialog(String nombre, String tipo, int edad) async {
    return showDialog<void> (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog (title: Text("Confirme los datos"),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                    Text("Nombre:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(nombre),
                    Text("Tipo de animal:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(tipo),
                    Text("Edad:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(edad.toString() ),
                    Text("Sexo:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(sexo==0?'Macho':'Hembra'),
                    Text("Esterilizado:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(castrado?'Si':'No'),
                    Text("Fecha de Nacimiento:", style: TextStyle(fontWeight: FontWeight.bold)),
                    //Text(fechaNacimiento.toString()),
                    Text(fechabonita(fechaNacimiento)),
                    Text("Color:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(colorController.text),
                    Text("Observaciones:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(observacionesController.text),

                  ]
                  )
              ),
              actions: [
                TextButton(child: Text("CANCELAR", style: TextStyle(color:Theme.of(context).backgroundColor),), onPressed:(){
                  Navigator.pop(context);
                }
                ),
                TextButton(child: Text("OK", style:TextStyle(color:Theme.of(context).accentColor)), onPressed:(){
                  //TO-DO: Poner la llamada a la api aquí.

                  final snackbar = SnackBar(
                      content: Text("Animal guardado exitosamente.") );
                  //TO-DO: Cambiar por ruta nombrada en vez de pop().

                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);

                }
                )
              ]

          );
        }
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      helpText: "Seleccione Fecha de Nacimiento",
        /*confirmText: "OK",
        cancelText:"CANCELAR",*/
        context: context,
        initialDate: fechaNacimiento,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(2100,12));
    if (picked != null && picked != fechaNacimiento)
      setState(() {
        fechaNacimiento = picked;
      });
  }

  String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}
