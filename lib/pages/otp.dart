import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/phonepage.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    var code = "";

    void showErrorMsg() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 60, 20, 74),
            title: Center(
              child: Text(
                "Incorrect OTP",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black)),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/phoneicon.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter OTP',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (val) {
                  code = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PhonePage.verify,
                                smsCode: code);
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "home", (route) => false);
                      } catch (e) {
                        showErrorMsg();
                      }
                    },
                    child: Text(
                      'Verify phone number',
                      style:
                          TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 60, 20, 74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'phonepage', (route) => false);
                      },
                      child: Text('Edit Phone Number?',
                          style: TextStyle(color: Colors.black)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
