import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../add_alimentacion.dart';
import '../add_mascota.dart';
import '../add_medicamento.dart';
import '../add_peso.dart';

class Fabuloso extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EstadoFabuloso();
}

class EstadoFabuloso extends State<Fabuloso>{
  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(


        fabCloseIcon: Icon(Icons.close, color: Colors.white,),
        fabOpenIcon: Icon(Icons.add, color: Colors.white),
        children: <Widget>[
          InkWell(
            onTap: ( ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgregaPaciente()));},
            child: SizedBox(width:80, height:80,

              child: Column(
                children: [
                  Icon(LineIcons.paw, color: Colors.white, size:40),
                  Text("Nueva\nMascota", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ( ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAlimentacion()));
            },
            child: SizedBox(height:80, width:90,
              child: Column(
                children: [
                  Icon(LineIcons.drumstickWithBiteTakenOut, color: Colors.white, size:40),
                  Text("Plan\nAlimentación", style: TextStyle(color: Colors.white), textAlign:TextAlign.center)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ( ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicamento()));
            },
            child: SizedBox(height:80, width:80,
              child: Column(
                children: [
                  Icon(LineIcons.capsules, color: Colors.white, size:40),
                  Text("Plan\nMedicación", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ( ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPeso()));
            },
            child: SizedBox(height:80, width:80,
              child: Column(
                children: [
                  Icon(LineIcons.weight, color: Colors.white, size:40),
                  Text("Registrar\nPeso", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
        ]

    );
  }

}