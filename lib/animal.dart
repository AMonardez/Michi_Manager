class Animal{
  int? id;
  String nombre;
  String tipo;
  String? raza;
  int sexo; //0:macho, 1:hembra, 2:nobinario
  bool? castrado;
  String? color;
  DateTime? fecha_nacimiento;
  String? observaciones;

  Animal(this.id, this.nombre,this.tipo, this.raza, this.sexo,
      this.castrado, this.color, this.fecha_nacimiento,this.observaciones);

  //TODO: Crear constructor a partir de un JSON.

  Animal.constructorMinimo(this.nombre, this.tipo, this.sexo);

  static List<Animal> animales_de_prueba(){
    List<Animal> aux = [
    new Animal(1, "Tom", "Gato", "Romano",0, false, "Blanco", new DateTime.now(), "Comprado en el modulo 15"),
    new Animal(2, "Chocolo", "Perro", "Quiltro",0, true, "Café", new DateTime.now(), "Populars"),
    ];
    return aux;
  }

  @override
  toString(){
    return "Nombre: " + nombre + "\nTipo: " + tipo;
  }
}