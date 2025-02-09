import 'package:flutter/material.dart';
import 'package:train_ez/pages/bottomnavscreen.dart';

void navigateToHomePage(context){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BottomNavScreen(),
    ),
  );
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;
  String? _gender;
  double? _height;
  double? _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color(0xFFFE924A), // Set background color
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom
  ),
  title: Padding(
    padding: const EdgeInsets.only(top: 20), // Add top padding
    child: Text(
      'Personal Information',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  centerTitle: true, // Ensure title is centered
  toolbarHeight: 80, // Optional: Increase AppBar height
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centers vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your age' : null,
                onSaved: (value) => _age = int.tryParse(value!),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                items: ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Select your gender' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your height' : null,
                onSaved: (value) => _height = double.tryParse(value!),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your weight' : null,
                onSaved: (value) => _weight = double.tryParse(value!),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Name: $_name, Age: $_age, Gender: $_gender, Height: $_height cm, Weight: $_weight kg');
                    navigateToHomePage(context);

                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                    ),
                  
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
