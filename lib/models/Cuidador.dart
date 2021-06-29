class Cuidador{
  int? idCuidador;
  String nombre;
  String correo;
  DateTime? fechaIngreso;

  Cuidador({required this.nombre, required this.correo, required this.fechaIngreso, this.idCuidador});

  factory Cuidador.fromJson(Map<String, dynamic> json){
    return Cuidador(nombre:json["nombre"], correo: json["correo"],
        fechaIngreso: json['fecha_ingreso']==null?null:DateTime.parse(json['fecha_ingreso']),
        idCuidador: json["id_cuidador"]
    );
  }

  toString(){
    return "Nombre:$nombre\nCorreo:$correo\nID:$idCuidador";
  }

}