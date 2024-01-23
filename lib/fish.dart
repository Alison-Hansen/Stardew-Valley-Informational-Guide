import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'crops.dart';
import 'villagers.dart';

class Fish extends StatefulWidget{
    const Fish({super.key, required String title});

    @override
    State<Fish> createState() => _FishState();
}

class _FishState extends State<Fish>{
    String selectedValue = "All Fish";
    List _allFish = [];    
    List _springFish = [];
    List _summerFish = [];
    List _fallFish = [];
    List _winterFish = [];
    List _gingerFish = [];
    List<Widget> widgetList = [];

    Future<void> readJson() async {
      final String response = await rootBundle.loadString('assets/data/fish.json');
      final data = await json.decode(response);
      setState(() {
        _springFish = data["spring"];
        _summerFish = data["summer"];
        _fallFish = data["fall"];
        _winterFish = data["winter"];
        _gingerFish = data["ginger"];
        makeAllFishList();
      });
    }

    makeAllFishList(){
      _allFish += _springFish;
      int matchCounter = 0;
      for(var item in _summerFish){
        for(var fish in _allFish){
          if(item["name"] == fish["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allFish.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _fallFish){
        for(var fish in _allFish){
          if(item["name"] == fish["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allFish.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _winterFish){
        for(var fish in _allFish){
          if(item["name"] == fish["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allFish.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _gingerFish){
        for(var fish in _allFish){
          if(item["name"] == fish["name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allFish.add(item);
        }
        matchCounter = 0;
      }
    }

    ListTile makeListTile(list, index) {
      return ListTile(
        leading: makeFishImage(list,index),
        title: Text(list[index]["name"], style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(list[index]["location"], style: Theme.of(context).textTheme.labelSmall),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    List<DropdownMenuItem<String>> get dropdownItems{
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(value: "All Fish",child: Text("All Fish", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Spring Fish",child: Text("Spring Fish", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Summer Fish",child: Text("Summer Fish", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Fall Fish",child: Text("Fall Fish", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Winter Fish",child: Text("Winter Fish", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Ginger Island Fish",child: Text("Ginger Island Fish", style: Theme.of(context).textTheme.bodyMedium)),
      ];
      return menuItems;
    }

    makeFishImage(list, index){
      return Image.asset(list[index]["image"]);
    }

    makeQualityFishImage(list, index, img){
      if(img == null){
        return Padding(
        padding: const EdgeInsets.all(2.5),
        child: Stack(children: [
          Image.asset(list[index]["image"])
        ],),
      );
      }else{
        return Padding(
        padding: const EdgeInsets.all(2.5),
        child: Stack(children: [
          Image.asset(list[index]["image"]),
          Image.asset(img)
        ],),
      );
      }
    }

    Container listPrices(list, index){
      // ignore: sized_box_for_whitespace
      return Container(
        width: double.infinity,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text("Quality",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Base",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
                ),
                Text("Fisher",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
                Text("Angler",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
              ]
            ),
            TableRow(
              children: [
                makeQualityFishImage(list, index, null),
                Text(list[index]["prices"][0]["base"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][0]["fisher"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][0]["angler"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityFishImage(list, index, "assets/images/Silver_Quality_Icon.png"),
                Text(list[index]["prices"][1]["base"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][1]["fisher"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][1]["angler"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityFishImage(list, index, "assets/images/Gold_Quality_Icon.png"),
                Text(list[index]["prices"][2]["base"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][2]["fisher"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][2]["angler"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityFishImage(list, index, "assets/images/Iridium_Quality_Icon.png"),
                Text(list[index]["prices"][3]["base"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][3]["fisher"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["prices"][3]["angler"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
          ],
        ),
      );
    }

    AlertDialog buildPopupDialog(context, list, index){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeFishImage(list, index),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(list[index]["name"], style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
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
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Text("Location: ", style: Theme.of(context).textTheme.bodyMedium),
                  Text("${list[index]['location']}", style: Theme.of(context).textTheme.bodySmall),
                ],
              ),

              Row(
                children: [
                  Text("Time: ", style: Theme.of(context).textTheme.bodyMedium),
                  Text("${list[index]['time']}", style: Theme.of(context).textTheme.bodySmall),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Text("Weather: ", style: Theme.of(context).textTheme.bodyMedium),
                    Text("${list[index]['weather']}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),

              Text("Sell Prices Based on Profession:", style: Theme.of(context).textTheme.bodyMedium),
              listPrices(list, index),
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
              title: Text('Fish', style: Theme.of(context).textTheme.displayLarge),
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
                  
                  // Display the data loaded from fish.json
                  _allFish.isNotEmpty && selectedValue == "All Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _allFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _allFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_allFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _springFish.isNotEmpty && selectedValue == "Spring Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _springFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _springFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_springFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _summerFish.isNotEmpty && selectedValue == "Summer Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _summerFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _summerFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_summerFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _fallFish.isNotEmpty && selectedValue == "Fall Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _fallFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _fallFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_fallFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _winterFish.isNotEmpty && selectedValue == "Winter Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _winterFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _winterFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_winterFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _gingerFish.isNotEmpty && selectedValue == "Ginger Island Fish"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _gingerFish.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _gingerFish, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_gingerFish, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
        );
    }
}