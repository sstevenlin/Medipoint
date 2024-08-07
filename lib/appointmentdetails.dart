import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'appointmentdetails.dart';
import 'schedulepage.dart';
import 'patient.dart';
import 'personalinfo.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({super.key, required this.patient});
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
  final Patient patient;
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  List<String> appointments = [];
  int _currentIndex = 1;
  @override
  void initState() {
    super.initState();
    fetchAppointments(); // fetch the appointments from backend
  }

  Future<void> fetchAppointments() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appointments[index]),
              );
            },
          ),
        ],
      ),
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
