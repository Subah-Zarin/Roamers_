import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registrationC.dart';

class registration extends StatelessWidget {
  final RegistrationController c = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/images/bg2.jpg'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: c.email,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          labelText: 'Email Address',
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: c.username,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          labelText: 'Username',
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Obx(() => TextField(
                        controller: c.password,
                        obscureText: !c.isPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              c.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              c.isPasswordVisible.value = !c.isPasswordVisible.value;
                            },
                          ),
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                      )),
                    ),

                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Obx(() => TextField(
                        controller: c.confirmPassword,
                        obscureText: !c.isConfirmPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              c.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              c.isConfirmPasswordVisible.value = !c.isConfirmPasswordVisible.value;
                            },
                          ),
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                      )),
                    ),

                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        await c.registerUser();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),
                        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                      ),
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '-----------',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            'Or Sign Up With',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '-----------',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            c.registerWithGoogle();
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff484848),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.g_mobiledata,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            c.registerWithApple();
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff484848),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.apple,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            c.registerWithFacebook();
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff484848),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.facebook,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0, top: 25),
                      child: Row(
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('login');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
