import 'package:flutter/material.dart';
import 'package:trendmate/pages/auth/otp_page.dart';
import 'package:trendmate/pages/auth/signup_page.dart';
import 'package:trendmate/pages/tabs_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login-page';
  // final Function addUser;

  // LoginPage(this.addUser);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();

  void _submitData() {
    final enteredPhone = _phoneController.text;

    if (enteredPhone.isEmpty) {
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
            "Login",
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
                    decoration: InputDecoration(labelText: 'Phone No.'),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    // makes sure that form was submitted when button got pressed
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) => amountInput = val,
                  ),
                  FlatButton(
                      onPressed: _submitData,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                  FlatButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(SignUpPage.routeName),
                      child: Text("New user?")),
                ],
              )),
        ),
      ),
    );
  }
}
