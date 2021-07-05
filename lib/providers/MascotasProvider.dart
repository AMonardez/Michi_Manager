import 'package:michi_manager/models/Animal.dart';
import '../API.dart';

class MascotasProvider{
  late Future<List<Animal>> mascotas;

  Future<List<Animal>> get obtener{
    return mascotas;
  }

  Future<List<Animal>> get refrescar{
    var result= API.getMisAnimales('amonardezt@alumnosuls.cl', '1234');
    mascotas=result;
    return mascotas;
  }

}