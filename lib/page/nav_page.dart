import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/page/home_page.dart';
import 'package:mobile/page/profile_page.dart';

class NavePage extends StatefulWidget {
  NavePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NavePage> createState() => _HomeState();
}

class _HomeState extends State<NavePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const ProfilePage(),
  ];

  String get title => widget.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          title: Text(_currentIndex == 0 ? 'Home': 'Profile')//const Text("Je suis le titre")
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onClicked,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
        ],
      ),
    );
  }

  void onClicked(int newIndex){
    setState((){

    });

    _currentIndex = newIndex;
    print('Clicked on $newIndex');
  }
}