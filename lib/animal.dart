class Animal{
  String nombre;
  String tipo;
  String raza;
  int sexo; //0:macho, 1:hembra, 2:nobinario
  bool castrado;
  String color;
  DateTime fecha_nacimiento;
  String? observaciones;

  Animal(this.nombre,this.tipo, this.raza, this.sexo, this.castrado, this.color, this.fecha_nacimiento,this.observaciones);
  //TO-DO: Crear constructor a partir de un JSON.
}