import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:line_icons/line_icons.dart';

import 'package:michi_manager/models/Evento.dart';
import 'package:michi_manager/viewGraficos.dart';
import 'package:michi_manager/viewListadoMascotas.dart';
import 'API.dart';
import 'components/fabuloso.dart';
import 'components/menu_anvorgueso.dart';

class PaginaPrincipalState extends State<PaginaPrincipal> {
  int indiceSeleccionado=1;
  late Future<List<Evento>> listaEventos;



  List<Widget> paneles= [ListaAnimales(), PaginaPrincipal(), ViewGraficos() ];

  initState(){
    super.initState();
    //listaEventos = Evento.listaEjemplos();
    listaEventos = API.getTimeline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAnvorgueso(),
      appBar: AppBar(
        title: Text("Inicio", style: TextStyle(color: Colors.white, fontFamily: 'Nunito')),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff48c6ef), Color(0xff6f86d6)])),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:15, right:8.0),
          child: FutureBuilder(
            future: listaEventos,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                if(snapshot.requireData.length==0) return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text("No tienes eventos pendientes."),
                    Text("Prueba a agregar planes de alimentación o medicación.")]);
                else return Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    nodeItemOverlap: false,
                    connectorTheme: ConnectorThemeData(
                      color: Color(0xff48c6ef),
                      thickness: 3.0,
                    ),
                  ),
                  builder: TimelineTileBuilder.connectedFromStyle(
                    contentsAlign: ContentsAlign.basic,

                    indicatorStyleBuilder: ((context,index)=> (snapshot.requireData[index].cumplido==true?IndicatorStyle.dot:IndicatorStyle.outlined)),
                    connectionDirection: ConnectionDirection.after,
                    connectorStyleBuilder: ((context,index)=> ConnectorStyle.solidLine),
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            //child: Text("${fechabonita(listaEventos[index].fecha)} ",
                            child: Text(fechabonita(snapshot.requireData[index].fecha),
                              style:TextStyle(color:Colors.grey, fontSize:10), textAlign: TextAlign.start,),
                          ),
                          Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              child: ExpansionTile(
                                  leading: Icon(snapshot.requireData[index].tipoEvento=="alimentacion"?LineIcons.drumstickWithBiteTakenOut:LineIcons.capsules, color:Colors.grey),

                                  title: Column(
                                    children: [
                                      Text(snapshot.requireData[index].nombreEvento),
                                      Text(snapshot.requireData[index].nombreAnimal, style:TextStyle(color:Colors.grey, fontSize:10), textAlign: TextAlign.start,) ,
                                    ],
                                  ),
                                  children: [Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(snapshot.requireData[index].cantidad),
                                        /*Text("idPlan:", style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(snapshot.requireData[index].idPlan.toString()),
                                        Text("idAnimal:", style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(snapshot.requireData[index].idAnimal.toString()),*/
                                        Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(snapshot.requireData[index].cumplido==true?"Cumplido":"Pendiente"),
                                        Text("Atendido por:", style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(snapshot.requireData[index].cumplido==true?snapshot.requireData[index].nombreCuidador:"-"),

                                        ElevatedButton(child: Text(snapshot.requireData[index].cumplido==true?"DESMARCAR":"CUMPLIR"),
                                          onPressed: () async {
                                            bool valor=false;
                                            if(snapshot.requireData[index].tipoEvento=="alimentacion"){
                                              valor= await API.cumplirEventoAlimentacion(snapshot.requireData[index].idPlan,
                                                  snapshot.requireData[index].fecha, !snapshot.requireData[index].cumplido);
                                            }
                                            else if(snapshot.requireData[index].tipoEvento=="medicacion"){
                                              valor = await API.cumplirEventoMedicacion(snapshot.requireData[index].idPlan,
                                                  snapshot.requireData[index].fecha, !snapshot.requireData[index].cumplido);
                                            }
                                            else print("ERROR DE TIPO DE EVENTO.");
                                            if(valor){
                                              String s= '';
                                              var f = await SharedPreferences.getInstance();
                                              s = f.getString("nombre")??'?';

                                              setState(() {
                                                AsyncSnapshot<dynamic> snapshot2 = snapshot;
                                                snapshot2.requireData[index].cumplido = !snapshot.requireData[index].cumplido;
                                                snapshot2.requireData[index].nombreCuidador = s;
                                                snapshot = snapshot2;
                                              });
                                            }
                                            else{
                                              final snackbar = SnackBar(content: Text("Error al cumplir el evento."));
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                            }
                                            }
                                          ,),
                                      ],
                                    ),
                                  ),]
                              )


                          ),
                        ],
                      ),
                    ),
                    itemCount: snapshot.requireData.length,
                  ),
                );
              }
              else if(snapshot.hasError) return Text("Error al consultar eventos.");
              else return CircularProgressIndicator();
            },

          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indiceSeleccionado,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.paw,
                color: Colors.black,
              ),
              //title: Text('Animales'),
              label: 'Animales',
              activeIcon: Icon(
                LineIcons.paw,
                color: Colors.blue,
              ),
            ),BottomNavigationBarItem(
              icon: Icon(
                LineIcons.home,
                color: Colors.black,
              ),
              //title: Text('Eventos'),
              label: 'Eventos',
              activeIcon: Icon(
                LineIcons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.weight,
                color: Colors.black,
              ),
              //title: Text('Peso'),
              label: "Peso",
              activeIcon: Icon(
                LineIcons.weight,
                color: Colors.blue,
              ),
            ),

          ],
          onTap: (index) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => paneles[index]));

          }



      ),

      floatingActionButton: Fabuloso(),
    );
  }
  static String fechabonita(DateTime dt){
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM HH:mm', 'es_US').format(dt);
  }
}

class PaginaPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PaginaPrincipalState();
}