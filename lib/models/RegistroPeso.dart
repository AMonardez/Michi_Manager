class RegistroPeso{
  late DateTime fecha;
  late double peso;
  late int idAnimal;
  String? observaciones;

  RegistroPeso({required this.fecha, required this.peso, required this.idAnimal, this.observaciones});

  factory RegistroPeso.dePrueba() {
    return RegistroPeso(
      fecha: DateTime.now().add(Duration(days:0)),
      peso: 10.0,
      idAnimal:10,
      observaciones: "Es el Perro guatón."
    );
  }

  static Future<List<RegistroPeso>> listaPesos(int cuantos, int idanimal) async {
    List<RegistroPeso> aux=[];
    for(int i =0; i<cuantos; i++){
      aux.add(new RegistroPeso(fecha: DateTime.now().add(Duration(days:i)),
          peso: (5+ i*2), idAnimal: idanimal));
    }
    return aux;
  }

  static List<RegistroPeso> listaPesos_Sinfuturo(int cuantos, int idanimal) {
    List<RegistroPeso> aux=[];
    for(int i =0; i<cuantos; i++){
      aux.add(new RegistroPeso(fecha: DateTime.now().add(Duration(days:i)),
          peso: (5+ i*2), idAnimal: idanimal));
    }
    return aux;
  }

  @override
  String toString(){
    return "Fecha: ${fecha.toIso8601String()}\nPeso: $peso\nidAnimal: $idAnimal\nObserv: $observaciones";
  }

  Map<String, dynamic>toJson() =>{
    "fecha": fecha.toIso8601String(),
    "peso": peso.toString(),
    "id_animal": idAnimal.toString(),
    "observaciones": observaciones==null?"-":observaciones
  };

  factory RegistroPeso.fromJson(Map<String, dynamic> json){
    return RegistroPeso(idAnimal: json["id_animal"],
        fecha: DateTime.parse(json["fecha"]),
        peso: json['peso'],
      observaciones: json['observaciones']
    );

  }



}