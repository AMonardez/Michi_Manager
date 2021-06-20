import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Animalx {
  late int id;
  late String nombre;
  late String tipo;
  late String color;
  late int edad;
  late double peso;

  Animalx(this.id, this.nombre, this.tipo, this.color, this.edad, this.peso);

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'nombre': nombre,
      'tipo': tipo,
      'color': color,
      'edad': edad,
      'peso': peso
    };
  }

  abrirDatabase() async{
    String nombredb = 'michimanagers.db';
    String dbruta = join(await getDatabasesPath(), nombredb);
    var database = await openDatabase(dbruta, version:1);
    return database;
  }

  Future<List> getAnimales() async {
    var database= abrirDatabase();
    var resultados= await database.rawQuery('SELECT * from animales');
    return resultados.toList();
  }

}