import 'package:axonai/firebase/authentication.dart';
import 'package:axonai/pages/loginPage.dart';
import 'package:axonai/pages/user/userHistoryPage.dart';
import 'package:axonai/pages/user/userHomepage.dart';
import 'package:axonai/pages/user/userSettingsPage.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0; // Track the selected index for navigation

  final List<Widget> _pageWidgets = [
    UserHomepage(uid: AuthenticationHelper().uid),
    UserHistoryPage(),
    UserSettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index to show the page
    });
  }

  void _logout(BuildContext context) async {
    await AuthenticationHelper().signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Axon AI',
        )
      ),
      body: _pageWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}