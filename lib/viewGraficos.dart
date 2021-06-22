import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:michi_manager/models/RegistroPeso.dart';
import 'models/Animal.dart';

class ViewGraficos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ViewGraficosState();

}

class ViewGraficosState extends State<ViewGraficos>{
  String? idAnimal;
  late List<Animal> animalesPrueba;
  late Future<List<RegistroPeso>> pesos;



  initState(){
    super.initState();
    animalesPrueba = Animal.animalesDePrueba();
    pesos=RegistroPeso.listaPesos(10, 1);
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
        ListView(
          children:[
            Column(
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
                            child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                //icon: Icon(Icons.pets),
                                hint: idAnimal == null ? Text("") : Text(idAnimal!),
                                value: idAnimal,
                                onChanged: (var value) async {
                                  setState(() {
                                    idAnimal = value!;
                                    pesos= RegistroPeso.listaPesos(3, int.parse(value));
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

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:200,
                    width:200,
                    child: Container(
                      child: FutureBuilder( future: pesos,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            for(RegistroPeso r in snapshot.data) print(r);
                            //return Text("OK");
                            return LineChart( datos() );
                          }

                          else if(snapshot.hasError) return Text("Ocurrio un error");
                          else return CircularProgressIndicator();


                        },


                      )

                    )
                )

              ]
            )

          ]
        )











    );
  }


  LineChartData datos() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        Colors.blue,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

}