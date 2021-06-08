import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'evento.dart';

class ListaEventos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ListaEventosState();
}

class ListaEventosState extends State<ListaEventos>{
  List<Evento> lista_eventos = Evento.lista_ejemplos();

  @override
  Widget build(BuildContext context) {
    //for(Evento e in lista_eventos) print(e.toString());

    /*return new ListView.builder(
        itemCount: lista_eventos.length,
        itemBuilder: (BuildContext context, int index)
    {
      return new ListTile(title: Text(lista_eventos[index].nombre),
          subtitle: Text(lista_eventos[index].fecha.toString() + " (" + lista_eventos[index].cumplido.toString() + ")"),
          trailing: Icon(Icons.check),
      );
    }
    );*/

    return new ListView.builder(
        itemCount: lista_eventos.length,
        itemBuilder: (BuildContext context, int index)
        {
          return new CheckboxListTile(
            title: Text(lista_eventos[index].nombre),
            subtitle: Text(/*lista_eventos[index].fecha.toString() +*/

                lista_eventos[index].fecha.day.toString() + "/" + lista_eventos[index].fecha.month.toString()+
                " " + lista_eventos[index].fecha.hour.toString() +":" +  lista_eventos[index].fecha.minute.toString()
                +
                " (" +
                (lista_eventos[index].cumplido?"Cumplido":"Pendiente")
                + ")"),
            value: lista_eventos[index].cumplido,
            secondary: lista_eventos[index].tipo=='Alimentación'?Icon(Icons.fastfood):Icon(Icons.medical_services),
            onChanged: (bool? value) { //if(value!=null) lista_eventos[index].cumplido=value;
            setState(() {
              List<Evento> aux= lista_eventos;
              aux[index].cumplido=value!;
              lista_eventos=aux;

              //TODO: Llamar al endpoint de actualizar cumplido del evento.

            });},
          );
        }
    );


  }
}