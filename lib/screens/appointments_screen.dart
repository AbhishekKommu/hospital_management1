import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../widgets/app_background.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() =>
      _AppointmentsScreenState();
}

class _AppointmentsScreenState
    extends State<AppointmentsScreen> {
  final List<Appointment> appointments = [
    Appointment(
      id: 1,
      patientName: 'Rahul Kumar',
      doctorName: 'Dr. Ramesh',
      time: '10:00 AM',
    ),
    Appointment(
      id: 2,
      patientName: 'Priya Sharma',
      doctorName: 'Dr. Sneha',
      time: '11:30 AM',
    ),
    Appointment(
      id: 3,
      patientName: 'Arun Kumar',
      doctorName: 'Dr. Anand',
      time: '02:00 PM',
    ),
  ];

  final patientController = TextEditingController();
  final doctorController = TextEditingController();
  final timeController = TextEditingController();

  void addAppointment() {
    if (patientController.text.isEmpty ||
        doctorController.text.isEmpty ||
        timeController.text.isEmpty) {
      return;
    }

    setState(() {
      appointments.add(
        Appointment(
          id: appointments.length + 1,
          patientName: patientController.text,
          doctorName: doctorController.text,
          time: timeController.text,
        ),
      );
    });

    patientController.clear();
    doctorController.clear();
    timeController.clear();

    Navigator.pop(context);
  }

  void showAddAppointmentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Book Appointment'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: patientController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: doctorController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Appointment Time',
                  hintText: 'Example: 03:30 PM',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: addAppointment,
              child: const Text('Book'),
            ),
          ],
        );
      },
    );
  }

  void deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
      ),

      body: AppBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.all(12),

                leading: const CircleAvatar(
                  radius: 28,
                  child: Icon(
                    Icons.calendar_month,
                    size: 28,
                  ),
                ),

                title: Text(
                  appointment.patientName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '${appointment.doctorName} • ${appointment.time}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),

                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    deleteAppointment(index);
                  },
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddAppointmentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}