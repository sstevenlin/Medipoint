import 'package:flutter/material.dart';
import 'userhelper.dart';
import 'patient.dart';
import 'schedulepage.dart';

class NewAccountError extends StatefulWidget {
  const NewAccountError({super.key, required this.title});
  final String title;

  @override
  State<NewAccountError> createState() => _NewAccounError();
}

class _NewAccounError extends State<NewAccountError> {
  late DatabaseHelper dbHelper;
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text("ERROR - Email already in use! Please try again.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 40),
                SizedBox(height: 40),
                Text("Enter your name:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    onChanged: (value) => userName = value,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text("Enter your email:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    onChanged: (value) => userEmail = value,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text('Enter your password:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    onChanged: (value) => userPassword = value,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Password',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        )),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () {
                    // Patient newPatient = Patient(
                    //     name: 'sample patient',
                    //     email: email,
                    //     password: password);
                    // dbHelper.retrievePatients().then(
                    //       (value) => value.forEach((e) => print(e.toMap())),
                    //     );
                    if (dbHelper.loginPatient(userEmail, userPassword) != -1) {
                      Patient newPatient = Patient(
                          name: userName,
                          email: userEmail,
                          password: userPassword);
                      dbHelper.insertPatient(newPatient);

                      dbHelper.retrievePatients().then(
                            (value) => value.forEach((e) => print(e.toMap())),
                          );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SchedulePage(patient: newPatient),
                          ));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NewAccountError(title: '')),
                      );
                    }

                    //check to see if credentials match database
                  },
                ),
              ]),
        ));
  }
}
