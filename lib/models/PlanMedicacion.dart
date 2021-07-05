class PlanMedicacion{
  String nombre;
  String dosis;
  DateTime fechaInicio;
  DateTime fechaTermino;
  int idAnimal;
  String periodicidad;
  String observaciones;

  PlanMedicacion({
    required this.nombre,
    required this.dosis ,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.idAnimal ,
    required this.periodicidad,
    required this.observaciones,});

  Map<String, String> toJson()=>{
    "nombre_medicamento": nombre,
    "dosis": dosis,
    "fecha_inicio": fechaInicio.toIso8601String(),
    "fecha_termino": fechaTermino.toIso8601String(),
    "id_animal": idAnimal.toString(),
    "periodicidad": periodicidad.replaceAll('Horas', 'hours').replaceAll('Dias', 'days').replaceAll('Semanas','weeks'),
    "observaciones": observaciones,
  };

  toString(){
    return """
    Nombre: $nombre,
    Dosis: $dosis,
    Fecha_inicio: ${fechaInicio.toIso8601String()},
    Fecha_termino: ${fechaTermino.toIso8601String()},
    Id_animal: ${idAnimal.toString()},
    Periodicidad: $periodicidad,
    Observaciones: $observaciones
    """;
  }

}