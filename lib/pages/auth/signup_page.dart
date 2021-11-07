import 'package:flutter/material.dart';
import 'package:trendmate/pages/auth/login_page.dart';
import 'package:trendmate/pages/auth/otp_page.dart';
import 'package:trendmate/services/firebase_methods.dart';
import 'package:trendmate/utils/utils.dart';
import 'package:trendmate/widgets/background.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/signup-page';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _submitData() {
    final enteredName = _nameController.text;
    final enteredPhone = _phoneController.text;

    if (enteredName.isEmpty || enteredPhone.isEmpty) {
      return;
    }

    FirebaseMethods.instance.phoneAuth(
        enteredPhone,
        (credential) => null,
        (e) => Utils.showToast("Error: $e"),
        (verificationId, resendToken) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpPage(
                      verId: verificationId,
                      name: enteredName,
                      phone: enteredPhone,
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          title: Text(
            "SignUp",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          )),
      body: Stack(
        children: [
          BackgroundImage(),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Name'),
                        controller: _nameController,
                        // makes sure that form was submitted when button got pressed
                        onSubmitted: (_) => _submitData(),
                        // onChanged: (val) {
                        //   titleInput = val;
                        // },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Phone No.'),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        // makes sure that form was submitted when button got pressed
                        onSubmitted: (_) => _submitData(),
                        // onChanged: (val) => amountInput = val,
                      ),
                      Center(
                        child: Container(
                          height: 200,
                          margin: EdgeInsets.only(bottom: 40, top: 40),
                          child: Image.asset(
                            'assets/images/clothes-rack.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            // onPressed: () {
                            //   // send values to user_transactions.dart
                            //   // print(_nameController.text);
                            //   // print(_phoneController.text);
                            //   _submitData;
                            // },
                            onPressed: () {
                              _submitData();
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(LoginPage.routeName),
                          child: Text(
                            "Already registered?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
