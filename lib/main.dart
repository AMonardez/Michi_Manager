import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michi_manager/viewHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'login.dart';

Future<bool> getLoginado() async {
  WidgetsFlutterBinding.ensureInitialized();
  var f = SharedPreferences.getInstance();
  var p= await f;
  return p.containsKey("correo");
}

void main() async {
  bool valor = await getLoginado();
  runApp(MyApp(valor));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  bool loginado=false;

  MyApp(this.loginado);

  @override
  Widget build(BuildContext context) {
    print(loginado.toString());

    return MaterialApp(
      title: 'Maneja tus Michis',
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito', brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito', brightness: Brightness.dark),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // ONLY if it's a RTL language
      ],
      supportedLocales: const [
        Locale('es', 'US'), // include country code too
      ],
      home: loginado?PaginaPrincipal():LoginScreen(),
    );
  }
}





