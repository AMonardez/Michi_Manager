import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class AddTratamiento extends StatefulWidget{

  @override
  _AddTratamientoState createState() => new _AddTratamientoState();
}

class _AddTratamientoState extends State<AddTratamiento>{
  final _formKey = GlobalKey<FormState>();
  var nombreController = new TextEditingController();
  var cantidadController = new TextEditingController();
  var descripcion = TextEditingController();
  var tipos_eventos = ["Alimentación", "Medicamento"];
  var tipos_periodos = ["Horas", "Dias", "Semanas", "Meses"];
  String? tipo_evento;
  String? periodo;
  var fechaInicio= DateTime.now();
  var fechaInicio2 = DateTime.now().toString();

  var repeticiones=0;

  TextEditingController intervaloController= new TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Agregar Evento")),
      body: ListView(
        children:[Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text("Datos básicos del Evento",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de Evento", textAlign: TextAlign.start, )),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            icon: Icon(Icons.apps),
                            hint: tipo_evento == null ? Text("Seleccione tipo de evento") : Text(tipo_evento!),
                            value: tipo_evento,
                            onChanged: (var value) {
                              setState(() {
                                tipo_evento = value!;
                              });
                            },
                            items: tipos_eventos.map((String evnt) {
                              return DropdownMenuItem<String>(value: evnt, child: Text(evnt));
                            }).toList(),
                            validator: (value) => value == null
                                ? 'Seleccione tipo de evento': null,
                          ),
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
                                labelText: 'Nombre del evento',
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
                          child: TextFormField(
                              controller: cantidadController,
                              /*keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],*/
                              scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                              obscureText: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fastfood),
                                border: OutlineInputBorder(),
                                labelText: 'Cantidad (ej. 200gr)',
                              ),
                              /*validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'El nombre de la mascota no puede estar vacío.';
                                }
                                return null;
                              }*/
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text("Temporización del Evento",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de Evento", textAlign: TextAlign.start, )),
                        ),*/


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DateTimePicker(
                            icon: Icon(Icons.calendar_today),
                            type: DateTimePickerType.dateTime,
                            initialValue: fechaInicio.toString(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Fecha de Inicio',
                            onChanged: (val) => fechaInicio = DateTime.parse(val!),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                          )
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft,child: Text("Seleccione veces de repeticiones:")),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NumberPicker(
                              axis: Axis.horizontal,
                              value: repeticiones,
                              minValue: 0,
                              maxValue: 1000,
                              step: 1,
                              haptics: true,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(16)),
                              onChanged: (value) => setState(() => repeticiones = value)),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 200,
                                  child: TextFormField(
                                    controller: intervaloController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.timer),
                                      border: OutlineInputBorder(),
                                      labelText: 'Intervalo',
                                    ),
                                    validator: (String? value){
                                      if (value == null || value.isEmpty) {
                                        return 'El nombre de la mascota no puede estar vacío.';
                                      }
                                      return null;
                                    }
                                  ),
                                ),
                              ),

                              Container(
                                width: 100,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  hint: periodo == null ? Text("Periodo") : Text(periodo!),
                                  value: periodo,
                                  onChanged: (var value) {
                                    setState(() {
                                      periodo = value;
                                    });
                                  },
                                  items: tipos_periodos.map((String evnt) {
                                    return DropdownMenuItem<String>(value: evnt, child: Text(evnt));
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? 'Seleccione tipo de periodo': null,
                                ),
                              )

                            ]
                          ),
                        )




                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),



        ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showMyDialog();
                  }
                  //print('Boton clickeado');
                },
                child: Text('Guardar Evento')),
          )

        ]
      )

    );



  }


  Future<void> _showMyDialog() async {
    return showDialog<void> (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog (title: Text("Confirme los datos"),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                    Text("Tipo de Evento:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(tipo_evento!),
                    Text("Nombre:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(nombreController.text),
                    Text("Cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(cantidadController.text),
                    Text("Fecha de Nacimiento:", style: TextStyle(fontWeight: FontWeight.bold)),

                    Text(fechaInicio.toString()),
                    Text("Repeticiones:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(repeticiones.toString()),
                    Text("Intervalo:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(intervaloController.text + " " +periodo! ),

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
                      content: Text("Evento guardado exitosamente.") );
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



  String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}