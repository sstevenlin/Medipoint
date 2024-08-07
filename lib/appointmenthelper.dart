import 'dart:async';
import 'package:path/path.dart';
import 'main.dart';
import 'package:sqflite/sqflite.dart';
import 'patient.dart';
import 'appointments.dart';

class AppointmentHelper {
  static final AppointmentHelper _databaseHelper = AppointmentHelper._();

  AppointmentHelper._();

  late Database db;

  factory AppointmentHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'medipoint.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE appointments (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              patient INT NOT NULL FOREIGN KEY, 
              startTime INT NOT NULL,
              endTime INT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
    print(path);
  }

  int startTime(DateTime date) {
    DateTime newtime = DateTime(date.year, date.month, date.day, 9);
    return newtime.millisecondsSinceEpoch;
  }

  int endTime(DateTime date) {
    DateTime newTime = DateTime(date.year, date.month, date.day, 17);
    return newTime.millisecondsSinceEpoch;
  }

  int appointmentDuration() {
    return new Duration(minutes: 30).inMilliseconds;
  }

  // List<Appointment> getAvailableAppointments(int start, int end) {
  //   List<Appointment> availableList;
  //   for(int x = start; x < end; x += appointmentDuration()) {
  //     bool isValid = true;
  //     for(Appointment )
  //   }
  // }

  Future<int> insertAppointment(int patient, int startTime) async {
    Appointment newAppointment = Appointment(
        patient: patient,
        startTime: startTime,
        endTime: startTime + appointmentDuration() - 1);
    return db.insert('appointments', newAppointment.toMap());
  }

  Future<int> updatePatient(Patient patient) async {
    int result = await db.update(
      'patients',
      patient.toMap(),
      where: "id = ?",
      whereArgs: [patient.id],
    );
    return result;
  }

  Future<List<Patient>> retrieveAppointments() async {
    final List<Map<String, Object?>> queryResult = await db.query('patients');
    return queryResult.map((e) => Patient.fromMap(e)).toList();
  }

  Future<void> deletePatient(int id) async {
    await db.delete(
      'patients',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Patient getPatient(String email, String password) {
    Patient patient = new Patient(name: '', email: '', password: '');
    this.retrieveAppointments().then(
      (value) {
        value.forEach(
          (element) {
            if (element.email == email && element.password == password) {
              patient = element;
            }
          },
        );
      },
    );
    return patient;
  }
}
