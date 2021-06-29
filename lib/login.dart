import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michi_manager/registrarse.dart';
import 'package:michi_manager/viewHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formaRegistroKey = new GlobalKey<FormState>();
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
          print('Boton Login!');
          print("Correo: ${correo.text} , Contraseña: ${contrasena.text}");
          if(_formaRegistroKey.currentState!.validate()){

            bool loginado = await API.loginCuidador(correo.text, contrasena.text);
            if(loginado){
              final snackbar = SnackBar(content: Text("Login exitoso."));
              //ScaffoldMessenger.of(context).showSnackBar(snackbar);
              //Navigator.pop(context);
              SharedPreferences pfs= await SharedPreferences.getInstance();
              //pfs.setString("usuario", correo.text);
              //pfs.setString("contrasena", contrasena.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaPrincipal()));
            }
            else {
              final snackbar = SnackBar(content: Text("Credenciales Incorrectas."));
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
          'Iniciar Sesión',
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff48c6ef), Color(0xff6f86d6)
                    ],
                    stops: [ 0.7, 0.9],
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
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
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
                                  return 'El Email no puede estar vacío.';
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
                        _buildSignupBtn(),
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrarseScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Registrarse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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