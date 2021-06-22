import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/Evento.dart';

class ListaEventos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ListaEventosState();
}

class ListaEventosState extends State<ListaEventos>{
  List<Evento> listaEventos = Evento.listaEjemplos();

  @override
  Widget build(BuildContext context) {
    //for(Evento e in listaEventos) print(e.toString());

    /*return new ListView.builder(
        itemCount: listaEventos.length,
        itemBuilder: (BuildContext context, int index)
    {
      return new ListTile(title: Text(listaEventos[index].nombre),
          subtitle: Text(listaEventos[index].fecha.toString() + " (" + listaEventos[index].cumplido.toString() + ")"),
          trailing: Icon(Icons.check),
      );
    }
    );*/

    return new ListView.builder(
        itemCount: listaEventos.length,
        itemBuilder: (BuildContext context, int index)
        {
          return new CheckboxListTile(
            title: Text(listaEventos[index].nombre),
            subtitle: Text(/*listaEventos[index].fecha.toString() +*/

                listaEventos[index].fecha.day.toString() + "/" + listaEventos[index].fecha.month.toString()+
                " " + listaEventos[index].fecha.hour.toString() +":" +  listaEventos[index].fecha.minute.toString()
                +
                " (" +
                (listaEventos[index].cumplido?"Cumplido":"Pendiente")
                + ")"),
            value: listaEventos[index].cumplido,
            secondary: listaEventos[index].tipo=='Alimentación'?Icon(Icons.fastfood):Icon(Icons.medical_services),
            onChanged: (bool? value) { //if(value!=null) listaEventos[index].cumplido=value;
            setState(() {
              List<Evento> aux= listaEventos;
              aux[index].cumplido=value!;
              listaEventos=aux;

              //TODO: Llamar al endpoint de actualizar cumplido del evento.

            });},
          );
        }
    );


  }
}