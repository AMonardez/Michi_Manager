import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:line_icons/line_icons.dart';

import 'package:michi_manager/models/Evento.dart';
import 'package:michi_manager/viewGraficos.dart';
import 'package:michi_manager/viewListadoMascotas.dart';
import 'components/fabuloso.dart';
import 'components/menu_anvorgueso.dart';

class PaginaPrincipalState extends State<PaginaPrincipal> {
  int indiceSeleccionado=1;
  late List<Evento> listaEventos;



  List<Widget> paneles= [ListaAnimales(), PaginaPrincipal(), ViewGraficos() ];

  initState(){
    super.initState();
    listaEventos = Evento.listaEjemplos();
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
          child: Timeline.tileBuilder(
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

              indicatorStyleBuilder: ((context,index)=> (listaEventos[index].cumplido==true?IndicatorStyle.dot:IndicatorStyle.outlined)),
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
                      child: Text(fechabonita(listaEventos[index].fecha),
                        style:TextStyle(color:Colors.grey, fontSize:10), textAlign: TextAlign.start,),
                    ),
                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: ExpansionTile(
                            leading: Icon(listaEventos[index].tipo=="Alimentación"?LineIcons.drumstickWithBiteTakenOut:LineIcons.capsules, color:Colors.grey),

                            title: Column(
                              children: [
                                Text(listaEventos[index].nombre),
                                Text(listaEventos[index].nombreAnimal, style:TextStyle(color:Colors.grey, fontSize:10), textAlign: TextAlign.start,) ,
                              ],
                            ),
                            children: [Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Cantidad:", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(listaEventos[index].cantidad),
                                  Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(listaEventos[index].cumplido==true?"Cumplido":"Pendiente"),
                                  ElevatedButton(child: Text(listaEventos[index].cumplido==true?"DESMARCAR":"CUMPLIR"),

                                    onPressed: () { //if(value!=null) listaEventos[index].cumplido=value;
                                      setState(() {
                                        List<Evento> aux= listaEventos;
                                        aux[index].cumplido=!aux[index].cumplido;
                                        listaEventos=aux;

                                        //TODO: Llamar al endpoint de actualizar cumplido del evento.

                                      });}



                                    ,),

                                ],
                              ),
                            ),]
                        )


                    ),
                  ],
                ),
              ),
              itemCount: listaEventos.length,
            ),
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
              title: Text('Animales'),
              activeIcon: Icon(
                LineIcons.paw,
                color: Colors.blue,
              ),
            ),BottomNavigationBarItem(
              icon: Icon(
                LineIcons.home,
                color: Colors.black,
              ),
              title: Text('Eventos'),
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
              title: Text('Peso'),
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
    /*var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var horitas= stringList[1].split(":");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0] + " " + horitas[0] + ":" + horitas[1];
    return fechabien;*/
    //Intl.defaultLocale = 'en_ES';
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM HH:mm', 'es_US').format(dt);
  }
}

class PaginaPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PaginaPrincipalState();
}