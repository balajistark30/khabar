import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khabar/screens/forgot_password_screen.dart';
import 'package:khabar/screens/onboarding_screen2.dart';
import 'package:khabar/screens/signup_screen.dart';

import '../views/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scaffoldMessengerKey.currentState != null) {
        _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      onBoardingPage2(), // Replace with your login screen widget
                ),
              );
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: screenheight * 0.3,
                  width: 100,
                  child: Column(
                    children: [
                      Image.asset('assets/logo/khabarlogo.jpg'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()));
                      // Navigate to the "Forgot Password" screen or show a dialog for password reset.
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  onPressed: () async {
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    } catch (e) {
                      _showErrorSnackBar("Email or password is incorrect");
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                Text('Or continue with'),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text color
                  ),
                  onPressed: () {
                    signInWithGoogle();
                    // Handle Google login
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(50), // Same radius as above
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo/google_logo.png',
                              height: 25, width: 25),
                          SizedBox(width: 8),
                          Text('Login with Google'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                            // Replace "Onboarding2" with the actual name of your next page widget
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
