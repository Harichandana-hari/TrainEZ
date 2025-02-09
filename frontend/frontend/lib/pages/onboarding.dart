import 'package:flutter/material.dart';
import 'package:train_ez/pages/loginsignuppage.dart';

void clickBtn() {
  
}


class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
      
    //   appBar: AppBar(
    //     //title: Text('Onboarding'),
        
    //   ),
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           //Icon(),
    //           SizedBox(),
    //           Text(
    //             'Welcome to the App',
    //             style: TextStyle(),
    //           ),
    //           SizedBox(height: 20,),

    //           Text(
    //             'Fitness Perfecter',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(),
    //           ),
    //           SizedBox(height: 30,),

    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => LoginSignupPage(),
    //               ),
    //             );
    //             },
                
    //             child: Text('Get Started'))
    //         ],
    //       ),
    //     ),
    //   )
      
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      // ),
      home: Scaffold(
        body: ListView(children: [
          AndroidCompact1(),
        ]),
      ),
    );
  }
}

class AndroidCompact1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 55,
                top: 38,
                child: Container(
                  width: 345,
                  height: 342,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Vector.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 103,
                top: 732,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to AndroidCompact2 (replace with your actual page)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginSignupPage()), // Make sure this is the right page
                    );
                  },
                child: Container(
                  width: 205,
                  height: 77,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 205,
                          height: 77,
                          decoration: ShapeDecoration(
                            color: Color(0xFF090814),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(69),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 42,
                        top: 28,
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
              Positioned(
                left: 82,
                top: 104,
                child: Container(
                  width: 289,
                  height: 229,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 289,
                          height: 229,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 23,
                                top: 8,
                                child: Container(
                                  width: 225,
                                  height: 219,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 289,
                                  height: 229,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/Logo.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -38,
                top: 182,
                child: Container(
                  width: 530,
                  height: 530,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/TrainEZ.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}