class Animal{
  int? id;
  String nombre;
  String especie;
  String? raza;
  String sexo; //0:macho, 1:hembra, 2:nobinario
  bool? esterilizado;
  String? color;
  DateTime? fechaNacimiento;
  String? observaciones;

  Animal({this.id,
          required this.nombre,
          required this.especie,
          required this.sexo,
          this.raza,
          this.esterilizado,
          this.color,
          this.fechaNacimiento,
          this.observaciones});

  Animal.constructorMinimo({required this.nombre, required this.especie, required this.sexo});

  static List<Animal> animalesDePrueba(){
    List<Animal> aux = [
    new Animal(id:16, nombre:"Luna", especie:"Gato", raza:"Romano", sexo:'Macho',
        esterilizado:false, color:"Blanco", fechaNacimiento:new DateTime.now(),
        observaciones:"Comprado en el modulo 15"),
    new Animal(id:18, nombre:"Poroto", especie:"Perro", raza:"Quiltro", sexo:'Macho',
        esterilizado:true, color:"Café", fechaNacimiento:new DateTime.now(),
        observaciones:"Populars"),
    ];
    return aux;
  }

  factory Animal.dePrueba(){
    return Animal(id:1, nombre:"Tom", especie:"Gato", raza:"Romano", sexo:'Macho',
        esterilizado:false, color:"Blanco", fechaNacimiento:new DateTime.now(),
        observaciones:"Comprado en el modulo 15");
  }

  @override
  toString(){
    return
      "Id_Animal: ${id==null?'Undef':id}\n"+
      "Nombre: $nombre\n"+
      "Especie: $especie\n"+
      "Sexo: $sexo\n"+
      "esterilizado: ${esterilizado ==null?'Undef':esterilizado}\n"+
      "raza: ${raza ==null?'Undef':raza}\n"+
      "color: ${color ==null?'Undef':color}\n"+
      "observaciones: ${observaciones ==null?'Undef':observaciones}\n"+
      "fechaNacimiento: ${fechaNacimiento ==null?'Undef':fechaNacimiento!.toIso8601String()}";
  }

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'especie': especie,
    'sexo' : sexo,
    'raza' : raza==null?'No especificada':raza,
    'esterilizado': (esterilizado==null?'false':esterilizado.toString()),
    'color': color==null?'No especificado':color,
    'observaciones': observaciones==null?'No especificado':observaciones,
    //'fechaNacimiento': DateTime.now().toIso8601String()
    'fecha_nacimiento': fechaNacimiento==null?null:fechaNacimiento!.toIso8601String()
  };

  factory Animal.fromJson(Map<String, dynamic> json) {
       return Animal(id: json['id_animal'],
                  nombre: json['nombre'],
                  especie:json['especie'],
                  raza: json['raza'],
                  sexo: json['sexo'],
                  esterilizado: json['esterilizado'],
                  color: json['color'],
                  fechaNacimiento: json['fecha_nacimiento']==null?null:DateTime.parse(json['fecha_nacimiento']),
                  //fechaNacimiento: DateTime.now(),
                  observaciones: json['observaciones']
    );
  }

  List<Animal> listadoJson(Map<String, dynamic> json){
    List<Animal> aux=[];
    aux.add(Animal.dePrueba());
    aux.add(Animal.dePrueba());
    return aux;
  }


}