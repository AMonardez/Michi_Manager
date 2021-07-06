import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


import 'package:michi_manager/models/RegistroPeso.dart';
import 'API.dart';
import 'models/Animal.dart';

class ViewGraficos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ViewGraficosState();
}

class ViewGraficosState extends State<ViewGraficos>{
  String? idAnimal;
  late List<Animal> animalesPrueba;
  late Future<List<RegistroPeso>> pesos;
  late Future<List<Animal>> animalitos;

  initState(){
    super.initState();
    animalesPrueba = Animal.animalesDePrueba();
    animalitos = API.getMisAnimales('', '');
    //pesos=RegistroPeso.listaPesos(10, 1);
    //pesos=new Future.value(RegistroPeso.listaPesos(10, 1));
    //pesos=new Future.value([]);
    pesos= new Future.value([]);
    //pesos= new Future.delayed(Duration(seconds:5), ()=>[]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Graficos de Peso", style: TextStyle(color: Colors.white, fontFamily: 'Nunito') ),
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

      body:
        SingleChildScrollView(
          child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:25.0, right:25, top: 20, bottom: 10),
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom:0, right:8.0, left:0),
                            child: FutureBuilder(
                              future: animalitos,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if(snapshot.hasData){
                                  return DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      //icon: Icon(Icons.pets),
                                      hint: idAnimal == null ? Text("") : Text(idAnimal!),
                                      value: idAnimal,
                                      onChanged: (var value) async {
                                        setState(() {
                                          idAnimal = value!;
                                          //pesos= RegistroPeso.listaPesos(3, int.parse(value));
                                          pesos = API.getPesos(int.parse(value));
                                        });
                                      },
                                      items: snapshot.requireData.map<DropdownMenuItem<String>>((Animal an) {
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

                                  );

                                }
                                else{
                                  return
                                    TextField(enabled: false,
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

                        ],
                      ),
                    ),
                  ),
                ),

                FutureBuilder<List<RegistroPeso>>(
                  future: pesos,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(idAnimal==null) return Align(alignment: Alignment.center,child: Text("Seleccione una mascota para mostrar sus datos.", style: TextStyle(color: Colors.grey)));
                    if(snapshot.connectionState==ConnectionState.waiting)
                      return SizedBox(height:500, width:500,child: Center(child: CircularProgressIndicator()));
                    if(snapshot.hasData)
                      if(snapshot.data.length!=0)
                      return Padding(
                        padding: const EdgeInsets.only(left:25, right: 25, top:15),
                        child: Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                DataTable(
                                  columns: [
                                    DataColumn(label: Center(child: Text("Fecha", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),)),
                                    DataColumn(label: Center(child: Text("Peso(kg)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),)),
                                  ],
                                  rows: snapshot.data.map<DataRow>(
                                      (rp) => DataRow(
                                        cells: [
                                          DataCell(Text(fechabonita(rp.fecha))),
                                          DataCell(Text(rp.peso.toString()))
                                        ])
                                  ).toList()
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      else return Align(alignment: Alignment.center,child: Text("La mascota no tiene registros de peso.", style: TextStyle(color: Colors.grey)));
                    else if (snapshot.hasError) {
                    return SizedBox(
                        height:500, width:500, child: Text("${snapshot.error}"));
                    }
                    else return SizedBox(height:500, width:500,child: Center(child: CircularProgressIndicator()));
                  },),


                SizedBox(
                    height:500,
                    width:1100,
                    child: FutureBuilder( future: pesos,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasData && snapshot.data.length>1){
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Card(child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: LineChart( datos(snapshot.requireData)),
                            ),
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            ),
                          );
                        }
                        else if(snapshot.hasData && snapshot.data.length==1) return Text("No se disponen de registros suficientes para visualizar un gráfico.");
                        else return SizedBox(width: 1,height: 1,);
                        //else if(snapshot.hasError) return Text("Ocurrio un error");
                        //else return CircularProgressIndicator();
                      },
                    )
                )
              ]
            )
        )
    );
  }


  LineChartData datos(List<RegistroPeso> lrp) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (t) {
            return t.map((e)
             {return LineTooltipItem("${
                 fechabonita(DateTime.fromMillisecondsSinceEpoch(e.x.toInt()))
             }\n${e.y.toStringAsFixed(1)} kg", TextStyle(color: Colors.white));}
             ).toList();
          },
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        horizontalInterval: 5.0,

      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (value) {
            var d = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            /*if(lrp.where((element) => element.fecha== d).isEmpty) return '';
            else */return fechabonitacorta(d);
          },
          rotateAngle: 270,
          interval: getInterval(lrp),

        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontSize: 10,
          ),
          getTitles: (value) {
            /*if(lrp.where((element)=> element.peso==value).isEmpty) return '';
            else*/ return '$value kg';
          },
          //margin: 8,
          //reservedSize: 30,
          interval: 5.0,

        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff99999999),
            width: 2,
          ),
          left: BorderSide(
            color: Color(0xff99999999),
            width:2,
          ),
          right: BorderSide(
              color: Color(0xff99999999),
              width:2
          ),
          top: BorderSide(
              color: Color(0xff99999999),
              width:2
          ),
        ),
      ),
      /*minX: 0,
      maxX: 14,
      maxY: 4,*/
      minY: 0,
      lineBarsData: linesBarData1(lrp),
    );
  }

  List<LineChartBarData> linesBarData1(List<RegistroPeso> lrp) {
    List<FlSpot> l=[];
    l=lrp.map((rp) {
      return FlSpot((rp.fecha.millisecondsSinceEpoch*1.0),rp.peso);
    }
    ).toList();

    final lineChartBarData1 = LineChartBarData(
      spots:l,
      /*spots: [
        *//*FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),*//*
        FlSpot(1,DateTime.now().millisecondsSinceEpoch/1000),
        FlSpot(2, DateTime.now().add(Duration(seconds: 10)).millisecondsSinceEpoch/1000),
        FlSpot(3, DateTime.now().add(Duration(seconds: 20)).millisecondsSinceEpoch/1000),
      ],*/
      isCurved: false,
      colors: [
        Color(0xff48c6ef),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }


  static String fechabonita(DateTime dt){
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM-yyyy', 'es_US').format(dt);
  }
  static String fechabonitacorta(DateTime dt){
    initializeDateFormatting('es_US', null);
    return DateFormat('dd-MMMM', 'es_US').format(dt);
  }

  double getInterval(List<RegistroPeso> lrp){
    DateTime min = lrp.reduce((a,b) => a.fecha.millisecondsSinceEpoch>b.fecha.millisecondsSinceEpoch?b:a).fecha;
    DateTime max = lrp.reduce((a,b) => a.fecha.millisecondsSinceEpoch<b.fecha.millisecondsSinceEpoch?b:a).fecha;
    //print("Max ${fechabonita(max)}");
    //print("Min ${fechabonita(min)}");
    var calc =max.difference(min).inMilliseconds;
    print ("Varcalc: $calc" );
    double divisor = lrp.length>5?5.0:lrp.length-1*1.0;
    return calc.toDouble()/divisor;

  }



}