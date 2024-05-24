import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcomepage extends StatelessWidget{

  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: [
           Image(
             fit: BoxFit.cover,
               height: double.infinity,
               width: double.infinity,
               image:AssetImage('assets/images/welcomePage.jpg') ),
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
               )
             ),

           ),
           Align(
             alignment: Alignment.center,
             child: Image(
               height: 300,
               width: 300,
               image: AssetImage('assets/images/logo(final).png'),
             ),
           ),
         ],
       ),
     );
  }

}