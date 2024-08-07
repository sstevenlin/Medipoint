import 'package:flutter/material.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'schedulepage.dart';
import 'loginError.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key, required this.title});
  final String title;

  @override
  State<LogIn> createState() => _Login();
}

class _Login extends State<LogIn> {
  String inputEmail = '';
  String inputPassword = '';

  Future<void> checkCredentials() async {
    // Implement your logic to check credentials
  }

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDB().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'TimesNewRoman',
              fontSize: 17,
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/hospitalbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    const Text(
                      "Enter your email:",
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    const Text(
                      'Enter your password:',
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'TimesNewRoman',
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        print(dbHelper.loginPatient('email', 'password'));
                        int response =
                            dbHelper.loginPatient(inputEmail, inputPassword);
                        Patient patient =
                            dbHelper.getPatient(inputEmail, inputPassword);
                        if (response == -1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SchedulePage(patient: patient)),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LogInError(title: '')),
                          );
                        }

                        //Check to see if credentials match database
                      },
                    ),
                  ]),
            )));
  }
}
