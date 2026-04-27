// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WorkerSkillAdd extends StatefulWidget {
//   const WorkerSkillAdd({Key? key}) : super(key: key);
//
//   @override
//   State<WorkerSkillAdd> createState() => _WorkerSkillAddState();
// }
//
// class _WorkerSkillAddState extends State<WorkerSkillAdd> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController skillController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   bool loading = false;
//
//   Future<void> addSkill() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     setState(() {
//       loading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       var response = await http.post(
//         Uri.parse("$url/myapp/worker_skill_add"),
//         body: {
//           "lid": lid,
//           "skill_name": skillController.text.trim(),
//           "discription": descriptionController.text.trim(),
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Skill added successfully"),
//             backgroundColor: Colors.green,
//           ),
//         );
//
//         skillController.clear();
//         descriptionController.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Failed to add skill"),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Skill"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//
//               /// Skill Name
//               TextFormField(
//                 controller: skillController,
//                 decoration: const InputDecoration(
//                   labelText: "Skill Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Skill name is required";
//                   }
//                   if (value.length < 3) {
//                     return "Skill name must be at least 3 characters";
//                   }
//                   return null;
//                 },
//               ),
//
//               const SizedBox(height: 16),
//
//               /// Description
//               TextFormField(
//                 controller: descriptionController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   labelText: "Description",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Description is required";
//                   }
//                   if (value.length < 5) {
//                     return "Description must be at least 5 characters";
//                   }
//                   return null;
//                 },
//               ),
//
//               const SizedBox(height: 25),
//
//               /// Submit Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: loading ? null : addSkill,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueGrey,
//                   ),
//                   child: loading
//                       ? const CircularProgressIndicator(
//                     color: Colors.white,
//                   )
//                       : const Text(
//                     "ADD SKILL",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerSkillAdd extends StatefulWidget {
  const WorkerSkillAdd({Key? key}) : super(key: key);

  @override
  State<WorkerSkillAdd> createState() => _WorkerSkillAddState();
}

class _WorkerSkillAddState extends State<WorkerSkillAdd> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController skillController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool loading = false;

  // Purple to Blue Gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError ? Colors.white : Color(0xFF6A11CB),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 3),
        elevation: 6,
        action: SnackBarAction(
          label: 'OK',
          textColor: isError ? Colors.white : Color(0xFF6A11CB),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> addSkill() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar("Please fill all fields correctly", isError: true);
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      var response = await http.post(
        Uri.parse("$url/myapp/worker_skill_add"),
        body: {
          "lid": lid,
          "skill_name": skillController.text.trim(),
          "discription": descriptionController.text.trim(),
        },
      );

      var data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        _showSnackBar("✓ Skill added successfully!");

        // Clear form after success
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            skillController.clear();
            descriptionController.clear();
          });
        });
      } else {
        _showSnackBar("Failed to add skill. Please try again.", isError: true);
      }
    } catch (e) {
      _showSnackBar("Network error. Please check your connection.", isError: true);
      print("Error: $e");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Skill"),
        backgroundColor: Color(0xFF6A11CB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF6A11CB).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF6A11CB),
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Add New Skill",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6A11CB),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add your professional skills to get more work opportunities",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Skill Name Field
                    _buildUnderlineField(
                      controller: skillController,
                      label: "SKILL NAME",
                      hint: "e.g., Electrical Repair, Plumbing",
                      icon: Icons.build_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Skill name is required";
                        }
                        if (value.length < 3) {
                          return "Skill name must be at least 3 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),

                    // Description Field
                    _buildUnderlineField(
                      controller: descriptionController,
                      label: "DESCRIPTION",
                      hint: "Describe your skill, experience, and expertise",
                      icon: Icons.description_outlined,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Description is required";
                        }
                        if (value.length < 5) {
                          return "Description must be at least 5 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: loading ? null : addSkill,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6A11CB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: loading
                            ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          "ADD SKILL",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnderlineField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Color(0xFF6A11CB), size: 22),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                maxLines: maxLines,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: hint,
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
                      color: Color(0xFF6A11CB),
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
                validator: validator,
              ),
            ),
          ],
        ),
      ],
    );
  }
}