class PlanAlimentacion{
  String nombre;
  String dosis;
  DateTime fechaInicio;
  int idAnimal;
  String periodicidad;
  String observaciones;

  PlanAlimentacion({
    required this.nombre,
    required this.dosis ,
    required this.fechaInicio ,
    required this.idAnimal ,
    required this.periodicidad,
    required this.observaciones,});

  Map<String, String> toJson()=>{
    "nombre_alimento": nombre,
    "dosis": dosis,
    "fecha_inicio": fechaInicio.toIso8601String(),
    "id_animal": idAnimal.toString(),
    "periodicidad": periodicidad.replaceAll('Horas', 'hours').replaceAll('Dias', 'days').replaceAll('Semanas','weeks'),
    "observaciones": observaciones,
    "marca": '-'
  };

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