import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:michi_manager/models/PlanMedicacion.dart';
import 'API.dart';
import 'models/Animal.dart';

class AddMedicamento extends StatefulWidget{

  @override
  _AddMedicamentoState createState() => new _AddMedicamentoState();
}

class _AddMedicamentoState extends State<AddMedicamento> {
  final _formKey = GlobalKey<FormState>();
  var nombreController = new TextEditingController();
  var cantidadController = new TextEditingController();
  var descripcion = TextEditingController();
  var tiposPeriodosCada = ["Horas", "Dias", "Semanas", "Meses"];
  String? periodoCada;
  var tiposPeriodosDurante = ["Dias", "Semanas", "Meses"];
  String? periodoDurante;
  late List<Animal> animalesPrueba;
  String? idAnimal;
  String tipoEvento = 'Medicamento';
  var fechaInicio = DateTime.now();
  TextEditingController intervaloCadaController = new TextEditingController();
  TextEditingController intervaloDuranteController = new TextEditingController();

  late Future<List<Animal>> animalitos;

  String nombreAnimal='';

  @override
  initState() {
    super.initState();
    animalesPrueba = Animal.animalesDePrueba();
    animalitos = API.getMisAnimales('', '');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Agregar Medicación", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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
        children:[Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft,child: Text("Datos básicos del Evento",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de Evento", textAlign: TextAlign.start, )),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: animalitos,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if(snapshot.hasData){
                                print("Tiene dataaaaaaaaaaaaaaaaa");
                                return DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    //icon: Icon(Icons.pets),
                                    hint: idAnimal == null ? Text("") : Text(idAnimal!),
                                    value: idAnimal,
                                    onChanged: (var value) {
                                      setState(() {
                                        idAnimal = value!;
                                      });
                                    },
                                    items: snapshot.requireData.map<DropdownMenuItem<String>>((Animal an) {
                                      return DropdownMenuItem<String>(value: an.id.toString(), child: Text(an.nombre),
                                          onTap: () {nombreAnimal = an.nombre;});
                                    }).toList(),
                                    validator: (value) => value == null
                                        ? 'Seleccione una mascota': null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.pets),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                      labelText: "Mascota",
                                    )

                                );
                              }
                              else if(snapshot.hasError){
                                return Text("Error al cargar las mascotas.");
                              }
                              else {
                                return DropdownButtonFormField(items: [],
                                    decoration:
                                    InputDecoration(
                                        prefixIcon: Icon(Icons.pets),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                        labelText: 'Cargando mascotas'
                                    )
                                );

                              }
                            },

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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                              labelText: 'Nombre del Medicamento',
                            ),
                            validator: (String? value){
                              if (value == null || value.isEmpty) {
                                return 'El nombre del evento no puede estar vacío.';
                              }
                              return null;
                            },
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
                              prefixIcon: Icon(Icons.adjust),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                              labelText: 'Cantidad (ej. 1 tableta)',
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0, right: 20, top:5, bottom:20),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft,child: Text("Temporización del Evento",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: Alignment.centerLeft, child: Text("Tipo de Evento", textAlign: TextAlign.start, )),
                        ),*/


                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimePicker(
                                type: DateTimePickerType.dateTime,
                                dateMask: 'dd-MM-yyyy HH:mm',
                                initialValue: fechabonita(fechaInicio),
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Fecha de Inicio',
                                onChanged: (val) => fechaInicio = DateTime.parse(val),
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
                                  labelText: 'Fecha de Inicio',
                                )
                              //onSaved: (val) => {fechaInicio = DateTime.parse(val!)},
                            )
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:[
                                Flexible(
                                  flex : 2,
                                  child: Container(
                                    child: TextFormField(
                                        controller: intervaloCadaController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.timer),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          labelText: 'Cada'
                                        ),
                                        validator: (String? value){
                                          if (value == null || value.isEmpty) {
                                            return 'El intervalo de tiempo no puede estar vacío.';
                                          }
                                          return null;
                                        }
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex:2,
                                  child: Container(
                                    padding:EdgeInsets.only(left:8),

                                    height: 65,

                                    child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        hint: periodoCada == null ? Text("") : Text(periodoCada!),
                                        value: periodoCada,
                                        onChanged: (var value) {
                                          setState(() {
                                            periodoCada = value;
                                          });
                                        },
                                        items: tiposPeriodosCada.map((String evnt) {
                                          return DropdownMenuItem<String>(value: evnt, child: Text(evnt));
                                        }).toList(),
                                        validator: (value) => value == null
                                            ? 'Seleccione periodo': null,
                                        //decoration: InputDecoration(enabledBorder: InputBorder.none,)
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.timer_10_sharp),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.cyan)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          labelText: "Periodo"


                                        )
                                      //decoration: InputDecoration.collapsed(hintText:''),
                                    ),
                                  ),
                                ),


                              ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:[
                                Flexible(
                                  flex : 2,
                                  child: Container(
                                    child: TextFormField(
                                        controller: intervaloDuranteController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.timer),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                            labelText: 'Durante'
                                        ),
                                        validator: (String? value){
                                          if (value == null || value.isEmpty) {
                                            return 'El intervalo de tiempo no puede estar vacío.';
                                          }
                                          return null;
                                        }
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex:2,
                                  child: Container(
                                    padding:EdgeInsets.only(left:8),
                                    height: 65,
                                    child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        hint: periodoDurante == null ? Text("Periodo") : Text(periodoCada!),
                                        value: periodoDurante,
                                        onChanged: (var value) {
                                          setState(() {
                                            periodoDurante = value;
                                          });
                                        },
                                        items: tiposPeriodosDurante.map((String evnt) {
                                          return DropdownMenuItem<String>(value: evnt, child: Text(evnt));
                                        }).toList(),
                                        validator: (value) => value == null
                                            ? 'Seleccione periodo': null,
                                        //decoration: InputDecoration(enabledBorder: InputBorder.none,)
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.timer_10_sharp),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.cyan)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0), borderSide: BorderSide(color: Colors.grey)),
                                          labelText:'',


                                        )
                                      //decoration: InputDecoration.collapsed(hintText:''),
                                    ),
                                  ),
                                ),


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
            padding: EdgeInsets.only(bottom:15, left:50, right: 50, top:10),
            child: Container(
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
                  child: Text('Guardar Medicamento', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Nunito'),)
              ),
            ),
          ),
          SizedBox(height:50),

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
                    Text("Animal:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(nombreAnimal),
                    Text("Nombre:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(nombreController.text),
                    Text("Cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(cantidadController.text),
                    Text("Fecha de Inicio:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(fechabonita(fechaInicio)),
                    Text("Cada cuanto:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${intervaloCadaController.text} $periodoCada"),
                    Text("Durante:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${intervaloDuranteController.text} $periodoDurante"),
                  ]
                  )
              ),
              actions: [
                TextButton(child: Text("CANCELAR", style: TextStyle(color:Theme.of(context).backgroundColor),), onPressed:(){
                  Navigator.pop(context);
                }
                ),
                TextButton(child: Text("OK", style:TextStyle(color:Theme.of(context).accentColor)), onPressed:() async {
                  DateTime fechaT=fechaInicio;
                  if(periodoDurante=='Dias') fechaT=fechaInicio.add(Duration(days: int.parse(intervaloDuranteController.text)));
                  else if(periodoDurante=='Semanas') fechaT=fechaInicio.add(Duration(days: int.parse(intervaloDuranteController.text)*7));
                  else if(periodoDurante=='Meses') fechaT=fechaInicio.add(Duration(days: int.parse(intervaloDuranteController.text)*30));
                  else print("Faltan ifs de periodos!!!!!!!!!1");
                  PlanMedicacion pm = PlanMedicacion(
                      dosis: cantidadController.text.isEmpty?'-':cantidadController.text,
                      nombre: nombreController.text,
                      fechaInicio: fechaInicio,
                      fechaTermino: fechaT,
                      periodicidad: intervaloCadaController.text + " " + periodoCada!,
                      observaciones: '',
                      idAnimal: int.parse(idAnimal!),
                  );

                  bool valor= await API.addPlanMedicacion(pm);
                  if(valor){
                    final snackbar = SnackBar(
                        content: Text("Plan Medicamento guardado exitosamente."));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  else {
                    final snackbar = SnackBar(
                        content: Text("Falló al guardar Plan de Medicamento."));
                    Navigator.pop(context);
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
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM-yyyy HH:mm', 'es_US').format(dt);
  }

}