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
// import 'loginn.dart';
//
// const Color primaryColor = Color(0xFF1E1E1E);
// const Color accentColor = Colors.cyanAccent;
// const Color cardColor = Color(0xFF2C2C2C);
//
// class WorkerRegistration extends StatefulWidget {
//   const WorkerRegistration({super.key});
//
//   @override
//   State<WorkerRegistration> createState() => _WorkerRegistrationState();
// }
//
// class _WorkerRegistrationState extends State<WorkerRegistration> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController dob = TextEditingController();
//
//   String? gender;
//   File? photo;
//   File? proof;
//
//   /* ---------------- PICKERS ---------------- */
//
//   Future<void> pickPhoto() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => photo = File(picked.path));
//     }
//   }
//
//   Future<void> pickProof() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => proof = File(picked.path));
//     }
//   }
//
//   /* ---------------- API CALL ---------------- */
//
//   Future<bool> sendData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     final uri = Uri.parse('$url/myapp/worker_registration/');
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['name'] = name.text.trim();
//     request.fields['gmail'] = email.text.trim(); // IMPORTANT
//     request.fields['dob'] = dob.text.trim();
//     request.fields['gender'] = gender!;
//     request.fields['address'] = address.text.trim();
//     request.fields['phone'] = phone.text.trim();
//     request.fields['username'] = username.text.trim();
//     request.fields['password'] = password.text.trim();
//
//     request.files.add(
//         await http.MultipartFile.fromPath('photo', photo!.path));
//     request.files.add(
//         await http.MultipartFile.fromPath('proof', proof!.path));
//
//     try {
//       var response = await request.send();
//       var res = await response.stream.bytesToString();
//       var jsonData = jsonDecode(res);
//
//       if (response.statusCode == 200 && jsonData['status'] == 'ok') {
//         Fluttertoast.showToast(
//             msg: "Registration successful. Waiting for approval");
//         return true;
//       } else {
//         Fluttertoast.showToast(
//             msg: "Username or Email already exists",
//             backgroundColor: Colors.redAccent);
//         return false;
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Network Error");
//       return false;
//     }
//   }
//
//   /* ---------------- UI ---------------- */
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         title: const Text("Worker Registration"),
//         backgroundColor: cardColor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//
//               buildField(name, "Name"),
//               buildDOB(),
//               buildGender(),
//               buildEmail(),
//               buildPhone(),
//               buildField(address, "Address"),
//               buildField(username, "Username"),
//               buildPassword(),
//
//               const SizedBox(height: 15),
//
//               uploadBox("Upload Photo", pickPhoto, photo),
//               const SizedBox(height: 10),
//               uploadBox("Upload Proof", pickProof, proof),
//
//               const SizedBox(height: 30),
//
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     if (gender == null) {
//                       Fluttertoast.showToast(msg: "Select gender");
//                       return;
//                     }
//                     if (photo == null || proof == null) {
//                       Fluttertoast.showToast(
//                           msg: "Upload photo and proof");
//                       return;
//                     }
//
//                     bool ok = await sendData();
//                     if (ok) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) =>  LoginPage()),
//                       );
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.all(14),
//                 ),
//                 child: const Text("REGISTER"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /* ---------------- FORM FIELDS ---------------- */
//
//   Widget buildField(TextEditingController c, String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: c,
//         validator: (v) => v == null || v.isEmpty ? "Required" : null,
//         decoration: inputDecoration(label),
//       ),
//     );
//   }
//
//   Widget buildEmail() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: email,
//         keyboardType: TextInputType.emailAddress,
//         validator: (v) {
//           if (v == null || v.isEmpty) return "Required";
//           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
//             return "Invalid email";
//           }
//           return null;
//         },
//         decoration: inputDecoration("Email"),
//       ),
//     );
//   }
//
//   Widget buildPhone() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: phone,
//         keyboardType: TextInputType.phone,
//         validator: (v) {
//           if (v == null || v.isEmpty) return "Required";
//           if (!RegExp(r'^[6-9]\d{9}$').hasMatch(v)) {
//             return "Enter valid 10 digit mobile number";
//           }
//           return null;
//         },
//         decoration: inputDecoration("Phone"),
//       ),
//     );
//   }
//
//   Widget buildPassword() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: password,
//         obscureText: true,
//         validator: (v) {
//           if (v == null || v.isEmpty) return "Required";
//           if (v.length < 6) return "Minimum 6 characters";
//           return null;
//         },
//         decoration: inputDecoration("Password"),
//       ),
//     );
//   }
//
//   Widget buildDOB() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: dob,
//         readOnly: true,
//         decoration: inputDecoration("Date of Birth"),
//         onTap: () async {
//           DateTime? d = await showDatePicker(
//             context: context,
//             firstDate: DateTime(1950),
//             lastDate: DateTime.now(),
//             initialDate: DateTime.now(),
//           );
//           if (d != null) {
//             dob.text = DateFormat('yyyy-MM-dd').format(d);
//           }
//         },
//         validator: (v) => v == null || v.isEmpty ? "Select DOB" : null,
//       ),
//     );
//   }
//
//   Widget buildGender() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: ['Male', 'Female', 'Other']
//           .map(
//             (e) => Row(
//           children: [
//             Radio(
//               value: e,
//               groupValue: gender,
//               onChanged: (v) => setState(() => gender = v),
//             ),
//             Text(e, style: const TextStyle(color: Colors.white)),
//           ],
//         ),
//       )
//           .toList(),
//     );
//   }
//
//   Widget uploadBox(String text, VoidCallback onTap, File? file) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 55,
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: accentColor),
//         ),
//         child: Center(
//           child: Text(
//             file == null ? text : "File Selected",
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
//
//   InputDecoration inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: cardColor,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
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

