import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For timestamp formatting

class HistoryPage extends StatelessWidget {
  final String uid; // The authenticated user's UID

  const HistoryPage({required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        }
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if user document exists and has a non-null deviceID
        final userData = userSnapshot.data?.data() as Map<String, dynamic>?;
        final deviceID = userData?['deviceID'];

        if (deviceID == null) {
          return const Center(
            child: Text(
              'No paired devices',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        // If deviceID exists, proceed to show history
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('history')
              .orderBy('timestamp', descending: true) // Newest first
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading history'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final sessions = snapshot.data!.docs;

            if (sessions.isEmpty) {
              return const Center(
                child: Text(
                  'No sessions found',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index].data() as Map<String, dynamic>;
                final timestamp = session['timestamp'] as int;
                final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
                final formattedDate = DateFormat.yMMMd().add_jm().format(date);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date and Time
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Session Details
                        _buildDetailRow('Max Temperature', '${session['maxTemp']} °F'),
                        _buildDetailRow('Max Humidity', '${session['maxHumidity']} %'),
                        _buildDetailRow('Elapsed Time', '${session['elapsedTime']} s'),
                        _buildDetailRow('Battery Drained', '${session['batteryDrained']} %'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}