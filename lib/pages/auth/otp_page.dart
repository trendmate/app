import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:trendmate/pages/tabs_page.dart';
import 'package:trendmate/services/firebase_methods.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    Key? key,
    required this.verId,
    this.name,
    this.phone,
    this.uid,
  }) : super(key: key);
  static const routeName = '/otp-page';

  final String verId;
  final String? name;
  final String? phone;
  final String? uid;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white30,
          elevation: 0,
          title: Text(
            "Otp Verification",
            style: TextStyle(color: Colors.black, fontSize: 21),
          )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          'Enter 6 digits verification code sent to your number',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        otpNumberWidget(0),
                        otpNumberWidget(1),
                        otpNumberWidget(2),
                        otpNumberWidget(3),
                        otpNumberWidget(4),
                        otpNumberWidget(5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              constraints: const BoxConstraints(maxWidth: 500),
              child: ElevatedButton(
                onPressed: () {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verId, smsCode: text);
                  FirebaseAuth.instance.signInWithCredential(credential).then(
                      (value) => widget.name == null
                          ? Navigator.of(context)
                              .pushReplacementNamed(TabsPage.routeName)
                          : FirebaseMethods.instance
                              .signUp(widget.name!, widget.phone!, widget.uid!)
                              .then((value) => Navigator.of(context)
                                  .pushReplacementNamed(TabsPage.routeName)));
                },
                style: ButtonStyle(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(14))
                    //     ),
                    ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Theme.of(context).primaryColor,
              rightIcon: Icon(
                Icons.backspace,
                color: Theme.of(context).primaryColor,
              ),
              rightButtonFn: () {
                setState(() {
                  text = text.substring(0, text.length - 1);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
