import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'API.dart';

class RegistrarseScreen extends StatefulWidget {
  @override
  RegistrarseState createState() => RegistrarseState();

}

class RegistrarseState extends State<RegistrarseScreen> {
  final _formaRegistroKey = new GlobalKey<FormState>();
  DateTime fecha = DateTime.now();
  var nombre = new TextEditingController();
  var correo = new TextEditingController();
  var contrasena = new TextEditingController();


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async
        {
          print('Registrando!');
          print("Nombre: ${nombre.text}, Correo: ${correo.text} , Contraseña: ${contrasena.text} , Fecha: ${fecha.toString()}");
          if(_formaRegistroKey.currentState!.validate()){
            print("Validando");
            bool guardado = await API.guardarCuidador(nombre.text, fecha, correo.text, contrasena.text);
            if(guardado){
              final snackbar = SnackBar(content: Text("Usuario registrado exitosamente."));
              Navigator.pop(context);
              //Navigator.pop(context);
              //Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            else {
              final snackbar = SnackBar(content: Text("Falló al registrar el usuario."));
              //Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          }
        }
        ,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Registrarse',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff48c6ef), Color(0xff6f86d6)
                    ],
                    //stops: [ 0.7, 0.9],
                  ),
                ),
              ),
              Form(
                key: _formaRegistroKey,
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Nombre',
                          style: kLabelStyle,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          height: 60.0,
                          child: TextFormField(

                            controller : nombre,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Escriba su Nombre',
                              hintStyle: kHintTextStyle,
                            ),
                              validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'El nombre no puede estar vacío.';
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Email',
                          style: kLabelStyle,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          height: 60.0,
                          child: TextFormField(
                            controller : correo,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: 'Escriba su Email',
                              hintStyle: kHintTextStyle,
                            ),
                              validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'El correo no puede estar vacío.';
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Contraseña',
                          style: kLabelStyle,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          height: 60.0,
                          child: TextFormField(
                            controller: contrasena,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: 'Escriba su contraseña',
                              hintStyle: kHintTextStyle,
                            ),
                              validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'La contraseña no puede estar vacía.';
                                }
                                return null;
                              }
                          ),
                        ),
                        _buildLoginBtn(),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final kHintTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'Nunito',
  );

  final kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Nunito',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: Color(0x66AAAAAA),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );


}