import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 50; 
  Color petColor = Colors.yellow;
  String mood = "Neutral";
  final TextEditingController _nameController = TextEditingController();
  Timer? _hungerTimer;

  @override
  void initState() {
    super.initState();
    _hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel += 5;
        if (hungerLevel > 100) {
          hungerLevel = 100;
          happinessLevel -= 10;
          if (happinessLevel < 0) happinessLevel = 0;
        }
        _updatePetColorAndMood();
      });
    });
  }

  @override
  void dispose() {
    _hungerTimer?.cancel();
    super.dispose();
  }

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      energyLevel -= 5; 
      if (happinessLevel > 100) happinessLevel = 100;
      if (energyLevel < 0) energyLevel = 0;
      _updateHunger();
      _updatePetColorAndMood();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      energyLevel += 3;
      if (hungerLevel < 0) hungerLevel = 0;
      if (energyLevel > 100) energyLevel = 100;
      _updateHappiness();
      _updatePetColorAndMood();
    });
  }

  void _setPetName() {
    setState(() {
      if (_nameController.text.isNotEmpty) {
        petName = _nameController.text;
      }
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
    });
  }

  void _updatePetColorAndMood() {
    if (happinessLevel > 70) {
      petColor = Colors.green;
      mood = "Happy";
    } else if (happinessLevel >= 30) {
      petColor = Colors.yellow;
      mood = "Neutral";
    } else {
      petColor = Colors.red;
      mood = "Unhappy";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Pet Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _setPetName,
              child: Text('Set Name'),
            ),
            SizedBox(height: 16.0),
            Icon(
              Icons.pets,
              size: 100,
              color: petColor,
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mood: $mood',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            
            SizedBox(height: 16.0),
            Text(
              'Energy Level: $energyLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}