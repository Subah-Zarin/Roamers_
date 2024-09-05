import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSending = false;
  bool sentSuccessfully = false;
  String errorMessage = '';

  void sendPasswordResetEmail() async {
    String email = emailController.text.trim();
    setState(() {
      isSending = true;
      sentSuccessfully = false;
      errorMessage = '';
    });

    try {
      await _auth.sendPasswordResetEmail(email: email);
      setState(() {
        sentSuccessfully = true;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        errorMessage = 'Failed to send reset link. Please check the email address.';
      });
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot your password? No worries!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enter your email address below and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.email_outlined, color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSending ? null : sendPasswordResetEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: isSending
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 10),
                  Text('Please wait for a few seconds', style: TextStyle(color: Colors.white)),
                ],
              )
                  : Text('Send Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),),
            ),
            SizedBox(height: 20),
            if (sentSuccessfully)
              Text(
                'Password reset link sent! Check your email.',
                style: TextStyle(color: Colors.green, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
