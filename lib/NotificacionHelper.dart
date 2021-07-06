import 'models/Evento.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> postNotificaciones(List<Evento> lev) async {
  print("Posteando notificaiones");
  for(var l in lev) print(l.toString());
  tz.initializeTimeZones();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancelAll();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'michitos123', 'Eventos', 'Notificaciones de recordatorios',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  /*await flutterLocalNotificationsPlugin.show(
        0, 'Pichicaca', 'Se te murió la mascota.', platformChannelSpecifics,
       payload: 'item x');*/
  for (var v in lev) {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      v.hashCode,//id
      "${v.nombreAnimal}: ${v.nombreEvento}",
      'Tu mascota necesita su ${v.tipoEvento}.\nCantidad: ${v.cantidad}',
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)
      tz.TZDateTime.from(
          v.fecha,
          tz.local),
      const NotificationDetails(
          android: AndroidNotificationDetails('michitos123',
              'Recordatorios', 'testchannel')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}


Future<void> deleteNotificaciones()async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancelAll();
}

List<Evento> filterFuturos(List<Evento> ev){
  var fechaActual = DateTime.now();
  return ev.where((element) {return element.fecha.isAfter(fechaActual) && element.cumplido==false;
  }).toList();

}
