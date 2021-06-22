class Evento{
  int idEvento;
  int idAnimal;
  String nombreAnimal;
  String tipo;
  String nombre;
  String cantidad;
  DateTime fecha;
  bool cumplido;

  Evento(this.idEvento, this.idAnimal,  this.tipo, this.nombreAnimal,this.nombre,
      this.cantidad, this.fecha, this.cumplido);

  static List<Evento> listaEjemplos(){
    var aux=[
      new Evento(1,1, "Alimentación",'Luna', "Whiskas", "200gr", DateTime.parse('2020-06-03 10:00:00'), true),
      new Evento(2,1, "Alimentación", 'Luna',"Whiskas", "200gr", DateTime.parse('2020-06-03 18:00:00'), true),
      new Evento(2,2, "Medicacion", "Poroto","Paracetamol", "10 mg", DateTime.parse('2020-06-03 20:00:00'), false),
      new Evento(3,1, "Alimentación",'Luna',  "Whiskas", "200gr", DateTime.parse('2020-06-04 10:00:00'), false),
      new Evento(1,2, "Alimentación",'Luna',  "Cachupin", "300gr", DateTime.parse('2020-06-04 18:00:00'), true),
      new Evento(2,2, "Medicacion", "Poroto","Paracetamol", "10 mg", DateTime.parse('2020-06-04 20:00:00'), false),

    ];
    return aux;
  }

  @override
  String toString() {
    return "idEvento: "+idEvento.toString() + "\nidAnimal: "+idAnimal.toString()+
    "\nTipo: "+tipo +"\nNombre"+nombre+"\nCantidad:"+cantidad+"\nFecha"+fecha.toString()+
        "\nCumplido: "+cumplido.toString();
  }
}

