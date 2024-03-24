// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/boxes.dart';
import 'package:modernlogintute/pages/output.dart';
import 'result.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  final _pickupController = TextEditingController();
  final _destController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: logoutUser, icon: Icon(Icons.logout))
      ]),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Compare, Choose, Cruise',
                    style: TextStyle(
                      fontFamily: "inter",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _pickupController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 60, 20, 74)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Pick-Up Location',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      )),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _destController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 60, 20, 74)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Drop Location',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      )),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            boxLocation.put(
                              'key_${_pickupController.text}',
                              Output(
                                  pickup: _pickupController.text,
                                  drop: _destController.text),
                            );
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Result()),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ))),
                      )),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
