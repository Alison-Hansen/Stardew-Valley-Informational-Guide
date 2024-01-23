import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'crops.dart';
import 'fish.dart';

class Villagers extends StatefulWidget{
    const Villagers({super.key, required String title});

    @override
    State<Villagers> createState() => _VillagersState();
}

class _VillagersState extends State<Villagers>{
    String selectedValue = "All Villagers";
    List _allVillagers = [];    
    List _springVillagers = [];
    List _summerVillagers = [];
    List _fallVillagers = [];
    List _winterVillagers = [];
    List<Widget> widgetList = [];

    Future<void> readJson() async {
      final String response = await rootBundle.loadString('assets/data/villagers.json');
      final data = await json.decode(response);
      setState(() {
        _springVillagers = data["spring"];
        _summerVillagers = data["summer"];
        _fallVillagers = data["fall"];
        _winterVillagers = data["winter"];
        makeAllVillagersList();
      });
    }

    makeAllVillagersList(){
      _allVillagers += _springVillagers;
      int matchCounter = 0;
      for(var item in _summerVillagers){
        for(var villager in _allVillagers){
          if(item["name"] == villager["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allVillagers.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _fallVillagers){
        for(var villager in _allVillagers){
          if(item["name"] == villager["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allVillagers.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _winterVillagers){
        for(var villager in _allVillagers){
          if(item["name"] == villager["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allVillagers.add(item);
        }
        matchCounter = 0;
      }
    }

    ListTile makeListTile(list, index) {
      return ListTile(
        leading: makeVillagerImage(list,index),
        title: Text(list[index]["name"], style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(list[index]["birthday"], style: Theme.of(context).textTheme.labelSmall),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    List<DropdownMenuItem<String>> get dropdownItems{
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(value: "All Villagers",child: Text("All Villagers", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Spring Birthdays",child: Text("Spring Birthdays", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Summer Birthdays",child: Text("Summer Birthdays", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Fall Birthdays",child: Text("Fall Birthdays", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Winter Birthdays",child: Text("Winter Birthdays", style: Theme.of(context).textTheme.bodyMedium)),
      ];
      return menuItems;
    }

    Image makeVillagerImage(list, index){
      return Image.asset(list[index]["image"]);
    }

    listGifts(list, index){
      widgetList.clear();
      for(var i = 0; i < list[index]["loved gifts"].length; i++){
        widgetList.add(Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Image.asset(list[index]["loved gifts"][i]["image"]),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(list[index]["loved gifts"][i]["gift name"], style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ));
      }
      return Column(children: widgetList);
    }

    AlertDialog buildPopupDialog(context, list, index){
      return AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.all(10),
        icon: makeVillagerImage(list, index),
        title: Text(list[index]["name"], style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        content: Center(
          heightFactor: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Birthday: ", style: Theme.of(context).textTheme.bodyMedium),
                    Text("${list[index]['birthday']}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Marriage Candidate: ", style: Theme.of(context).textTheme.bodyMedium),
                    Text("${list[index]['marriage']}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Loved Gifts:", style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              listGifts(list, index)
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    }

    @override
    void initState() {
      super.initState();
      readJson();
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,

            appBar: AppBar(
              centerTitle: true,
              title: Text('Villagers', style: Theme.of(context).textTheme.displayLarge),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: ElevatedButton(
                      onPressed:(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Crops(title: 'Crop Page')),
                        );
                      }), 
                      child: const Text('Crops'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: ElevatedButton(
                      onPressed:(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Fish(title: 'Fish Page')),
                        );
                      }), 
                      child: const Text('Fish'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: ElevatedButton(
                      onPressed:(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Villagers(title: 'Villagers Page')),
                        );
                      }), 
                      child: const Text('Villagers'),
                    ),
                  ),
                ],
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        border: Border.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                          value: selectedValue,
                          onChanged: (String? newValue){
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems
                        ),
                    ),

                    // Display the data loaded from Villagers.json
                    _allVillagers.isNotEmpty && selectedValue == "All Villagers"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _allVillagers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _allVillagers, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_allVillagers, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                    _springVillagers.isNotEmpty && selectedValue == "Spring Birthdays"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _springVillagers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _springVillagers, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_springVillagers, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                    _summerVillagers.isNotEmpty && selectedValue == "Summer Birthdays"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _summerVillagers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _summerVillagers, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_summerVillagers, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                    _fallVillagers.isNotEmpty && selectedValue == "Fall Birthdays"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _fallVillagers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _fallVillagers, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_fallVillagers, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                    _winterVillagers.isNotEmpty && selectedValue == "Winter Birthdays"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _winterVillagers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _winterVillagers, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_winterVillagers, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  ],
                ),
              ),
            ),
        );
    }
}