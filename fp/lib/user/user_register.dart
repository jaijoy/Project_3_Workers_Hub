//
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../loginn.dart';
//
//
// // Define the colors used in LoginPage for consistency
// const Color primaryColor = Color(0xFF1E1E1E); // Very dark background
// const Color accentColor = Colors.cyanAccent; // Bright accent for focus
// const Color cardColor = Color(0xFF2C2C2C); // Slightly lighter card
//
// void main() {
//   // Use the same MaterialApp setup for consistency
//   runApp(MaterialApp(
//     title: 'Trawldoor Registration',
//     theme: ThemeData(
//       primarySwatch: Colors.blueGrey,
//       brightness: Brightness.dark, // Dark aesthetic
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       textSelectionTheme: TextSelectionThemeData(
//         cursorColor: accentColor,
//         selectionColor: accentColor.withOpacity(0.3),
//       ),
//     ),
//     home: const regapp(),
//   ));
// }
//
// class regapp extends StatefulWidget {
//   const regapp({super.key});
//
//   @override
//   State<regapp> createState() => _regappState();
// }
//
// class _regappState extends State<regapp> {
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController place = TextEditingController();
//   TextEditingController post = TextEditingController();
//   TextEditingController pin = TextEditingController();
//   TextEditingController district = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   String? gender_ = '';
//   File? _selectedImage;
//   final _formkey = GlobalKey<FormState>();
//   // ...
//
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     } else {
//       Fluttertoast.showToast(msg: "No image selected");
//     }
//   }
//
//   // Custom Widget for the TextFields (Copied from LoginPage)
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     bool isPassword = false,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       style: const TextStyle(color: Colors.white), // Input text color
//       keyboardType: keyboardType,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[500]), // Label color
//         prefixIcon: Icon(icon, color: accentColor), // Icon color
//         filled: true,
//         fillColor: primaryColor, // Dark fill color for high contrast
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 1), // Subtle border
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: accentColor, width: 2), // Highlight border
//         ),
//         errorBorder: OutlineInputBorder( // Added for validation errors
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder( // Added for validation errors
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//         ),
//       ),
//     );
//   }
//
//   // Custom Widget for Date Picker Field
//   Widget _buildDateField({
//     required TextEditingController controller,
//     required String label,
//     required BuildContext context,
//   }) {
//     return TextFormField(
//       controller: controller,
//       readOnly: true,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[500]),
//         prefixIcon: const Icon(Icons.calendar_today, color: accentColor),
//         filled: true,
//         fillColor: primaryColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: accentColor, width: 2),
//         ),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime.now(),
//           builder: (context, child) {
//             // Apply dark theme to the DatePicker dialog
//             return Theme(
//               data: ThemeData.dark().copyWith(
//                 colorScheme: const ColorScheme.dark(
//                   primary: accentColor,
//                   onPrimary: primaryColor,
//                   surface: cardColor,
//                   onSurface: Colors.white,
//                 ),
//                 dialogBackgroundColor: primaryColor,
//               ),
//               child: child!,
//             );
//           },
//         );
//
//         if (pickedDate != null) {
//           DateTime today = DateTime.now();
//           int age = today.year - pickedDate.year;
//           if (today.month < pickedDate.month ||
//               (today.month == pickedDate.month && today.day < pickedDate.day)) {
//             age--;
//           }
//
//           if (age < 18) {
//             Fluttertoast.showToast(
//               msg: "You must be at least 18 years old.",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               backgroundColor: Colors.redAccent,
//               textColor: Colors.white,
//             );
//           } else {
//             setState(() {
//               controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//             });
//           }
//         }
//       },
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return "Please enter your Date of Birth";
//         }
//         return null;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor, // Set the main background color
//       appBar: AppBar(
//         title: const Text('New User Registration'),
//         backgroundColor: cardColor,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//           child: Container(
//             padding: const EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               color: cardColor,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.5),
//                   blurRadius: 20,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Text(
//                     'Trawldoor Registration',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: accentColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 30),
//
//                   // --- Personal Details ---
//                   _buildSectionHeader('Personal Details'),
//                   const SizedBox(height: 15),
//
//                   _buildTextField(
//                     controller: name,
//                     label: 'Full Name',
//                     icon: Icons.person_outline,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter your name";
//                       if (value.trim().length < 3) return "Name must be at least 3 characters";
//                       if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) return "Name can only contain letters";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildDateField(
//                     controller: dob,
//                     label: 'Date of Birth',
//                     context: context,
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Gender Selection (Styled to match dark theme)
//                   _buildSectionHeader('Gender', fontSize: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildGenderRadio('Male'),
//                       _buildGenderRadio('Female'),
//                       _buildGenderRadio('Other'),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Profile Picture Upload
//                   _buildSectionHeader('Profile Picture'),
//                   GestureDetector(
//                     onTap: _chooseImage,
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: accentColor.withOpacity(0.5), width: 1),
//                       ),
//                       child: Center(
//                         child: _selectedImage != null
//                             ? ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.file(
//                             _selectedImage!,
//                             width: 110,
//                             height: 110,
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                             : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.camera_alt, size: 40, color: Colors.grey[500]),
//                             const SizedBox(height: 5),
//                             Text(
//                               'Upload Image',
//                               style: TextStyle(color: Colors.grey[500]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//
//                   // --- Contact Details ---
//                   _buildSectionHeader('Contact Details'),
//                   const SizedBox(height: 15),
//
//                   _buildTextField(
//                     controller: email,
//                     label: 'Email Address',
//                     icon: Icons.email_outlined,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter your email";
//                       String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//                       if (!RegExp(pattern).hasMatch(value.trim())) return "Please enter a valid email address";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildTextField(
//                     controller: phone,
//                     label: 'Phone Number',
//                     icon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter valid phone number";
//                       String pattern = r'^[6-9]\d{9}$';
//                       if (!RegExp(pattern).hasMatch(value.trim())) return "Please enter a valid 10 digit number";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 30),
//
//                   // --- Address Details ---
//                   _buildSectionHeader('Address Details'),
//                   const SizedBox(height: 15),
//
//                   _buildTextField(
//                     controller: place,
//                     label: 'Place',
//                     icon: Icons.location_city_outlined,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter valid place";
//                       if (value.trim().length < 2) return "Place must be at least 2 characters long";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildTextField(
//                     controller: post,
//                     label: 'Post Office',
//                     icon: Icons.local_post_office_outlined,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter valid Post Office";
//                       if (value.trim().length < 2) return "Post Office must be at least 2 characters long";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildTextField(
//                     controller: district,
//                     label: 'District',
//                     icon: Icons.map_outlined,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter valid district";
//                       if (value.trim().length < 2) return "District must be at least 2 characters long";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildTextField(
//                     controller: pin,
//                     label: 'Pincode',
//                     icon: Icons.push_pin_outlined,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please Enter valid pin code";
//                       String pattern = r'^[0-9]{6}$';
//                       if (!RegExp(pattern).hasMatch(value.trim())) return "Pin Code must be exactly 6 digits";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 30),
//
//                   // --- Account Details ---
//                   _buildSectionHeader('Account Details'),
//                   const SizedBox(height: 15),
//
//                   _buildTextField(
//                     controller: username,
//                     label: 'Username',
//                     icon: Icons.account_circle_outlined,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter a username";
//                       if (value.trim().length < 4) return "Username must be at least 4 characters long";
//                       if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) return "Username can only contain letters, numbers, and underscores";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildTextField(
//                     controller: password,
//                     label: 'Password',
//                     icon: Icons.lock_open_outlined,
//                     isPassword: true,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) return "Please enter your password";
//                       if (value.length < 8) return "Password must be at least 8 characters long";
//                       String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
//                       if (!RegExp(pattern).hasMatch(value)) return "Password must contain uppercase, lowercase, number & special character";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 40),
//
//                   // Register Button (Styled to match Login Button)
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         if (_formkey.currentState!.validate()) {
//                           if (gender_ == null || gender_!.isEmpty) {
//                             Fluttertoast.showToast(msg: "Please select your gender", backgroundColor: Colors.orangeAccent);
//                             return;
//                           }
//                           if (_selectedImage == null) {
//                             Fluttertoast.showToast(msg: "Please select a profile picture", backgroundColor: Colors.orangeAccent);
//                             return;
//                           }
//
//                           // Show loading indicator here if possible
//                           bool success = await sendData();
//
//                           if (success) {
//                             // Navigate back to the login page
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (context) => LoginPage()),
//                             );
//                           }
//                         } else {
//                           Fluttertoast.showToast(
//                               msg: "Please correct the errors before submitting", backgroundColor: Colors.redAccent, textColor: Colors.white);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: accentColor, // Use the bright accent
//                         foregroundColor: primaryColor, // Dark text on bright background
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         elevation: 5,
//                       ),
//                       child: const Text('REGISTER'),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Login link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account?",
//                         style: TextStyle(color: Colors.grey[400]),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => LoginPage()),
//                           );
//                         },
//                         child: const Text(
//                           'Login here',
//                           style: TextStyle(
//                             color: accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper widget for section headers
//   Widget _buildSectionHeader(String title, {double fontSize = 18}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: fontSize,
//             fontWeight: FontWeight.w600,
//             color: Colors.white70,
//             letterSpacing: 0.5,
//           ),
//         ),
//         Divider(color: accentColor.withOpacity(0.5), thickness: 1.5, height: 15),
//       ],
//     );
//   }
//
//   // Helper widget for gender radio buttons
//   Widget _buildGenderRadio(String value) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Radio<String>(
//           value: value,
//           groupValue: gender_,
//           onChanged: (String? newValue) {
//             setState(() {
//               gender_ = newValue!;
//             });
//           },
//           activeColor: accentColor,
//         ),
//         Text(value, style: const TextStyle(color: Colors.white)),
//       ],
//     );
//   }
//
//   // The sendData function remains the same as its logic is backend related
//   Future<bool> sendData() async {
//     String _name = name.text;
//     String _email = email.text;
//     String _phone = phone.text;
//     String _pin = pin.text;
//     String _place = place.text;
//     String _district = district.text;
//     String _username = username.text;
//     String _password = password.text;
//     String _dob = dob.text;
//     String _post = post.text;
//     String _gender = gender_ ?? '';
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     final uri = Uri.parse('$url/myapp/user_registration/');
//
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = _name;
//     request.fields['email'] = _email;
//     request.fields['phone'] = _phone;
//     request.fields['pin'] = _pin;
//     request.fields['place'] = _place;
//     request.fields['district'] = _district;
//     request.fields['username'] = _username;
//     request.fields['password'] = _password;
//     request.fields['dob'] = _dob;
//     request.fields['post'] = _post;
//     request.fields['gender'] = _gender;
//
//     if (_selectedImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.", backgroundColor: accentColor, textColor: primaryColor);
//         return true;
//       }
//       else {
//         Fluttertoast.showToast(msg: "Username or email already taken .", backgroundColor: Colors.redAccent, textColor: Colors.white);
//         return false;
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Network Error: $e", backgroundColor: Colors.redAccent, textColor: Colors.white);
//       return false;
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../loginn.dart';

