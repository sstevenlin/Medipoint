import 'package:flutter/material.dart';
import 'appointmentdetails.dart';
import 'schedulepage.dart';
import 'patient.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({super.key, required this.patient});
  final Patient patient;

  @override
  State<PersonalInfo> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<PersonalInfo> {
  String fname = '';
  int _currentIndex = 1;
  String lname = '';
  int month = 1;
  int day = 1;
  int year = 2000;
  String desc = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            SizedBox(height: 40),
            Text('First Name:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                onChanged: (value) {
                  fname = value;
                },
                controller: TextEditingController()),
            SizedBox(height: 10),
            Text('Last Name:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                onChanged: (value) {
                  lname = value;
                },
                controller: TextEditingController()),
            SizedBox(height: 30),
            Text('Enter your birthdate below:'),
            Text('Month:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                onChanged: (value) {
                  month = int.parse(value);
                },
                controller: TextEditingController()),
            Text('Day:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                onChanged: (value) {
                  day = int.parse(value);
                },
                controller: TextEditingController()),
            Text('Year of Birth:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                onChanged: (value) {
                  year = int.parse(value);
                },
                controller: TextEditingController()),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          _navigateToPage(value, context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personal Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Appointment Details",
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalInfo(patient: widget.patient)));
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SchedulePage(patient: widget.patient)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppointmentDetails(patient: widget.patient)));
        break;
    }
  }
}
