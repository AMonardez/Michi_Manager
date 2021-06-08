import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michi_manager/lista_eventos.dart';

class PantallaEventos extends StatefulWidget{
  @override
  PantallaEventosState createState() => new PantallaEventosState();
}

class PantallaEventosState extends State<PantallaEventos>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listado de Eventos")),
      body: ListaEventos()
    );
  }


}