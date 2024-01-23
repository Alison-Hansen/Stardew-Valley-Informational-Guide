import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'fish.dart';
import 'villagers.dart';

class Crops extends StatefulWidget{
    const Crops({super.key, required String title});

    @override
    State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops>{
    String selectedValue = "All Crops";
    List _allCrops = [];    
    List _springCrops = [];
    List _summerCrops = [];
    List _fallCrops = [];
    List _specialCrops = [];
    List<Widget> widgetListBuy = [];

    Future<void> readJson() async {
      final String response = await rootBundle.loadString('assets/data/crops.json');
      final data = await json.decode(response);
      setState(() {
        _springCrops = data["spring"];
        _summerCrops = data["summer"];
        _fallCrops = data["fall"];
        _specialCrops = data["special"];
        makeAllCropsList();
      });
    }

    makeAllCropsList(){
      _allCrops += _springCrops;
      int matchCounter = 0;
      for(var item in _summerCrops){
        for(var crop in _allCrops){
          if(item["crop name"] == crop["crop name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allCrops.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _fallCrops){
        for(var crop in _allCrops){
          if(item["crop name"] == crop["crop name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allCrops.add(item);
        }
        matchCounter = 0;
      }
      for(var item in _specialCrops){
        for(var crop in _allCrops){
          if(item["crop name"] == crop["crop name"]){
            matchCounter++;
          }
        }
        if(matchCounter == 0){
          _allCrops.add(item);
        }
        matchCounter = 0;
      }
    }

    ListTile makeListTile(list, index) {
      return ListTile(
        leading: makeCropImage(list,index),
        title: Text(list[index]["crop name"], style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(list[index]["days to maturity"], style: Theme.of(context).textTheme.labelSmall),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    List<DropdownMenuItem<String>> get dropdownItems{
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(value: "All Crops",child: Text("All Crops", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Spring Crops",child: Text("Spring Crops", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Summer Crops",child: Text("Summer Crops", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Fall Crops",child: Text("Fall Crops", style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(value: "Special Crops",child: Text("Special Crops", style: Theme.of(context).textTheme.bodyMedium)),
      ];
      return menuItems;
    }

    Image makeCropImage(list, index){
      return Image.asset(list[index]["image"]);
    }

    makeQualityCropImage(list, index, img){
      if(img == null){
        return Padding(
        padding: const EdgeInsets.all(2.5),
        child: Stack(children: [
          Image.asset(list[index]["image"])
        ],),
      );
      } else{
        return Padding(
        padding: const EdgeInsets.all(2.5),
        child: Stack(children: [
          Image.asset(list[index]["image"]),
          Image.asset(img)
        ],),
      );
      }
    }

    Column listPrices(list, index){
      widgetListBuy.clear();
      for(var i = 0; i < list[index]["purchase price"].length; i++){
        widgetListBuy.add(Text(list[index]["purchase price"][i]["store"] + " - " + list[index]["purchase price"][i]["price"], style: Theme.of(context).textTheme.bodySmall));
      }
      return Column(children: widgetListBuy);
    }

    Container listUses(list, index){
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
                  child: Text("Sell",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
                ),
                Text("Energy",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
                Text("Health",textScaleFactor: 1, style: Theme.of(context).textTheme.bodyMedium),
              ]
            ),
            TableRow(
              children: [
                makeQualityCropImage(list, index, null),
                Text(list[index]["uses"][0]["sell price"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][0]["energy"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][0]["health"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityCropImage(list, index, "assets/images/Silver_Quality_Icon.png"),
                Text(list[index]["uses"][1]["sell price"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][1]["energy"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][1]["health"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityCropImage(list, index, "assets/images/Gold_Quality_Icon.png"),
                Text(list[index]["uses"][2]["sell price"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][2]["energy"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][2]["health"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
            TableRow(
              children: [
                makeQualityCropImage(list, index, "assets/images/Iridium_Quality_Icon.png"),
                Text(list[index]["uses"][3]["sell price"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][3]["energy"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
                Text(list[index]["uses"][3]["health"],textScaleFactor: 1, style: Theme.of(context).textTheme.bodySmall),
              ]
            ),
          ],
        ),
      );
    }

    AlertDialog buildPopupDialog(context, list, index){
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeCropImage(list, index),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(list[index]["crop name"], style: Theme.of(context).textTheme.bodyLarge),
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
              Row(
                children: [
                  Text("Seed Name: ", style: Theme.of(context).textTheme.bodyMedium),
                  Text("${list[index]['seed name']}", style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 3),
                child: Row(
                  children: [
                    Text("Days to Maturity: ", style: Theme.of(context).textTheme.bodyMedium),
                    Text("${list[index]['days to maturity']}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              
              list[index]["regrowth"] != "N/A"
                ? Row(
                  children: [
                    Text("Days to Regrow: ", style: Theme.of(context).textTheme.bodyMedium),
                    Text("${list[index]['regrowth']}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ) : Container(),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Purchase From:", style: Theme.of(context).textTheme.bodyMedium),
              ),
              listPrices(list, index),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: listUses(list, index),
              ),
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
              title: Text('Crops', style: Theme.of(context).textTheme.displayLarge),
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
                  
                  // Display the data loaded from crops.json
                  _allCrops.isNotEmpty && selectedValue == "All Crops"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _allCrops.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _allCrops, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_allCrops, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _springCrops.isNotEmpty && selectedValue == "Spring Crops"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _springCrops.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _springCrops, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_springCrops, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _summerCrops.isNotEmpty && selectedValue == "Summer Crops"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _summerCrops.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _summerCrops, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_summerCrops, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _fallCrops.isNotEmpty && selectedValue == "Fall Crops"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _fallCrops.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _fallCrops, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_fallCrops, index),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  _specialCrops.isNotEmpty && selectedValue == "Special Crops"
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _specialCrops.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => buildPopupDialog(context, _specialCrops, index),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.amber.shade100,
                                  child: makeListTile(_specialCrops, index),
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