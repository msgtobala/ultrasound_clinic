import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/edit_profile.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildManagementOptions(context),
            const Spacer(),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // const CircleAvatar(
          //   radius: 30,
          //   backgroundImage: AssetImage('assets/images/clinic_icon.png'),
          // ),
          SizedBox(width: 16.w),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parth Clinic',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('pclinic@gmail.com'),
                Text('+91 9698765698'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditClinicScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManagementOptions(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          icon: Icons.medical_services,
          title: 'Manage doctor',
          onTap: () => {},
          // onTap: () => Navigator.pushNamed(context, Routes.doctorSetting),
        ),
        CustomListTile(
          icon: Icons.people,
          title: 'Manage staff',
          onTap: () {},
          // onTap: () => Navigator.pushNamed(context, Routes.signUp),
        ),
        CustomListTile(
          icon: Icons.description,
          title: 'USG',
          onTap: () => {},
          // onTap: () => Navigator.pushNamed(context, Routes.signUp),
        ),
        CustomListTile(
          icon: Icons.lock,
          title: 'Change password',
          onTap: () => {},
          // onTap: () => Navigator.pushNamed(context, Routes.signUp),
        ),
        CustomListTile(
          icon: Icons.description,
          title: 'Terms & Conditions',
          onTap: () => {},
          // onTap: () => Navigator.pushNamed(context, Routes.signUp),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Handle logout here
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text('Logout'),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