import 'loginn.dart';

const Color primaryWhite = Colors.white;
const Color purpleAccent = Color(0xFF6A11CB);
const Color blueAccent = Color(0xFF2575FC);

class WorkerRegistration extends StatefulWidget {
  const WorkerRegistration({super.key});

  @override
  State<WorkerRegistration> createState() => _WorkerRegistrationState();
}

class _WorkerRegistrationState extends State<WorkerRegistration> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dob = TextEditingController();

  String? gender;
  File? photo;
  File? proof;

  // Background gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [purpleAccent, blueAccent],
  );

  /* ---------------- PICKERS ---------------- */

  Future<void> pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => photo = File(picked.path));
    }
  }

  Future<void> pickProof() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => proof = File(picked.path));
    }
  }

  /* ---------------- API CALL ---------------- */

  Future<bool> sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    final uri = Uri.parse('$url/myapp/worker_registration/');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name.text.trim();
    request.fields['gmail'] = email.text.trim();
    request.fields['dob'] = dob.text.trim();
    request.fields['gender'] = gender!;
    request.fields['address'] = address.text.trim();
    request.fields['phone'] = phone.text.trim();
    request.fields['username'] = username.text.trim();
    request.fields['password'] = password.text.trim();

    request.files.add(
        await http.MultipartFile.fromPath('photo', photo!.path));
    request.files.add(
        await http.MultipartFile.fromPath('proof', proof!.path));

    try {
      var response = await request.send();
      var res = await response.stream.bytesToString();
      var jsonData = jsonDecode(res);

      if (response.statusCode == 200 && jsonData['status'] == 'ok') {
        Fluttertoast.showToast(
            msg: "Registration successful. Waiting for approval",
            backgroundColor: primaryWhite,
            textColor: purpleAccent);
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Username or Email already exists",
            backgroundColor: Colors.redAccent,
            textColor: primaryWhite);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Network Error",
          backgroundColor: Colors.redAccent,
          textColor: primaryWhite);
      return false;
    }
  }

  /* ---------------- UI ---------------- */

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
                      "FixPro Worker Registration",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: primaryWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Join our professional network",
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
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildSectionTitle("Personal Information"),
                        SizedBox(height: 20),

                        // Name
                        _buildUnderlineField(name, "Name", Icons.person_outline),
                        SizedBox(height: 20),

                        // DOB
                        _buildUnderlineField(dob, "Date of Birth", Icons.calendar_today_outlined,
                            readOnly: true, onTap: () async {
                              DateTime? d = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );
                              if (d != null) {
                                dob.text = DateFormat('yyyy-MM-dd').format(d);
                              }
                            }),
                        SizedBox(height: 20),

                        // Gender
                        _buildGenderSection(),
                        SizedBox(height: 20),

                        _buildSectionTitle("Contact Details"),
                        SizedBox(height: 20),

                        // Email
                        _buildUnderlineField(email, "Email", Icons.email_outlined),
                        SizedBox(height: 20),

                        // Phone
                        _buildUnderlineField(phone, "Phone", Icons.phone_outlined,
                            keyboardType: TextInputType.phone),
                        SizedBox(height: 20),

                        // Address
                        _buildUnderlineField(address, "Address", Icons.location_on_outlined),
                        SizedBox(height: 20),

                        _buildSectionTitle("Account Credentials"),
                        SizedBox(height: 20),

                        // Username
                        _buildUnderlineField(username, "Username", Icons.person_outline),
                        SizedBox(height: 20),

                        // Password
                        _buildUnderlineField(password, "Password", Icons.lock_outlined,
                            obscureText: true),
                        SizedBox(height: 30),

                        _buildSectionTitle("Upload Documents"),
                        SizedBox(height: 20),

                        // Photo Upload
                        _buildUploadButton(
                          "Upload Profile Photo",
                          photo,
                          pickPhoto,
                          Icons.camera_alt_outlined,
                        ),
                        SizedBox(height: 15),

                        // Proof Upload
                        _buildUploadButton(
                          "Upload ID Proof",
                          proof,
                          pickProof,
                          Icons.assignment_outlined,
                        ),
                        SizedBox(height: 40),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (gender == null) {
                                  Fluttertoast.showToast(
                                      msg: "Select gender",
                                      backgroundColor: Colors.redAccent,
                                      textColor: primaryWhite);
                                  return;
                                }
                                if (photo == null || proof == null) {
                                  Fluttertoast.showToast(
                                      msg: "Upload photo and proof",
                                      backgroundColor: Colors.redAccent,
                                      textColor: primaryWhite);
                                  return;
                                }

                                bool ok = await sendData();
                                if (ok) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: purpleAccent,
                              foregroundColor: primaryWhite,
                              padding: const EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Already have an account? Login",
                            style: TextStyle(
                              color: purpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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

  /* ---------------- CUSTOM WIDGETS ---------------- */

  Widget _buildSectionTitle(String title) {
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

  Widget _buildUnderlineField(
      TextEditingController controller,
      String label,
      IconData icon, {
        bool readOnly = false,
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
        VoidCallback? onTap,
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
                readOnly: readOnly,
                obscureText: obscureText,
                keyboardType: keyboardType,
                onTap: onTap,
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
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  if (label == "Email") {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter valid email';
                    }
                  }
                  if (label == "Phone") {
                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                      return 'Enter valid 10 digit number';
                    }
                  }
                  if (label == "Password" && value.length < 6) {
                    return 'Minimum 6 characters required';
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
              onTap: () => setState(() => gender = e),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                decoration: BoxDecoration(
                  color: gender == e ? purpleAccent.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: gender == e ? purpleAccent : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: e,
                      groupValue: gender,
                      onChanged: (v) => setState(() => gender = v),
                      activeColor: purpleAccent,
                    ),
                    Text(
                      e,
                      style: TextStyle(
                        color: gender == e ? purpleAccent : Colors.black54,
                        fontWeight: gender == e ? FontWeight.w600 : FontWeight.normal,
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

  Widget _buildUploadButton(
      String text,
      File? file,
      VoidCallback onTap,
      IconData icon,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: file == null ? Colors.grey[50] : purpleAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: file == null ? Colors.black26 : purpleAccent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: file == null ? Colors.black54 : purpleAccent),
              SizedBox(width: 12),
              Text(
                file == null ? text : "✓ ${text.split(' ')[1]} Uploaded",
                style: TextStyle(
                  color: file == null ? Colors.black54 : purpleAccent,
                  fontWeight: file == null ? FontWeight.normal : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

