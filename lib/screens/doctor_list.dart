import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/screens/add_doctor.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Doctors list'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyDoctors.length,
              itemBuilder: (context, index) {
                return DoctorListItem(doctor: dummyDoctors[index]);
              },
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDoctorScreen()),
    );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'USG'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointment'),
        BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Media'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorListItem({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(doctor.imageUrl),
        radius: 25,
      ),
      title: Text(doctor.name),
      subtitle: Text(doctor.specialization),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Handle edit doctor
        },
      ),
    );
  }
}

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Doctor model
class Doctor {
  final String name;
  final String specialization;
  final String imageUrl;

  Doctor({required this.name, required this.specialization, required this.imageUrl});
}

// Dummy data for demonstration
List<Doctor> dummyDoctors = [
  Doctor(name: 'Dr. Lina Thomas', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Wanda Maximoff', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Diana Prince', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Karen Starr', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Natasha Romanoff', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Harleen Quinzel', specialization: 'MD - Ultrasound', imageUrl: 'assets/images/layout_background.png'),
  Doctor(name: 'Pepper Potts', specialization: 'MD - Ultrasound',imageUrl: 'assets/images/layout_background.png'),
];