// Define the colors used in FixPro LoginPage for consistency
const Color primaryWhite = Colors.white;
const Color purpleAccent = Color(0xFF6A11CB);
const Color blueAccent = Color(0xFF2575FC);

void main() {
  runApp(MaterialApp(
    title: 'FixPro Registration',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const regapp(),
  ));
}

class regapp extends StatefulWidget {
  const regapp({super.key});

  @override
  State<regapp> createState() => _regappState();
}

class _regappState extends State<regapp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController post = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dob = TextEditingController();
  String? gender_ = '';
  File? _selectedImage;
  final _formkey = GlobalKey<FormState>();

  // Background gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [purpleAccent, blueAccent],
  );

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No image selected");
    }
  }

  // Custom Widget for the TextFields with FixPro underline style
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: purpleAccent, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: keyboardType,
                validator: validator,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Enter $label",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: purpleAccent,
                      width: 2,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Custom Widget for Date Picker Field
  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: purpleAccent, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Select $label",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: purpleAccent,
                      width: 2,
                    ),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: purpleAccent,
                            onPrimary: primaryWhite,
                            surface: Colors.white,
                            onSurface: Colors.black87,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    DateTime today = DateTime.now();
                    int age = today.year - pickedDate.year;
                    if (today.month < pickedDate.month ||
                        (today.month == pickedDate.month && today.day < pickedDate.day)) {
                      age--;
                    }

                    if (age < 18) {
                      Fluttertoast.showToast(
                        msg: "You must be at least 18 years old.",
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else {
                      setState(() {
                        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your Date of Birth";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: primaryWhite),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "FixPro User Registration",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: primaryWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Create your account to access our services",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryWhite.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 30),

                // Form Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: primaryWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo & Title
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: purpleAccent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person_add_outlined,
                                  color: purpleAccent,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: purpleAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),

                        // --- Personal Details ---
                        _buildSectionHeader('Personal Details'),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: name,
                          label: 'Full Name',
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter your name";
                            if (value.trim().length < 3) return "Name must be at least 3 characters";
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) return "Name can only contain letters";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildDateField(
                          controller: dob,
                          label: 'Date of Birth',
                          context: context,
                        ),
                        const SizedBox(height: 25),

                        // Gender Selection
                        _buildGenderSection(),
                        const SizedBox(height: 25),

                        // Profile Picture Upload
                        _buildProfilePictureSection(),
                        const SizedBox(height: 30),

                        // --- Contact Details ---
                        _buildSectionHeader('Contact Details'),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: email,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter your email";
                            String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                            if (!RegExp(pattern).hasMatch(value.trim())) return "Please enter a valid email address";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildTextField(
                          controller: phone,
                          label: 'Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter valid phone number";
                            String pattern = r'^[6-9]\d{9}$';
                            if (!RegExp(pattern).hasMatch(value.trim())) return "Please enter a valid 10 digit number";
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // --- Address Details ---
                        _buildSectionHeader('Address Details'),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: place,
                          label: 'Place',
                          icon: Icons.location_city_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter valid place";
                            if (value.trim().length < 2) return "Place must be at least 2 characters long";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildTextField(
                          controller: post,
                          label: 'Post Office',
                          icon: Icons.local_post_office_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter valid Post Office";
                            if (value.trim().length < 2) return "Post Office must be at least 2 characters long";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildTextField(
                          controller: district,
                          label: 'District',
                          icon: Icons.map_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter valid district";
                            if (value.trim().length < 2) return "District must be at least 2 characters long";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildTextField(
                          controller: pin,
                          label: 'Pincode',
                          icon: Icons.push_pin_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please Enter valid pin code";
                            String pattern = r'^[0-9]{6}$';
                            if (!RegExp(pattern).hasMatch(value.trim())) return "Pin Code must be exactly 6 digits";
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // --- Account Details ---
                        _buildSectionHeader('Account Details'),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: username,
                          label: 'Username',
                          icon: Icons.account_circle_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter a username";
                            if (value.trim().length < 4) return "Username must be at least 4 characters long";
                            if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) return "Username can only contain letters, numbers, and underscores";
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        _buildTextField(
                          controller: password,
                          label: 'Password',
                          icon: Icons.lock_open_outlined,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return "Please enter your password";
                            if (value.length < 8) return "Password must be at least 8 characters long";
                            String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
                            if (!RegExp(pattern).hasMatch(value)) return "Password must contain uppercase, lowercase, number & special character";
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                if (gender_ == null || gender_!.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Please select your gender",
                                    backgroundColor: Colors.redAccent,
                                    textColor: primaryWhite,
                                  );
                                  return;
                                }
                                if (_selectedImage == null) {
                                  Fluttertoast.showToast(
                                    msg: "Please select a profile picture",
                                    backgroundColor: Colors.redAccent,
                                    textColor: primaryWhite,
                                  );
                                  return;
                                }

                                // Show loading indicator here if possible
                                bool success = await sendData();

                                if (success) {
                                  // Navigate back to the login page
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please correct the errors before submitting",
                                  backgroundColor: Colors.redAccent,
                                  textColor: primaryWhite,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: purpleAccent,
                              foregroundColor: primaryWhite,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                            ),
                            child: const Text('REGISTER'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                'Login here',
                                style: TextStyle(
                                  color: purpleAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for section headers
  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: purpleAccent,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GENDER",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['Male', 'Female', 'Other']
              .map(
                (e) => GestureDetector(
              onTap: () => setState(() => gender_ = e),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                decoration: BoxDecoration(
                  color: gender_ == e ? purpleAccent.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: gender_ == e ? purpleAccent : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: e,
                      groupValue: gender_,
                      onChanged: (v) => setState(() => gender_ = v),
                      activeColor: purpleAccent,
                    ),
                    Text(
                      e,
                      style: TextStyle(
                        color: gender_ == e ? purpleAccent : Colors.black54,
                        fontWeight: gender_ == e ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildProfilePictureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PROFILE PICTURE",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: _chooseImage,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: _selectedImage != null ? purpleAccent.withOpacity(0.1) : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedImage != null ? purpleAccent : Colors.black26,
                width: 1.5,
              ),
            ),
            child: _selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _selectedImage!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 40, color: Colors.black54),
                SizedBox(height: 10),
                Text(
                  'Tap to upload profile picture',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  'JPEG, PNG (Max 5MB)',
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // The sendData function remains exactly the same
  Future<bool> sendData() async {
    String _name = name.text;
    String _email = email.text;
    String _phone = phone.text;
    String _pin = pin.text;
    String _place = place.text;
    String _district = district.text;
    String _username = username.text;
    String _password = password.text;
    String _dob = dob.text;
    String _post = post.text;
    String _gender = gender_ ?? '';

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    final uri = Uri.parse('$url/myapp/user_registration/');

    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = _name;
    request.fields['email'] = _email;
    request.fields['phone'] = _phone;
    request.fields['pin'] = _pin;
    request.fields['place'] = _place;
    request.fields['district'] = _district;
    request.fields['username'] = _username;
    request.fields['password'] = _password;
    request.fields['dob'] = _dob;
    request.fields['post'] = _post;
    request.fields['gender'] = _gender;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Submitted successfully.", backgroundColor: primaryWhite, textColor: purpleAccent);
        return true;
      }
      else {
        Fluttertoast.showToast(msg: "Username or email already taken.", backgroundColor: Colors.redAccent, textColor: primaryWhite);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Network Error: $e", backgroundColor: Colors.redAccent, textColor: primaryWhite);
      return false;
    }
  }
}

//
//
// def user_registration(request):
// name=request.POST["name"]
// email=request.POST["email"]
// gender=request.POST["gender"]
// phone=request.POST["phone"]
// dob = request.POST["dob"]
// place = request.POST["place"]
// post = request.POST["post"]
// pin = request.POST["pin"]
// district = request.POST["district"]
//
// photo=request.FILES["photo"]
// fs = FileSystemStorage()
// img = fs.save(photo.name, photo)
//
// username = request.POST["username"]
// password = request.POST["password"]
//
// if User.objects.filter(Q(username=username)|Q(email=email)).exists():
// return JsonResponse({'status': 'Not ok'})
//
// user = User.objects.create(username=username, password=make_password(password), first_name=name, email=email)
// user.save()
// user.groups.add(Group.objects.get(name='Customer'))
// obj=user_Tbl()
// obj.LOGIN=user
// obj.name=name
// obj.email=email
// obj.photo=img
// obj.gender=gender
// obj.phone=phone
// obj.dob=dob
// obj.place=place
// obj.post=post
// obj.pin=pin
// obj.district=district
// obj.save()
// return JsonResponse({'status': 'ok', 'lid': str(user.id), 'type': 'Customer'})

//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:contractease_project/loginn.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     home: regapp(),
//   ));
// }
//
// class regapp extends StatefulWidget {
//   const regapp({super.key});
//
//   @override
//   State<regapp> createState() => _regappState();
// }
//
// class _regappState extends State<regapp> {
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController place = TextEditingController();
//   TextEditingController post = TextEditingController();
//   TextEditingController pin = TextEditingController();
//   TextEditingController district = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   String? gender_ = '';
//   File? _selectedImage;
//   final _formkey = GlobalKey<FormState>();
//
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     } else {
//       Fluttertoast.showToast(msg: "No image selected");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registration Page'),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                   key: _formkey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         "Registration",
//                         style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.teal),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//
//                       const Text("Personal Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                       const Divider(),
//
//                       // Name (validator preserved)
//                       TextFormField(
//                         controller: name,
//                         decoration: InputDecoration(
//                           label: const Text('Enter the name'),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please enter your name";
//                           }
//                           if (value.trim().length < 3) {
//                             return "Name must be at least 3 characters";
//                           }
//                           if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//                             return "Name can only contain letters";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       // DOB (validator logic preserved earlier used Toast; kept readOnly and check)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 0),
//                         child: TextFormField(
//                           controller: dob,
//                           readOnly: true,
//                           decoration: const InputDecoration(
//                             labelText: "Date of Birth",
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.calendar_today),
//                           ),
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                             );
//
//                             if (pickedDate != null) {
//                               DateTime today = DateTime.now();
//                               int age = today.year - pickedDate.year;
//                               if (today.month < pickedDate.month ||
//                                   (today.month == pickedDate.month &&
//                                       today.day < pickedDate.day)) {
//                                 age--;
//                               }
//
//                               if (age < 18) {
//                                 Fluttertoast.showToast(
//                                   msg: "You must be at least 18 years old.",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.CENTER,
//                                 );
//                               } else {
//                                 setState(() {
//                                   dob.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                                 });
//                               }
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//
//                       // Gender label + radios (kept original behavior)
//                       const Text("Gender",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                       Row(
//                         children: [
//                           Row(
//                             children: [
//                               Radio<String>(
//                                 value: 'Male',
//                                 groupValue: gender_,
//                                 onChanged: (String? value) {
//                                   setState(() {
//                                     gender_ = value!;
//                                   });
//                                 },
//                               ),
//                               const Text('Male'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio<String>(
//                                 value: 'Female',
//                                 groupValue: gender_,
//                                 onChanged: (String? value) {
//                                   setState(() {
//                                     gender_ = value!;
//                                   });
//                                 },
//                               ),
//                               const Text('Female'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio<String>(
//                                 value: 'Other',
//                                 groupValue: gender_,
//                                 onChanged: (String? value) {
//                                   setState(() {
//                                     gender_ = value!;
//                                   });
//                                 },
//                               ),
//                               const Text('Other'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//
//                       const Text("Profile Picture",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                       GestureDetector(
//                         onTap: () {
//                           _chooseImage();
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: _selectedImage != null
//                               ? ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.file(
//                               _selectedImage!,
//                               width: 120,
//                               height: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                               : const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Email (validator preserved)
//                       TextFormField(
//                         controller: email,
//                         decoration: InputDecoration(
//                           label: const Text('Enter the gmail'),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "please enter your email";
//                           }
//                           String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//                           RegExp regex = RegExp(pattern);
//                           if (!regex.hasMatch(value.trim())) {
//                             return "Please enter a valid email address";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       TextFormField(
//                         controller: phone,
//                         decoration: InputDecoration(
//                           label: const Text("Enter the phone number"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please enter valid phone number";
//                           }
//                           String pattern = r'^[6-9]\d{9}$';
//                           RegExp regex = RegExp(pattern);
//                           if (!regex.hasMatch(value.trim())) {
//                             return "Please enter a valid 10 digit number";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//
//
//                       const Text("Address Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                       const Divider(),
//
//                       TextFormField(
//                         controller: place,
//                         decoration: InputDecoration(
//                           label: const Text("Place"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return " Please enter valid place";
//                           }
//                           if (value.trim().length < 2) {
//                             return "Place must be atleast 2 characters long";
//                           }
//                           if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//                             return "Pace can only contain letters";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       TextFormField(
//                         controller: post,
//                         decoration: InputDecoration(
//                           label: const Text("Post Office"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return " Please enter valid place";
//                           }
//                           if (value.trim().length < 2) {
//                             return "Place must be atleast 2 characters long";
//                           }
//                           if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//                             return "Place can only contain letters";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       TextFormField(
//                         controller: district,
//                         decoration: InputDecoration(
//                           label: const Text("District"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return " Please enter valid district";
//                           }
//                           if (value.trim().length < 2) {
//                             return "District must be atleast 2 characters long";
//                           }
//                           if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//                             return "District can only contain letters";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       TextFormField(
//                         controller: pin,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           label: const Text("Pin"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please Enter valid pin code";
//                           }
//                           String pattern = r'^[0-9]{6}$';
//                           RegExp regex = RegExp(pattern);
//                           if (!regex.hasMatch(value.trim())) {
//                             return "Pin Code must be exactly 6 digits";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//
//
//
//
//                       const Text("Account Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                       const Divider(),
//
//                       TextFormField(
//                         controller: username,
//                         decoration: InputDecoration(
//                           label: const Text("Username"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please enter a username";
//                           }
//                           if (value.trim().length < 4) {
//                             return "Username must be at least 4 characters long";
//                           }
//                           if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
//                             return "Username can only contain letters, numbers, and underscores";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//
//                       TextFormField(
//                         controller: password,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           label: const Text("Password"),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please enter your password";
//                           }
//                           if (value.length < 8) {
//                             return "Password must be at least 8 characters long";
//                           }
//                           String pattern =
//                               r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
//                           RegExp regex = RegExp(pattern);
//
//                           if (!regex.hasMatch(value)) {
//                             return "Password must contain uppercase, lowercase, number & special character";
//                           }
//
//                           return null; // means validation passed
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_formkey.currentState!.validate()) {
//                             if (gender_ == null || gender_!.isEmpty) {
//                               Fluttertoast.showToast(msg: "Please select your gender");
//                               return;
//                             }
//
//                             if (_selectedImage == null) {
//                               Fluttertoast.showToast(msg: "Please select a profile picture");
//                               return;
//                             }
//                             bool success = await sendData(); // wait for completion
//                             if (success) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => LoginPage()),
//                               );
//                             }
//                           } else {
//                             Fluttertoast.showToast(
//                                 msg: "Please correct the errors before submitting");
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         child: const Text(
//                           'Register',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> sendData() async {
//     String _name = name.text;
//     String _email = email.text;
//     String _phone = phone.text;
//     String _pin = pin.text;
//     String _place = place.text;
//     String _district = district.text;
//     String _username = username.text;
//     String _password = password.text;
//     String _dob = dob.text;
//     String _post = post.text;
//     String _gender = gender_ ?? '';
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     final uri = Uri.parse('$url/myapp/user_registration/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = _name;
//     request.fields['email'] = _email;
//     request.fields['phone'] = _phone;
//     request.fields['pin'] = _pin;
//     request.fields['place'] = _place;
//     request.fields['district'] = _district;
//     request.fields['username'] = _username;
//     request.fields['password'] = _password;
//     request.fields['dob'] = _dob;
//     request.fields['post'] = _post;
//     request.fields['gender'] = _gender;
//
//     if (_selectedImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         return true;
//       } else  if (response.statusCode == 200 && data['status'] == 'not ok') {
//         Fluttertoast.showToast(msg: "Username existed");
//         return false;
//       }
//       else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//         return false;
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//       return false;
//     }
//   }
// }
//
