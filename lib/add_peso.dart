import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'animal.dart';

class AddPeso extends StatefulWidget {
  @override
  _AddPesoState createState() => new _AddPesoState();
}

class _AddPesoState extends State<AddPeso> {
  final _formKey = GlobalKey<FormState>();
  late List<Animal> animales_prueba;
  String? id_animal;
  var fecha = DateTime.now();
  double peso = 0.0;

  @override
  initState() {
    super.initState();
    animales_prueba = Animal.animales_de_prueba();
    fecha = DateTime.now();
    for (Animal animal in animales_prueba) print(animal.toString());
    print(fecha.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(title: Text("Agregar Peso")),*/
        body: ListView(children: [
          Form(
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
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Registro de peso",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              icon: Icon(Icons.pets),
                              hint:
                                  id_animal == null ? Text("Seleccione Animal") : Text(id_animal!),
                              value: id_animal,
                              onChanged: (var value) {
                                setState(() {
                                  id_animal = value!;
                                });
                              },
                              items: animales_prueba.map((Animal an) {
                                return DropdownMenuItem<String>(
                                    value: an.id.toString(), child: Text(an.nombre));
                              }).toList(),
                              validator: (value) => value == null ? 'Seleccione una mascota' : null,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateTimePicker(
                                icon: Icon(Icons.calendar_today),
                                type: DateTimePickerType.date,
                                initialValue: fecha.toString(),
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Fecha de Registro',
                                onChanged: (val) => fecha = DateTime.parse(val),
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpinBox(
                              direction: Axis.horizontal,
                              min: 0.0,
                              max: 100.0,
                              step: 0.1,
                              enableInteractiveSelection: true,
                              acceleration: 2.0,
                              value: peso,
                              onChanged: (value) => setState(() => peso = value),
                              decimals: 1,
                              showCursor: true,
                              decoration: InputDecoration(
                                counterStyle:
                                    TextStyle(color: Theme.of(context).accentColor, fontSize: 40),
                                suffixText: "kg",
                                labelText: "Ingrese Peso",
                                hintText: "Escribe un numero",
                                /*helperText: "helpertext",
                              prefixText: "prefixtext",
                              counterText: 'Countertext'*/
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft, child: Text("Seleccione Peso:")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DecimalNumberPicker(
                                axis: Axis.horizontal,
                                value: peso,
                                minValue: 0,
                                maxValue: 1000,
                                decimalPlaces: 1,
                                haptics: true,
                                onChanged: (value) => setState(() => peso = value),
                                decimalDecoration: BoxDecoration()),
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
                                child: Text('Guardar Peso')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

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
                Text(id_animal!),
                Text("Peso:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(peso.toString()),
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
                TextButton(
                    child: Text("OK", style: TextStyle(color: Theme.of(context).accentColor)),
                    onPressed: () {
                      //TODO: Poner la llamada a la api aquí.

                      final snackbar = SnackBar(content: Text("Evento guardado exitosamente."));

                      //TODO: Cambiar por ruta nombrada en vez de pop().
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    })
              ]);
        });
  }
}
