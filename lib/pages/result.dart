import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:modernlogintute/pages/boxes.dart';
import 'package:modernlogintute/pages/homepage.dart';
import 'package:modernlogintute/pages/output.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int? selectedIndex;
  List<dynamic> locdata = [];
  bool showData = false;

  Future<dynamic> fetchData(pickup, dropoff) async {
    var apiUrl = 'https://cabcompare.pythonanywhere.com/cab/$pickup/$dropoff';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Request was successful
        return (response.body);
      }
    } catch (e) {
      // An error occurred during the request
      return '$e';
    }
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: logoutUser, icon: Icon(Icons.logout))
      ]),
      backgroundColor: const Color.fromARGB(255, 60, 20, 74),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: boxLocation.length,
                        itemBuilder: (context, index) {
                          Output output = boxLocation.getAt(index);
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pickup: ${output.pickup}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Drop: ${output.drop}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // When a ListTile is tapped, store the index in a variable
                              setState(() {
                                selectedIndex = index;
                                showData =
                                    false; // Reset showData when a new item is selected
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: selectedIndex != null
                      ? () async {
                          // Store selectedIndex in a local variable
                          int index = selectedIndex!;
                          Output output = boxLocation.getAt(index);
                          var pickup = output.pickup;
                          var drop = output.drop;

                          // Fetch data from the API
                          var response = await fetchData(pickup, drop);

                          setState(() {
                            locdata.clear(); // Clear previous data
                            locdata
                                .add(json.decode(response)); // Add fetched data
                            showData = true; // Show data after fetching
                          });
                        }
                      : null, // Disable button if no index is selected
                  child: Text(showData ? "" : "Show"),
                ),
              ),
              if (showData)
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Result',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        json.encode(locdata.first),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      boxLocation.clear();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Home Page'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
