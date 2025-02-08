import 'package:flutter/material.dart';
import 'package:train_ez/pages/loginsignuppage.dart';

void clickBtn() {
  
}


class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        //title: Text('Onboarding'),
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Icon(),
              SizedBox(),
              Text(
                'Welcome to the App',
                style: TextStyle(),
              ),
              SizedBox(height: 20,),

              Text(
                'Fitness Perfecter',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginSignupPage(),
                  ),
                );
                },
                
                child: Text('Get Started'))
            ],
          ),
        ),
      )
      
    );
  }
}