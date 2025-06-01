import 'dart:io';
import 'package:axonai/main.dart';
import 'package:flutter/material.dart';


class AdminResources extends StatelessWidget {
  const AdminResources({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Instructor Guide
          Container(
            height: 150,
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () async {
                // Show a SnackBar so the user knows a download is in progress.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading...')),
                );
                const fileName = 'Instructor Guide.pdf';
                const folder = 'Admin';
                const fileUrl =
                    'https://firebasestorage.googleapis.com/v0/b/fin-mentor.firebasestorage.app/o/Admin%2FInstructor%20Guide.pdf?alt=media&token=b1cd5163-2b16-41fb-a5ab-df232e64930b';

                // Hide the SnackBar once download is complete.
                ScaffoldMessenger.of(context).hideCurrentSnackBar();


              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructor Guide",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: EventApp.surfaceColor,
                            ),
                          ),
                          Text(
                            "Your handbook for the next chapter.",
                            style: TextStyle(
                              fontSize: 15,
                              color: EventApp.surfaceColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: EventApp.surfaceColor,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Slides
          Container(
            height: 150,
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading...')),
                );
                const fileName = 'Slides.pdf';
                const folder = 'Admin';
                const fileUrl =
                    'https://firebasestorage.googleapis.com/v0/b/fin-mentor.firebasestorage.app/o/Admin%2FSlides.pdf?alt=media&token=cceaeab3-6651-4421-a972-db16fb349401';

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructor Slides",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: EventApp.surfaceColor,
                            ),
                          ),
                          Text(
                            "Get ready for the next class.",
                            style: TextStyle(
                              fontSize: 15,
                              color: EventApp.surfaceColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: EventApp.surfaceColor,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}