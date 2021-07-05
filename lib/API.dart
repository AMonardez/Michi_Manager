import 'dart:convert';

import 'package:michi_manager/models/Cuidador.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Evento.dart';
import 'models/PlanAlimentacion.dart';
import 'models/PlanMedicacion.dart';
import 'models/RegistroPeso.dart';
import 'models/Animal.dart';
import 'package:http/http.dart' as http;

class API {
  static String servidor = 'http://18.219.209.248:5000';

  static Future<Animal> getAnimal(int idAnimal) async {
    //List<Animal> listilla;
    final response =
        await http.get(Uri.parse(servidor + '/animal?id_animal=$idAnimal'));
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
        print(d.toString());
        //var f= jsonDecode(d);
        print("Coso del decode");

        listilla.add(Animal.fromJson(d));
      }
      //print(listilla.length);
      return listilla;//Animal.animales_de_prueba();
    } else {
      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
    }
    //return listilla;
  }

  static Future<bool> guardarAnimal(Animal an) async {
    var cosilla = an.toJson();
    var f= await SharedPreferences.getInstance();
    cosilla["correo"]= f.getString("correo")??"amonardezt@alumnosuls.cl";

    final response = await http.post(
      Uri.parse(servidor + '/animal_cuidador'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cosilla)
    );
    print(jsonEncode(an));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);

    if(response.statusCode==200)
      return true;
    else return false;
  }

  static Future<bool> guardarRegistroPeso(RegistroPeso rp) async {
    final response = await http.post(
        Uri.parse(servidor + '/registro_peso'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(rp)
    );
    print(jsonEncode(rp));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);

    if(response.statusCode==200)
      return true;
    else return false;
  }

  static Future<double> getLastPeso(int idAnimal) async {
    //List<Animal> listilla;
    final response =
    await http.get(Uri.parse(servidor + '/registro_last_peso?id_animal=$idAnimal'), );
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      //if(cosa.containsKey("animal")) print("Se encuentra la clave animal!!!!");
      //print(response.body);
      if(cosa['ok']==false) {
        print("El animal seleccionado no tiene registro de peso.");
        return 0;
      }
      else{
        print("El peso de la mascota de id $idAnimal es de ${cosa["registro_peso"]["peso"]}");
        return cosa["registro_peso"]["peso"];
      }
    } else {

      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
    }
    //return Animal(nombre:'Cachupin', especie: 'Perro', sexo: 'Macho');
  }

  static Future<List<RegistroPeso>> getPesos(int idAnimal) async {
    //DateTime tInicio = new DateTime(2000);
    //DateTime tFinal  = new DateTime(2050);
    Map<String, String> bodo= {"id_animal": idAnimal.toString(),
            "fecha_inicio": "2000-01-01", "fecha_termino": "2050-01-01"};
    final response =
    await http.post(Uri.parse(servidor + '/registro_peso/get_by_dates'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo));
    print("StatusCode: ${response.statusCode}(${response.reasonPhrase})");
    List<RegistroPeso> lrp=[];
    if (response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      if(cosa['ok']==false) {
        //print("StatusCode: ${response.statusCode}(${response.reasonPhrase})");
        print("El animal $idAnimal no tiene registros de peso.");
        return [];
      }
      else{
        //print(cosa["result"].toString());
        for(dynamic l in cosa["result"]){
          lrp.add(RegistroPeso.fromJson(l));
        }
        return lrp;
      }
    } else {
      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
      //return [];
    }
  }

  static Future<bool> guardarCuidador(String nombre, DateTime fechaIngreso, String correo, String contrasena) async {
    final Map<String, String> bodo = {"nombre": nombre, "fecha_ingreso": fechaIngreso.toIso8601String(),
      "correo": correo, "password": contrasena};

    final response = await http.post(
        Uri.parse(servidor + '/cuidador'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print("Guardando usuariooooooo");
    print(jsonEncode(bodo));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);
    if(response.statusCode==200)
      return true;
    else return false;
  }

  static Future<bool> loginCuidador(String correo, String contrasena) async {
    final Map<String, String> bodo = {"correo": correo, "password": contrasena};
    print("API: loginCuidador");
    print("bodo");
    print(bodo.toString());
    final response = await http.post(
        Uri.parse(servidor + '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print(jsonEncode(bodo));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);

    if(response.statusCode==200 || response.statusCode==400){
      var coso = jsonDecode(response.body);
      if(coso["ok"]){
        var f = await SharedPreferences.getInstance();
        f.setString("nombre", coso["result"]["nombre"]);
        f.setString("correo", correo);
        f.setString("contrasena", contrasena);
        f.setInt("id_cuidador", coso["result"]["id_cuidador"]);
        print(f.getString("nombre"));
        print(f.getString("correo"));
        print(f.getInt("id_cuidador"));
      }

      return coso["ok"];
    }
    else return false;
  }

  static Future<List<Animal>> getMisAnimales(String correo, String contrasena) async {
    List<Animal> la=[];
    var f = await SharedPreferences.getInstance();
    String corr = f.getString("correo")??correo;
    String cont = f.getString("contrasena")??contrasena;

    final Map<String, String> bodo = {"correo": corr, "password": cont};
    //print("Hola");
    final response = await http.post(
        Uri.parse(servidor + '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    //print("Login de usuariooooooo");
    //print(jsonEncode(bodo));
    print("StatusCode: ${response.statusCode}");
    //print("Body:\n"+response.body);
    if(response.statusCode==200 || response.statusCode==400){
      var coso = jsonDecode(response.body);
      print(coso);
      for(var a in coso["result"]["animales_cuidador"])
        la.add(Animal.fromJson(a));
    }
    return la;
  }

  static Future<bool> deleteAnimal(int idAnimal) async {
    //List<Animal> listilla;
    final response =
    await http.delete(Uri.parse(servidor + '/animal?id_animal=$idAnimal'));
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      return false;
      //throw Exception('Falla al conectarse a la api.');
    }
  }

  static Future<List<Cuidador>> getCuidadoresAnimal(int idAnimal) async {
    List<Cuidador> lc=[];
    final response =
    await http.get(Uri.parse(servidor + '/get_cuidadores_animal?id_animal=$idAnimal'), );
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      //if(cosa.containsKey("animal")) print("Se encuentra la clave animal!!!!");
      //print(response.body);
      if(cosa['ok']==true) {
        for(var c in cosa["result"]){
          lc.add(Cuidador.fromJson(c));
        }
        return lc;
      }
      else{
        print("La mascota no tiene cuidadores");
        return lc;
      }
    } else {
      print("Statuscode: ${response.statusCode}");
      throw Exception('Falla al conectarse a la api.');
    }

  }

  static Future<bool> asignaCuidadorAnimal(int idAnimal, String correo) async {
    final Map<String, String> bodo = {"id_animal": idAnimal.toString() , "correo": correo};

    final response = await http.post(
        Uri.parse(servidor + '/asigna_animal_cuidador'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print("Asignando Cuidador $correo a animal ${idAnimal.toString()}");
    print(jsonEncode(bodo));
    print("StatusCode: ${response.statusCode}");
    print("Body:\n"+response.body);
    if(response.statusCode==200)
      return true;
    else return false;
  }

  static Future<bool> desasignarCuidadorAnimal(int idAnimal, int idCuidador) async {
    String endpoint = "/delete_relacion_animal_cuidador";
    final Map<String, String> bodo = {"id_animal": idAnimal.toString() , "id_cuidador": idCuidador.toString()};

    final response = await http.post(
        Uri.parse(servidor + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print("Statuscode: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      //throw Exception('Falla al conectarse a la api.');
      return false;
    }
  }

  static Future<bool> addPlanAlimentacion(PlanAlimentacion pa) async {
    String endpoint = "/plan_alimentacion";
    print("AddPlanAlimentacion");
    print(pa.toString());

    final response = await http.post(
        Uri.parse(servidor + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pa)
    );
    print("Statuscode: ${response.statusCode}");
    if(response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      print("Falla al conectarse a la api");
      return false;
      //throw Exception('Falla al conectarse a la api.');
    }
  }

  static Future<bool> addPlanMedicacion(PlanMedicacion pm) async {
    String endpoint = "/medicamento";
    print("AddPlanMedicacion");
    print(pm.toString());

    final response = await http.post(
        Uri.parse(servidor + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pm)
    );
    print("Statuscode: ${response.statusCode}");
    if(response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      print("Falla al conectarse a la api");
      return false;
      //throw Exception('Falla al conectarse a la api.');
    }
  }

  static Future<List<Evento>> getTimeline() async {
    List<Evento> tm=[];
    var f = await SharedPreferences.getInstance();
    int idCuidador = f.getInt("id_cuidador")??0;
    final response = await http.get(
        Uri.parse(servidor + '/linea_temporal_cuidador?id_cuidador=$idCuidador'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    print("Get Timeline");
    print("StatusCode: ${response.statusCode}(${response.reasonPhrase})");
    print("Body:\n"+response.body);
    if(response.statusCode==200 || response.statusCode==400){
      var coso = jsonDecode(response.body);
      for(var a in coso["result"])
        tm.add(Evento.fromJson(a));
    }
    return tm;
  }

  static Future<bool> cumplirEventoAlimentacion(int idPlanAlimentacion, DateTime fecha, bool cumplido ) async {
    String endpoint = "/registro_plan_alimentacion";
    print("cumplirEventoAlimentacion");
    var f = await SharedPreferences.getInstance();
    int idCuidador = f.getInt("id_cuidador")??0;
    String nombreCuidador ='.';
    if(cumplido) nombreCuidador= f.getString("nombre")??'-';
    else nombreCuidador = '-';
    Map<String, String> bodo = {
      "id_plan_alimentacion": idPlanAlimentacion.toString(),
      "fecha": fecha.toIso8601String(),
      "id_cuidador": idCuidador.toString(),
      "observaciones": "-",
      "cumplido": cumplido.toString(),
      "nombre_cuidador": nombreCuidador,
    };

    final response = await http.post(
        Uri.parse(servidor + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print("Statuscode: ${response.statusCode}");
    if(response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      print("Falla al conectarse a la api");
      return false;
      //throw Exception('Falla al conectarse a la api.');
    }
  }

  static Future<bool> cumplirEventoMedicacion(int idMedicamento, DateTime fecha, bool cumplido ) async {
    String endpoint = "/medicamentos_suministrados";
    print("cumplirEventoMedicacion");
    var f = await SharedPreferences.getInstance();
    int idCuidador = f.getInt("id_cuidador")??0;
    String nombreCuidador =f.getString("nombre")??"???";

    Map<String, String> bodo = {
      "id_medicamento": idMedicamento.toString(),
      "fecha": fecha.toIso8601String(),
      "id_cuidador": idCuidador.toString(),
      "observaciones": "-",
      "cumplido": cumplido.toString(),
      "nombre_cuidador": nombreCuidador,
    };

    final response = await http.post(
        Uri.parse(servidor + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodo)
    );
    print("Statuscode: ${response.statusCode}");
    if(response.statusCode == 200 || response.statusCode==400) {
      Map<String, dynamic> cosa = jsonDecode(response.body);
      print(response.body);
      return cosa["ok"];
    } else {
      print("Statuscode: ${response.statusCode}");
      print("Falla al conectarse a la api");
      return false;
      //throw Exception('Falla al conectarse a la api.');
    }
  }







}
