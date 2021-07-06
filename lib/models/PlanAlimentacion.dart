class PlanAlimentacion{
  String nombre;
  String dosis;
  DateTime fechaInicio;
  int idAnimal;
  String periodicidad;
  String observaciones;
  int? idPlan=-1;

  PlanAlimentacion({
    required this.nombre,
    required this.dosis ,
    required this.fechaInicio ,
    required this.idAnimal ,
    required this.periodicidad,
    required this.observaciones,
    this.idPlan});

  Map<String, String> toJson()=>{
    "nombre_alimento": nombre,
    "dosis": dosis,
    "fecha_inicio": fechaInicio.toIso8601String(),
    "id_animal": idAnimal.toString(),
    "periodicidad": periodicidad.replaceAll('Horas', 'hours').replaceAll('Dias', 'days').replaceAll('Semanas','weeks'),
    "observaciones": observaciones,
    "marca": '-'
  };

  factory PlanAlimentacion.fromJson(Map<String, dynamic> json) {
    return PlanAlimentacion(
        fechaInicio: DateTime.parse(json['fecha_inicio']),
        nombre: json['nombre_alimento'],
        observaciones: json['observaciones'],
        dosis: json['dosis'],
        idAnimal: json['id_animal'],
        periodicidad: json['periodicidad'].replaceAll('Dias', 'days').replaceAll('Semanas','weeks'),
        idPlan: json['id_plan_alimentacion']??-1
        //Falta la marca.
    );
  }

  toString(){
    return """
    Nombre: $nombre,
    Dosis: $dosis,
    Fecha_inicio: ${fechaInicio.toIso8601String()},
    Id_animal: ${idAnimal.toString()},
    Periodicidad: $periodicidad,
    Observaciones: $observaciones
    """;
  }

}