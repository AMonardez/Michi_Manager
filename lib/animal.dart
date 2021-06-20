class Animal{
  int? id;
  String nombre;
  String especie;
  String? raza;
  String sexo; //0:macho, 1:hembra, 2:nobinario
  bool? esterilizado;
  String? color;
  DateTime? fecha_nacimiento;
  String? observaciones;

  Animal({this.id,
          required this.nombre,
          required this.especie,
          required this.sexo,
          this.raza,
          this.esterilizado,
          this.color,
          this.fecha_nacimiento,
          this.observaciones});

  Animal.constructorMinimo({required this.nombre, required this.especie, required this.sexo});

  static List<Animal> animales_de_prueba(){
    List<Animal> aux = [
    new Animal(id:1, nombre:"Tom", especie:"Gato", raza:"Romano", sexo:'Macho',
        esterilizado:false, color:"Blanco", fecha_nacimiento:new DateTime.now(),
        observaciones:"Comprado en el modulo 15"),
    new Animal(id:2, nombre:"Chocolo", especie:"Perro", raza:"Quiltro", sexo:'Macho',
        esterilizado:true, color:"Café", fecha_nacimiento:new DateTime.now(),
        observaciones:"Populars"),
    ];
    return aux;
  }

  factory Animal.dePrueba(){
    return Animal(id:1, nombre:"Tom", especie:"Gato", raza:"Romano", sexo:'Macho',
        esterilizado:false, color:"Blanco", fecha_nacimiento:new DateTime.now(),
        observaciones:"Comprado en el modulo 15");
  }

  @override
  toString(){
    return
      "Id_Animal: ${id==null?'Undef':id}\n"+
      "Nombre: ${nombre}\n"+
      "Especie: ${especie}\n"+
      "Sexo: ${sexo}\n"+
      "esterilizado: ${esterilizado ==null?'Undef':esterilizado}\n"+
      "raza: ${raza ==null?'Undef':raza}\n"+
      "color: ${color ==null?'Undef':color}\n"+
      "sexo: ${sexo ==null?'Undef':sexo}\n"+
      "observaciones: ${observaciones ==null?'Undef':observaciones}\n"+
      "fecha_nacimiento: ${fecha_nacimiento ==null?'Undef':fechabonita(fecha_nacimiento!)}";

  }

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'especie': especie,
    'sexo' : sexo,
    'raza' : raza==null?'No especificada':raza,
    'esterilizado': (esterilizado==null?'false':esterilizado.toString()),
    'color': color==null?'No especificado':color,
    'observaciones': observaciones==null?'No especificado':observaciones,
    //'fecha_nacimiento': DateTime.now().toIso8601String()
    'fecha_nacimiento': fecha_nacimiento==null?null:fecha_nacimiento!.toIso8601String()
  };

  factory Animal.fromJson(Map<String, dynamic> json) {
    /*print("Convirtiendo de json");
    print("idAnimal: ${json['id_animal']} tipo: ${json['id_animal'].runtimeType}");
    print("Nombre: ${json['nombre']} tipo: ${json['nombre'].runtimeType}");
    print("Especie: ${json['especie']} tipo: ${json['especie'].runtimeType}");
    print("Raza: ${json['raza']} tipo: ${json['raza'].runtimeType}");
    print("Sexo: ${json['sexo']} tipo: ${json['sexo'].runtimeType}");
    print("Esterilizado: ${json['esterilizado']} tipo: ${json['esterilizado'].runtimeType}");
        print("color: ${json['color']} tipo: ${json['color'].runtimeType}");
    print("fecha_nacimiento: ${json['fecha_nacimiento']} tipo: ${json['fecha_nacimiento'].runtimeType}");*/

    return Animal(id: json['id_animal'],
                  nombre: json['nombre'],
                  especie:json['especie'],
                  raza: json['raza'],
                  sexo: json['sexo'],
                  esterilizado: json['esterilizado'],
                  color: json['color'],
                  fecha_nacimiento: DateTime.parse(json['fecha_nacimiento']),
                  //fecha_nacimiento: DateTime.now(),
                  observaciones: json['observaciones']
    );
  }
  List<Animal> listadoJson(Map<String, dynamic> json){
    List<Animal> aux=[];
    aux.add(Animal.dePrueba());
    aux.add(Animal.dePrueba());
    return aux;
  }


  static String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}