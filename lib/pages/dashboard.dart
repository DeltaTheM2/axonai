import 'package:axonai/firebase/authentication.dart';
import 'package:axonai/pages/historyPage.dart';
import 'package:axonai/pages/homepage.dart';
import 'package:axonai/pages/settingsPage.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedPageIndex = 0;
  List<Widget> pages = [
    HomePage(uid: AuthenticationHelper().uid),
    HistoryPage(uid: AuthenticationHelper().uid,),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SoleFresh"),
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index){
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon:Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
          NavigationDestination(icon:Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }
}