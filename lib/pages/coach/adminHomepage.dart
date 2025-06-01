import 'package:axonai/firebase/authentication.dart';
import 'package:axonai/main.dart';
import 'package:axonai/pages/coach/gameListAdmin.dart';
import 'package:axonai/pages/coach/userForm.dart';
import 'package:axonai/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    AuthenticationHelper().isAdmin = false;
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: EventListAdmin()),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: EventApp.accentColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventForm()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        label: Text('Add Event', style: TextStyle(color: EventApp.surfaceColor),),
        icon: Icon(Icons.event, color: EventApp.surfaceColor,),
      ),
    );
  }
}