import 'package:flutter/material.dart';
import '../models/patient.dart';


class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final List<Patient> patients = [
    Patient(
      id: 1,
      name: 'Rahul Kumar',
      age: 25,
      problem: 'Fever',
    ),
    Patient(
      id: 2,
      name: 'Priya Sharma',
      age: 30,
      problem: 'Headache',
    ),
  ];

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final problemController = TextEditingController();

  void addPatient() {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        problemController.text.isEmpty) {
      return;
    }

    setState(() {
      patients.add(
        Patient(
          id: patients.length + 1,
          name: nameController.text,
          age: int.parse(ageController.text),
          problem: problemController.text,
        ),
      );
    });

    nameController.clear();
    ageController.clear();
    problemController.clear();

    Navigator.pop(context);
  }

  void showAddPatientDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Patient'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: problemController,
                decoration: const InputDecoration(
                  labelText: 'Problem',
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
              onPressed: addPatient,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void deletePatient(int index) {
    setState(() {
      patients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),

      body: patients.isEmpty
          ? const Center(
              child: Text(
                'No patients found',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),

                    title: Text(patient.name),

                    subtitle: Text(
                      'Age: ${patient.age} | ${patient.problem}',
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletePatient(index);
                      },
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddPatientDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}