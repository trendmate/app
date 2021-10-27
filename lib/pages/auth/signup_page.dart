import 'package:flutter/material.dart';
import 'package:trendmate/pages/auth/login_page.dart';
import 'package:trendmate/pages/auth/otp_page.dart';
import 'package:trendmate/services/firebase_methods.dart';
import 'package:trendmate/utils/utils.dart';

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
          backgroundColor: Colors.white30,
          elevation: 0,
          title: Text(
            "SignUp",
            style: TextStyle(color: Colors.black, fontSize: 21),
          )),
      body: GestureDetector(
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
                  ElevatedButton(
                      // onPressed: () {
                      //   // send values to user_transactions.dart
                      //   // print(_nameController.text);
                      //   // print(_phoneController.text);
                      //   _submitData;
                      // },
                      onPressed: _submitData,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName),
                      child: Text("Already registered?")),
                ],
              )),
        ),
      ),
    );
  }
}
