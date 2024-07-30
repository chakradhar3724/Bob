import 'package:flutter/material.dart';
import 'booking_screen.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to send verification code
              },
              child: Text('Send Code'),
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to verify code
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScreen()),
                );
              },
              child: Text('Verify and Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
