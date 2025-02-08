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
      appBar: AppBar(title: Text('Personal Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your age' : null,
                onSaved: (value) => _age = int.tryParse(value!),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Select your gender' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your height' : null,
                onSaved: (value) => _height = double.tryParse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter your weight' : null,
                onSaved: (value) => _weight = double.tryParse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Name: $_name, Age: $_age, Gender: $_gender, Height: $_height cm, Weight: $_weight kg');
                    navigateToHomePage(context);

                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
