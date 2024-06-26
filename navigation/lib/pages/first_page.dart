import 'package:flutter/material.dart';
import 'package:navigation/pages/home_page.dart';
import 'package:navigation/pages/profile_page.dart';
import 'package:navigation/pages/setting_page.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  void _navigatedBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    ProfilePages(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "1st Page",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),

      /*
      // Navigator on side left
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 107, 155, 238),
        child: Column(
          children: [
            // common to place a drawer header here
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                color: Colors.white70,
                size: 48,
              ),
            ),
            ListTile(
              iconColor: Colors.white70,
              textColor: Colors.white,
              leading: Icon(Icons.home),
              title: Text("H O M E"),
              onTap: (){
                //pop drawer first
                Navigator.pop(context);
                //go to home page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
             ListTile(
              iconColor: Colors.white70,
              textColor: Colors.white,
              leading: Icon(Icons.settings),
              title: Text("S E T T I N G"),
              onTap: (){
                Navigator.popAndPushNamed(context, '/settingpage');
              },
            )
          ],
        ),
      ),*/
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          //home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          //profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          //setting
          //profile
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _navigatedBottomBar,
      ),
      /*
      body: Center(
        child: ElevatedButton(
          child: Text("Go To Second Page"),
          onPressed: () {
            //Navigation to second page
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));
            Navigator.pushNamed(context, '/secondpage');
          },
        ),
      ),*/
    );
  }
}
