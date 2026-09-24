import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import 'patients_screen.dart';
import 'doctors_screen.dart';
import 'appointments_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Management'),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hospital Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Patients'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PatientsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Doctors'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DoctorsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Appointments'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AppointmentsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F7FA),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: const [
              DashboardCard(
                title: 'Patients',
                value: '120',
                icon: Icons.people,
              ),
              DashboardCard(
                title: 'Doctors',
                value: '25',
                icon: Icons.medical_services,
              ),
              DashboardCard(
                title: 'Appointments',
                value: '45',
                icon: Icons.calendar_month,
              ),
              DashboardCard(
                title: 'Departments',
                value: '10',
                icon: Icons.local_hospital,
              ),
            ],
          ),
        ),
      ),
    );
  }
}