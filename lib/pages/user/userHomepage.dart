import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHomepage extends StatelessWidget {
  final String uid; // The authenticated user's UID

  const UserHomepage({required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
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

          // If deviceID exists, proceed to show device status
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('status')
                .doc('latest')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading device status'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('No device status available'));
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;
              final status = data['status'] as String? ?? 'Unknown';
              final signal = data['signal'] as num? ?? 0;
              final battery = data['battery'] as num? ?? 0;
              final humidity = data['humidity'] as num? ?? 0;
              final temp = data['temp'] as num? ?? 0;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wide Device Status Card
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Device Status',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  status != 'Unknown' ? Icons.check_circle : Icons.error,
                                  size: 28,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Status: $status',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.signal_cellular_alt, size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Signal: $signal%',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.battery_full, size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Battery: $battery%',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Two Square Cards for Time Remaining and Conditions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Time Remaining Card
                        _buildSquareCard(
                          context,
                          'Time Remaining',
                          status.contains('In Use') ? '5 Hours' : 'N/A',
                          Icons.timer,
                        ),
                        const SizedBox(width: 10),
                        // Conditions Card
                        _buildSquareCard(
                          context,
                          'Conditions',
                          'Temp: $temp°F\nHumidity: $humidity%',
                          Icons.thermostat,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSquareCard(BuildContext context, String title, String value, IconData icon) {
    // Calculate the width of each card (half the screen width minus padding and spacing)
    final cardWidth = (MediaQuery.of(context).size.width - 16 * 2 - 10) / 2;
    const cardHeight = 150.0; // Fixed height for square cards

    return SizedBox(
      width: cardWidth,
      height: cardHeight, // Fixed height to make it square
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent title overflow
                    ),
                  ),
                  Icon(icon, size: 20), // Reduced icon size to prevent overflow
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2, // Limit to 2 lines to prevent overflow
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}