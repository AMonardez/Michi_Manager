import 'package:flutter/cupertino.dart';

import 'API.dart';
import 'animal.dart';

class ListaMascotas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListaMascotasState();

}

class ListaMascotasState extends State<ListaMascotas>{
  late Future<List<Animal>> listado;

  @override
  initState(){
    super.initState();
    listado = API.getAnimales();


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}