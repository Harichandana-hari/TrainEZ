import 'package:flutter/material.dart';
import 'package:train_ez/pages/camera.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExerciseListPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFFE924A),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  final List<Map<String, String>> workoutPlans = [
    {
      'title': 'Weight Loss',
      'image': 'assets/weight-loss.jpg', // Replace with actual asset
    },
    {
      'title': 'Weight Gain',
      'image': 'assets/weight_gain.jpg',
    },
    {
      'title': 'Strength Training',
      'image': 'assets/strength.jpg',
    },
    {
      'title': 'Tone body',
      'image': 'assets/weight_gain.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Workout Plans',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'RaleWay',
              fontWeight: FontWeight.bold,
            ),
          
          ),
        backgroundColor: Color(0xFFFE924A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
        
        ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: workoutPlans.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 150, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(workoutPlans[index]['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(0, 0, 0, 0.4), // Dark overlay
                ),
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                  workoutPlans[index]['title']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                  ),
                ),

                  ),
                
              ),
            );
          },
        ),
      ),
    );
  }
}



class ExerciseListPage extends StatelessWidget {
  final List<Map<String, String>> exercises = [
    {
      'title': 'Push-Ups', 
      'image': 'assets/pushups.jpg'
    },
    {
      'title': 'Squats',
       'image': 'assets/squat.jpg'
      },
    {
      'title': 'Jumping',
       'image': 'assets/jumping.jpg'
    },
    {
      'title': 'Lunges',
       'image': 'assets/lunges.jpg'
    },
    {
      'title': 'Planks',
       'image': 'assets/plank.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
          title: Text(
            'Exercises',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          
          ),
        
        
        
        backgroundColor: Color(0xFFFE924A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
        
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen()
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(exercises[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    exercises[index]['title']!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'RaleWay',
              fontWeight: FontWeight.bold,
            ),
          
          ),
        backgroundColor: Color(0xFFFE924A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
        
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/download.png'), // Replace with your asset
            ),
            SizedBox(height: 10),
            Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('johndoe@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

  