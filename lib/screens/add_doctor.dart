import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({Key? key}) : super(key: key);

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedDegree;
  File? _image;
  final _picker = ImagePicker();

  final List<String> _degrees = ['MD', 'MBBS', 'MS', 'PhD'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndSaveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // String? imageUrl;
        // if (_image != null) {
        //   // Upload image to Firebase Storage
        //   final ref = FirebaseStorage.instance.ref().child('doctor_images/${DateTime.now().toString()}');
        //   await ref.putFile(_image!);
        //   imageUrl = await ref.getDownloadURL();
        // }

        // // Save doctor data to Firestore
        // await FirebaseFirestore.instance.collection('doctors').add({
        //   'name': _nameController.text,
        //   'phone': _phoneController.text,
        //   'degree': _selectedDegree,
        //   'description': _descriptionController.text,
        //   'imageUrl': imageUrl,
        // });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Doctor added successfully')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Doctor details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(_nameController, 'Doctor name'),
                SizedBox(height: 16),
                _buildTextField(_phoneController, 'Phone number', TextInputType.phone),
                SizedBox(height: 16),
                _buildDropdown(),
                SizedBox(height: 16),
                _buildTextField(_descriptionController, 'Description', TextInputType.multiline),
                SizedBox(height: 24),
                _buildUploadButton(),
                SizedBox(height: 24),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, [TextInputType? keyboardType]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDegree,
      decoration: InputDecoration(
        labelText: 'Degree',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      items: _degrees.map((String degree) {
        return DropdownMenuItem<String>(
          value: degree,
          child: Text(degree),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedDegree = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a degree';
        }
        return null;
      },
    );
  }
Widget _buildUploadButton() {
    return OutlinedButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Take a photo'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icon(Icons.upload, color: Colors.blue),
      label: Text(_image != null ? 'Change profile picture' : 'Upload profile picture', style: TextStyle(color: Colors.blue)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _uploadImageAndSaveData,
      child: Text('Save'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
      currentIndex: 3, // Settings tab is active
      selectedItemColor: Colors.blue,
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}