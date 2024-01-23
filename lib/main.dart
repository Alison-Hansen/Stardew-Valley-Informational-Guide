import 'package:flutter/material.dart';
import 'home.dart';
import 'crops.dart';
import 'fish.dart';
import 'villagers.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project 3',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => const Home(title: 'Home Page'),
        '/crops': (BuildContext context) => const Crops(title: 'Crop Page'),
        '/fish': (BuildContext context) => const Fish(title: 'Fish Page'),
        '/villagers': (BuildContext context) => const Villagers(title: 'Villagers Page'),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: const Color.fromRGBO(226, 122, 62, 1), background: const Color.fromRGBO(255, 215, 137, 1), primaryContainer: const Color.fromRGBO(252, 236, 186, 1)),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.black87, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16),
          bodySmall: TextStyle(color: Colors.black87, fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 16),
          labelSmall: TextStyle(color: Colors.black54, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16),
          displayLarge: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 30),
          displayMedium: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 28),
          displaySmall: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 20)
        )
      ),
    );
  }
}
