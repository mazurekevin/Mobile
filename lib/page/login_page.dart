import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/current_user.dart';
import 'package:mobile/models/login.dart';
import 'package:mobile/page/nav_page.dart';
import 'package:mobile/page/regi_page.dart';
import 'package:mobile/utils/globale.dart' as g;


import '../service/service_user.dart';
import '../widgets/btn_widget.dart';
import '../widgets/herder_container.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();

  Login login = Login(username: "", password: "");
  CurrentUser? response;

  void _setText()async {
    setState(() {
      login.username = pseudoController.text;
      login.password = passwordController.text;
    });
    response = await ServiceUser().login(login);
    g.username = response?.username;
    if(response?.username==login.username){
      Navigator.push(context,
          MaterialPageRoute<void>(
              builder:(BuildContext context) {
                return NavePage(title: "title");
              }));
    }else{
      print("erreur");
    }

  }


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
                  _textInput(controller:pseudoController ,hint: "Pseudo", icon: Icons.person),
                  _textInput(controller:passwordController ,hint: "Password", icon: Icons.vpn_key),
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
                          _setText();
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegPage()));*/
                        },
                        btnText: "LOGIN",
                      ),
                    ),
                  ),
                  InkWell(
                    child:RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: "Registor",
                          style: TextStyle(color: Colors.blue),
                        ),

                      ]),

                    ) ,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute<void>(
                              builder:(BuildContext context) {
                                return RegPage();
                              }));
                    },
                  ),

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
