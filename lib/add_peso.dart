import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

import 'API.dart';
import 'models/RegistroPeso.dart';
import 'models/Animal.dart';

class AddPeso extends StatefulWidget {
  @override
  _AddPesoState createState() => new _AddPesoState();
}

class _AddPesoState extends State<AddPeso> {
  final _formKey = GlobalKey<FormState>();
  late List<Animal> animalesPrueba;
  late Future<List<Animal>> animalitos;
  String? idAnimal;
  String nombreAnimal='';
  var fecha = DateTime.now();
  double peso = 0.0;
  Widget spb= SpinBox();
  TextEditingController t= new TextEditingController();

  @override
  initState() {
    t.text='${peso.toString()}';
    super.initState();
    animalesPrueba = Animal.animalesDePrueba();
    animalitos = API.getMisAnimales('', '');

    fecha = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Registrar Peso", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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



        body: ListView(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Registro de peso",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                          ),
                          FutureBuilder<List<Animal>>(
                            future: animalitos,
                            builder: (context, snapshot){
                              if(snapshot.hasData) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        //icon: Icon(Icons.pets),
                                        hint: idAnimal == null ? Text("") : Text(idAnimal!),
                                        value: idAnimal,
                                        onChanged: (var value) async {
                                          double pesillo= await API.getLastPeso(int.parse(value!));
                                          setState(() {
                                            idAnimal = value;
                                            peso=pesillo;
                                            t.text= pesillo.toString();
                                            //t.text= NumberFormat("###.0", "en_US").format(pesillo);
                                            t.text = pesillo.toStringAsFixed(1);

                                          });
                                          print("Se setea el estado? peso=$peso");
                                        },
                                        items: snapshot.requireData.map((Animal an) {
                                          return DropdownMenuItem<String>(value: an.id.toString(), child: Text(an.nombre), onTap: (){
                                            nombreAnimal=an.nombre;
                                          });
                                        }
    ).toList(),
                                      validator: (value) => value == null
                                          ? 'Seleccione una mascota': null,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.pets),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          labelText: 'Mascota'
                                      )

                                  ),
                                );}
                                else return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField(items: [],
                                      decoration:
                                      InputDecoration(
                                          prefixIcon: Icon(Icons.pets),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          labelText: 'Cargando mascotas'
                                      )
                                  ),
                                );
                            },

                          ),

                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateTimePicker(
                                icon: Icon(Icons.calendar_today),
                                type: DateTimePickerType.date,
                                dateMask: 'dd-MM-yyyy',
                                initialValue: fecha.toString(),
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Fecha de Registro',
                                onChanged: (val) {
                                  fecha = DateTime.parse(val);
                                  print(fecha.toIso8601String());},
                                  validator: (val) {
                                  //print(val);
                                  return null;
                                  },
                                  decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                  errorBorder: OutlineInputBorder(borderRadius:
                                 BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                    labelText: 'Fecha de Registro',

                                  )
                                //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:

                            Column(
                              children: [
                                TextFormField(
                                  controller : t,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      labelText: 'Peso',


                                      suffixText: "kg",
                                      hintText: "Escribe un numero",
                                      prefixIcon: InkWell(child: Icon(Icons.remove),
                                            onTap: () {
                                                //print("");
                                                peso=double.parse(t.text);
                                                peso=peso-0.1;
                                                t.text=peso.toStringAsFixed(1);
                                            }),
                                      suffixIcon: InkWell(child: Icon(Icons.add),
                                          onTap: () {
                                            //print("");
                                            peso=double.parse(t.text);
                                            peso=peso+0.1;
                                            t.text=peso.toStringAsFixed(1);
                                          }),

                                    ),


                                ),


                                /*SpinBox(
                                  direction: Axis.horizontal,
                                  min: 0.0,
                                  max: 100.0,
                                  step: 0.1,
                                  enableInteractiveSelection: true,
                                  acceleration: 2.0,
                                  value: peso,
                                  onChanged: (value) => setState(() => peso = value),
                                  canChange: (value) => (value==peso)?false:true,

                                  decimals: 1,
                                  showCursor: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      labelText: 'Peso',
                                      suffixText: "kg",
                                        hintText: "Escribe un numero",
                                        *//*helperText: "helpertext",
                                        prefixText: "prefixtext",
                                        counterText: 'Countertext'*//*

                                    )
                                  *//*decoration: InputDecoration(
                                    counterStyle:
                                        TextStyle(color: Theme.of(context).accentColor, fontSize: 40),


                                  ),*//*


                                ),*/
                              ],
                            ),
                          ),


                          /*Padding(
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
                          ),*/


                        ],
                      ),
                    ),
                  ),

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
                        if (_formKey.currentState!.validate()) _showMyDialog();},
                      child: Text('Guardar Peso', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Nunito'),)
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
                Text("Animal:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(nombreAnimal),
                Text("Peso:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${t.text} kg"),
                Text("Fecha:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(fechabonita(fecha)),
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

  String fechabonita(DateTime dt){
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM-yyyy', 'es_US').format(dt);
  }
}
