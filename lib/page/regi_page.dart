import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/models/register.dart';
import 'package:mobile/page/login_page.dart';

import '../service/service_user.dart';
import '../widgets/btn_widget.dart';
import '../widgets/herder_container.dart';
import 'package:http/http.dart' as http;

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}


class _RegPageState extends State<RegPage> {
  final pseudoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Register register = Register(username: '', email: '', password: '');

  Future<void> _setText() async {
    setState(() {
      register.username = pseudoController.text;
      register.email = emailController.text;
      register.password = passwordController.text;
    });
    var response = await ServiceUser().createUser(register);
    if(response == 200){
      Navigator.push(context,
          MaterialPageRoute<void>(
              builder:(BuildContext context) {
                return LoginPage();
              }));
    }else{
      print("erreur");
    }



  }



    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),

        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(controller:pseudoController ,hint: "Pseudo", icon: Icons.person),
                    _textInput(controller:emailController,hint: "Email", icon: Icons.email),
                    _textInput(controller:passwordController,hint: "Password", icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: (){
                            _setText();
                            //print("object");
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child:RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Already a member ? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.blue)),
                        ]),
                      ) ,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder:(BuildContext context) {
                                  return LoginPage();
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
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