import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animal.dart';
import 'API.dart';


class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => new _TestApiState();
}

class _TestApiState extends State<TestApi> {
  late Future<Animal> an;
  late Future<List<Animal>> listadoanimalitos;


  @override
  initState(){
    super.initState();
    an= API.getAnimal(5);
    listadoanimalitos = API.getAnimales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test de API"),
        ),
        body:
        Column(
          children: [
            Text("API animal 5"),
            FutureBuilder<Animal>(
              future: an,
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  return Padding(

                    padding: EdgeInsets.all(16),
                    child: Flexible(
                      child: Card(
                        margin: EdgeInsets.all(16),
                          child: Text(
                            snapshot.requireData.toString()
                          )),
                    ),
                  )
                  ;
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
                },
            ),

            Text("Listado de animales"),


            Flexible(
              child: FutureBuilder<List<Animal>>(
                future: listadoanimalitos,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return new ListView.builder(
                      itemCount: snapshot.requireData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                              title:Text(snapshot.requireData[index].toString()),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16),

                    )
                    ;
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),




          ],
        )






        );
  }



}
