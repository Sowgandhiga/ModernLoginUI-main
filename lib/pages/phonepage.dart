import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                'Enter your phone number',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: countryCode,
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) {
                          phone = val;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Phone"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryCode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          PhonePage.verify = verificationId;
                          Navigator.pushNamed(context, "otp");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text(
                      'Send the code',
                      style:
                          TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 60, 20, 74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
