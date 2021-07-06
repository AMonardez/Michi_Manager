import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NotificacionHelper.dart';
import 'models/Evento.dart';

class TestCharts extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testeos")
      ),
      body: Center(
          child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, //.center pega todo y lo junta
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hola mediano 40',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                  ),
                ),
                ElevatedButton(child: Text("Post Notificacion"), onPressed: () async {
                  print("Presionado");
                  await deleteNotificaciones();
                  await postNotificaciones(filterFuturos(lev));
                  },
                ),
                ElevatedButton(child: Text("Delete Notificaciones"), onPressed: () async {
                  print("Presionado");
                  await deleteNotificaciones();
                },
                )
              ])),
    );
  }

  List<Evento> lev = [
    Evento(idPlan:1, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal:'Luna', nombreEvento: "Whiskas1", cantidad: "200gr", fecha: DateTime.now().add(Duration(seconds: 1)),  cumplido:false, nombreCuidador: "-"),
    Evento(idPlan:1, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal:'Luna', nombreEvento: "Whiskas2", cantidad: "200gr", fecha: DateTime.now().add(Duration(seconds: 15)),  cumplido:false, nombreCuidador: "-"),
    Evento(idPlan:1, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal:'Luna', nombreEvento: "Whiskas3", cantidad: "200gr", fecha: DateTime.now().add(Duration(seconds: 30)),  cumplido:true, nombreCuidador: "-"),
    Evento(idPlan:1, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal:'Luna', nombreEvento: "Whiskas4", cantidad: "200gr", fecha: DateTime.now().add(Duration(seconds: 45)),  cumplido:false, nombreCuidador: "-"),
  ];

}
