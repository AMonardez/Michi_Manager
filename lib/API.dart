import 'dart:convert';

import 'animal.dart';
import 'package:http/http.dart' as http;

class API {
  static String servidor = 'http://18.219.209.248:5000';

  static Future<Animal> getAnimal(int id_animal) async {
    List<Animal> listilla;
    final response =
        await http.get(Uri.parse(servidor + '/animal?id_animal=${id_animal}'));
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      //if(cosa.containsKey("animal")) print("Se encuentra la clave animal!!!!");
      //print(response.body);
      return Animal.fromJson(cosa['animal']);
    } else {
      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
    }
    //return Animal(nombre:'Cachupin', especie: 'Perro', sexo: 'Macho');
  }

  static Future<List<Animal>> getAnimales() async {
    List<Animal> listilla=[];
    final response = await http.get(Uri.parse(servidor + '/animales'));
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      if(cosa.containsKey("animales")) print("Se encuentra la clave animales!!!!");
      //print(response.body);
      //print("Ahora el listado de animales");
      //print(cosa['animales']);
      //print(cosa['animales'].runtimeType);
      for(var d in cosa['animales']){
        //print(d.runtimeType);
        //print(d.toString());
        //var f= jsonDecode(d);
        print("Coso del decode");

        listilla.add(Animal.fromJson(d));
      }
      print(listilla.length);
      return listilla;//Animal.animales_de_prueba();
    } else {
      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
    }
    return listilla;
  }



  static Future<bool> guardarAnimal(Animal an) async {
    final response = await http.post(
      Uri.parse(servidor + '/animal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(an)
    );
    print(jsonEncode(an));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);

    if(response.statusCode==200)
      return true;
    else return false;
  }




}
