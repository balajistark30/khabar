import 'package:flutter/material.dart';
import 'package:khabar/screens/login_screen.dart';

class onBoardingPage2 extends StatefulWidget {
  const onBoardingPage2({super.key});

  @override
  State<onBoardingPage2> createState() => _onBoardingPage2State();
}

class _onBoardingPage2State extends State<onBoardingPage2> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: screenheight * 0.6,
                    color: Colors.white,
                    child: Image.asset(
                        fit: BoxFit.cover, 'assets/onboardimages/img2.png'),
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.03,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Start your journey with khabar',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenheight * 0.009,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: screenheight * 0.03,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Adjust the radius as needed
                                  ),
                                  backgroundColor: Colors
                                      .blue, // Background color of the button
                                ),
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                      // Replace "Onboarding2" with the actual name of your next page widget
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Adjust the radius as needed
                                  ),
                                  backgroundColor: Colors
                                      .blue, // Background color of the button
                                ),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
