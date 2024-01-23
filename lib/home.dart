import 'package:flutter/material.dart';
import 'crops.dart';

class Home extends StatefulWidget{
    const Home({super.key, required String title});

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,

            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Image.asset("assets/images/Main_Logo.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Text('Informational Guide', style: Theme.of(context).textTheme.displayMedium),
                    ),
                    ElevatedButton(
                      onPressed:(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Crops(title: 'Crop Page')),
                        );
                      }), 
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Get Started', style: Theme.of(context).textTheme.displaySmall),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
    }
}