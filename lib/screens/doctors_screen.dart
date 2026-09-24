import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/app_background.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final List<Doctor> doctors = [
    Doctor(
      id: 1,
      name: 'Dr. Ramesh',
      specialization: 'Cardiologist',
    ),
    Doctor(
      id: 2,
      name: 'Dr. Sneha',
      specialization: 'Dermatologist',
    ),
    Doctor(
      id: 3,
      name: 'Dr. Anand',
      specialization: 'General Physician',
    ),
  ];

  final nameController = TextEditingController();
  final specializationController = TextEditingController();

  void addDoctor() {
    if (nameController.text.isEmpty ||
        specializationController.text.isEmpty) {
      return;
    }

    setState(() {
      doctors.add(
        Doctor(
          id: doctors.length + 1,
          name: nameController.text,
          specialization: specializationController.text,
        ),
      );
    });

    nameController.clear();
    specializationController.clear();

    Navigator.pop(context);
  }

  void showAddDoctorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Doctor'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: specializationController,
                decoration: const InputDecoration(
                  labelText: 'Specialization',
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
              onPressed: addDoctor,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void deleteDoctor(int index) {
    setState(() {
      doctors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        centerTitle: true,
      ),

      body: AppBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];

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
                    Icons.medical_services,
                    size: 28,
                  ),
                ),

                title: Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    doctor.specialization,
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
                    deleteDoctor(index);
                  },
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddDoctorDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}