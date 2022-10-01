import 'package:flutter/material.dart';


import '../widgets/btn_widget.dart';
import '../widgets/herder_container.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: <Widget>[
          HeaderContainer("Login"),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _textInput(hint: "Email", icon: Icons.email),
                  _textInput(hint: "Password", icon: Icons.vpn_key),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "Forgot Password?",
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ButtonWidget(
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        btnText: "LOGIN",
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "Registor",
                          style: TextStyle(color: Colors.blue)),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
    );
  }
  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}