import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/Animal.dart';

class AddAlimento extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new AddAlimentoState();
}

class AddAlimentoState extends State<AddAlimento>{
  final _formKey = GlobalKey<FormState>();
  var idAnimal;
  var animalesPrueba = Animal.animalesDePrueba();
  DateTime fecha = DateTime.now();

  initState(){
    super.initState();
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                //icon: Icon(Icons.pets),
                                hint: idAnimal == null ? Text("") : Text(idAnimal!),
                                value: idAnimal,
                                onChanged: (var value) {
                                  setState(() {
                                    idAnimal = value!;
                                  });
                                },
                                items: animalesPrueba.map((Animal an) {
                                  return DropdownMenuItem<String>(value: an.id.toString(), child: Text(an.nombre));
                                }).toList(),
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
                                    //print(val);
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                    labelText: 'Fecha de Registro',

                                  ),
                                onSaved: (val) => {fecha = DateTime.parse(val!)},
                              )),

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
                        colors: [Color(0xff48c6ef), Color(0xff6f86d6)]),
                  ),
                  child: MaterialButton(
                      elevation: 10.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: StadiumBorder(),
                      onPressed: () {
                        if (_formKey.currentState!.validate())_showMyDialog();},
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
                    Text("ID animal:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(idAnimal!),
                    Text("Peso:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("test"),
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
                  //RegistroPeso rp= RegistroPeso(fecha: fecha, idAnimal: int.parse(idAnimal!), peso: peso);
                  bool resultado = true;//await API.guardarRegistroPeso(rp);
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




}