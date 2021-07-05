class Evento{
  int idPlan;
  int idAnimal;
  String nombreAnimal;
  String tipoEvento;
  String nombreEvento;
  String cantidad;
  DateTime fecha;
  bool cumplido;
  String nombreCuidador;

  Evento({required this.idPlan, required this.idAnimal,  required this.tipoEvento, required this.nombreAnimal,required this.nombreEvento,
      required this.cantidad, required this.fecha, required this.cumplido, required this.nombreCuidador});

  static List<Evento> listaEjemplos(){
    var aux=[
      new Evento(idPlan:1, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal:'Luna', nombreEvento: "Whiskas", cantidad: "200gr", fecha: DateTime.parse('2020-01-03 10:00:00'),  cumplido:true, nombreCuidador: "AlejandroTest"),
      new Evento(idPlan:2, idAnimal:1, tipoEvento:"alimentacion", nombreAnimal: 'Luna',nombreEvento:"Whiskas",cantidad: "200gr", fecha:DateTime.parse('2020-02-03 18:00:00'),cumplido: true, nombreCuidador: "AlejandroTest"),
      new Evento(idPlan:2, idAnimal:2, tipoEvento:"medicacion", nombreAnimal:"Poroto",nombreEvento:"Paracetamol", cantidad:"10 mg",fecha: DateTime.parse('2020-06-03 20:00:00'),cumplido: false, nombreCuidador: "AlejandroTest"),
      /*new Evento(3,1, "Alimentación",'Luna',  "Whiskas", "200gr", DateTime.parse('2020-08-04 10:00:00'), false),
      new Evento(1,2, "Alimentación",'Luna',  "Cachupin", "300gr", DateTime.parse('2020-06-04 18:00:00'), false),
      new Evento(2,2, "Medicacion", "Poroto","Paracetamol", "10 mg", DateTime.parse('2020-12-04 20:00:00'), false),*/
    ];
    return aux;
  }

  @override
  String toString() {
    return "idPlan: $idPlan\n" "idEvento: "+idPlan.toString() + "\nidAnimal: "+idAnimal.toString()+
    "\nTipo: "+tipoEvento +"\nNombre"+nombreEvento+"\nCantidad:"+cantidad+"\nFecha"+fecha.toString()+
        "\nCumplido: "+cumplido.toString();
  }

  factory Evento.fromJson(Map<String, dynamic> json) {
    return
      Evento(idPlan: json['id_plan'],
          idAnimal: json['id_animal'],
          tipoEvento: json['tipo_evento'],
          nombreAnimal:json['nombre_animal'],
          nombreEvento: json['nombre_plan'],
          cantidad: json['dosis'],
          fecha: DateTime.parse(json['fecha']),
          cumplido:json['cumplido'],
          nombreCuidador: json['nombre_cuidador']??'NOMBRE CUIDADOR PENDIENTE'
      );
  }

}

