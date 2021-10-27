import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendmate/pages/auth/otp_page.dart';
import 'package:trendmate/pages/auth/signup_page.dart';
import 'package:trendmate/pages/tabs_page.dart';
import 'package:trendmate/services/firebase_methods.dart';
import 'package:trendmate/utils/utils.dart';

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

    FirebaseMethods.instance.phoneAuth(enteredPhone, (credential) {
      FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
          Navigator.pushReplacementNamed(context, TabsPage.routeName));
    },
        (e) => Utils.showToast("Error sending OTP"),
        (verificationId, resendToken) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpPage(verId: verificationId))));
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
      body: SingleChildScrollView(
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
                  onSubmitted: (_) => _submitData(),
                ),
                ElevatedButton(
                    onPressed: _submitData,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(SignUpPage.routeName),
                    child: Text("New user?")),
              ],
            )),
      ),
    );
  }
}
