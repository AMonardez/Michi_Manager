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
    new Animal(id:1, nombre:"Tom", especie:"Gato", raza:"Romano", sexo:'Macho',
        esterilizado:false, color:"Blanco", fechaNacimiento:new DateTime.now(),
        observaciones:"Comprado en el modulo 15"),
    new Animal(id:2, nombre:"Chocolo", especie:"Perro", raza:"Quiltro", sexo:'Macho',
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
      "fechaNacimiento: ${fechaNacimiento ==null?'Undef':fechabonita(fechaNacimiento!)}";

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
    'fechaNacimiento': fechaNacimiento==null?null:fechaNacimiento!.toIso8601String()
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
    print("fechaNacimiento: ${json['fechaNacimiento']} tipo: ${json['fechaNacimiento'].runtimeType}");*/

    return Animal(id: json['id_animal'],
                  nombre: json['nombre'],
                  especie:json['especie'],
                  raza: json['raza'],
                  sexo: json['sexo'],
                  esterilizado: json['esterilizado'],
                  color: json['color'],
                  fechaNacimiento: json['fechaNacimiento']==null?null:DateTime.parse(json['fechaNacimiento']),
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


  static String fechabonita(DateTime dt){
    var stringList =  dt.toIso8601String().split(new RegExp(r"[T\.]"));
    var numeritos= stringList[0].split("-");
    var fechabien = "" + numeritos[2] + "-" + numeritos[1] + '-' + numeritos[0];
    return fechabien;
  }

}