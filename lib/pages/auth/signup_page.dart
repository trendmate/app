import 'package:flutter/material.dart';
import 'package:trendmate/pages/auth/login_page.dart';
import 'package:trendmate/pages/auth/otp_page.dart';
import 'package:trendmate/pages/tabs_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/signup-page';
  // final Function addUser;

  // SignUpPage(this.addUser);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _submitData() {
    // print("Hello");
    final enteredName = _nameController.text;
    final enteredPhone = _phoneController.text;

    if (enteredName.isEmpty || enteredPhone.isEmpty) {
      return;
    }

    // print(enteredPhone);
    // print(enteredName);
    Navigator.pushReplacementNamed(context, OtpPage.routeName);
    // send phone for opt validation and save new user if valid
    // else display error
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
                  FlatButton(
                      // onPressed: () {
                      //   // send values to user_transactions.dart
                      //   // print(_nameController.text);
                      //   // print(_phoneController.text);
                      //   _submitData;
                      // },
                      onPressed: _submitData,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                  FlatButton(
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
