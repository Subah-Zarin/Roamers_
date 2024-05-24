import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcomepage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/images/welcomePage.jpg'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.15),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  height: 300,
                  width: 300,
                  image: AssetImage('assets/images/logo(final).png'),
                ),
                SizedBox(height: 20), // Add some spacing between the logo and the button
                ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Text("Let's Go"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                    textStyle: TextStyle(fontSize: 16), // Button text style
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
