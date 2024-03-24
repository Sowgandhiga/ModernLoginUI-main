import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modernlogintute/pages/loginreg.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 60, 20, 74),
              const Color.fromARGB(255, 95, 65, 103),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/logo.png',
                      width: 200,
                      height: 200,
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Compare, Choose, Cruise',
                      style: TextStyle(
                          fontFamily: "inter",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 192, 192, 192)),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginReg()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 192, 192, 192)),
                      child: Text('Getting Started',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse('https://rideradar.netlify.app/'));
                      },
                      child: Text(
                        'By using Ride Radar, you agree to our terms and privacy conditions.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 192, 192, 192),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
