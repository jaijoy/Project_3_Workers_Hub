// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WorkerViewProfile extends StatefulWidget {
//   const WorkerViewProfile({super.key});
//
//   @override
//   State<WorkerViewProfile> createState() => _WorkerViewProfileState();
// }
//
// class _WorkerViewProfileState extends State<WorkerViewProfile> {
//   bool loading = true;
//   Map<String, dynamic>? profile;
//
//   String url = "";
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   // ================= LOAD PROFILE =================
//   Future<void> loadProfile() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       url = sh.getString('url') ?? '';
//       imgurl = sh.getString('imgurl') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/worker_view_profile/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           profile = jsonData['data'][0];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Profile"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : profile == null
//           ? const Center(child: Text("Profile not found"))
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Profile Image
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: profile!['photo'] != ""
//                   ? NetworkImage(imgurl + profile!['photo'])
//                   : const AssetImage(
//                   "assets/images/default_user.png")
//               as ImageProvider,
//             ),
//
//             const SizedBox(height: 16),
//
//             buildItem("Name", profile!['name']),
//             buildItem("Email", profile!['email']),
//             buildItem("Phone", profile!['phone']),
//             buildItem("Gender", profile!['gender']),
//             buildItem("DOB", profile!['dob']),
//             buildItem("Address", profile!['address']),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================= REUSABLE ROW =================
//   Widget buildItem(String title, String value) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class WorkerViewProfile extends StatefulWidget {
//   const WorkerViewProfile({super.key});
//
//   @override
//   State<WorkerViewProfile> createState() => _WorkerViewProfileState();
// }
//
// class _WorkerViewProfileState extends State<WorkerViewProfile> {
//   bool loading = true;
//   Map<String, dynamic>? profile;
//
//   String url = "";
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   // ================= LOAD PROFILE =================
//   Future<void> loadProfile() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       url = sh.getString('url') ?? '';
//       imgurl = sh.getString('imgurl') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/worker_view_profile/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           profile = jsonData['data'][0];
//           loading = false;
//         });
//       } else {
//         loading = false;
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   // ================= OPEN PROOF =================
//   Future<void> openProof(String proofPath) async {
//     final Uri proofUrl = Uri.parse(imgurl + proofPath);
//
//     if (!await launchUrl(
//       proofUrl,
//       mode: LaunchMode.externalApplication,
//     )) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Could not open proof file")),
//       );
//     }
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Profile"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : profile == null
//           ? const Center(child: Text("Profile not found"))
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Profile Photo
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: profile!['photo'] != ""
//                   ? NetworkImage(imgurl + profile!['photo'])
//                   : const AssetImage(
//                   "assets/images/default_user.png")
//               as ImageProvider,
//             ),
//
//             const SizedBox(height: 20),
//
//             buildItem("Name", profile!['name']),
//             buildItem("Email", profile!['email']),
//             buildItem("Phone", profile!['phone']),
//             buildItem("Gender", profile!['gender']),
//             buildItem("DOB", profile!['dob']),
//             buildItem("Address", profile!['address']),
//             buildItem("Status", profile!['proof']),
//
//             const SizedBox(height: 10),
//
//             // Proof Section
//             profile!['proof'] != ""
//                 ? Card(
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.description,
//                   color: Colors.blue,
//                 ),
//                 title: const Text("Proof Document"),
//                 subtitle: const Text("Tap to view"),
//                 trailing:
//                 const Icon(Icons.open_in_new),
//                 onTap: () =>
//                     openProof(profile!['proof']),
//               ),
//             )
//                 : const Text(
//               "No proof uploaded",
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================= REUSABLE CARD =================
//   Widget buildItem(String title, String value) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Text(
//                 title,
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class WorkerViewProfile extends StatefulWidget {
//   const WorkerViewProfile({super.key});
//
//   @override
//   State<WorkerViewProfile> createState() => _WorkerViewProfileState();
// }
//
// class _WorkerViewProfileState extends State<WorkerViewProfile> {
//   bool loading = true;
//   Map<String, dynamic>? profile;
//
//   String url = "";
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   // ================= LOAD PROFILE =================
//   Future<void> loadProfile() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       url = sh.getString('url') ?? '';
//       imgurl = sh.getString('imgurl') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/worker_view_profile/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           profile = jsonData['data'][0];
//           loading = false;
//         });
//       } else {
//         loading = false;
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   // ================= OPEN PROOF =================
//   Future<void> openProof(String proofPath) async {
//     final String fullUrl = imgurl + proofPath;
//     print("OPENING => $fullUrl");
//
//     final Uri uri = Uri.parse(fullUrl);
//
//     if (!await launchUrl(
//       uri,
//       mode: LaunchMode.externalApplication,
//     )) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to open proof")),
//       );
//     }
//   }
//
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Profile"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : profile == null
//           ? const Center(child: Text("Profile not found"))
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Profile Photo
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: profile!['photo'] != ""
//                   ? NetworkImage(imgurl + profile!['photo'])
//                   : const AssetImage(
//                   "assets/images/default_user.png")
//               as ImageProvider,
//             ),
//
//             const SizedBox(height: 20),
//
//             buildItem("Name", profile!['name']),
//             buildItem("Email", profile!['email']),
//             buildItem("Phone", profile!['phone'].toString()),
//             buildItem("Gender", profile!['gender']),
//             buildItem("DOB", profile!['dob']),
//             buildItem("Address", profile!['address']),
//             // buildItem("Status", profile!['status']),
//
//             const SizedBox(height: 10),
//
//             // ================= PROOF SECTION =================
//
//
//             profile!['proof'] != ""
//                 ? Card(
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.description,
//                   color: Colors.blue,
//                 ),
//                 title: const Text("Proof Document"),
//                 subtitle: const Text("Tap to view"),
//                 trailing:
//                 const Icon(Icons.open_in_new),
//                 onTap: () =>
//                     openProof(profile!['proof']),
//               ),
//             )
//                 : const Text(
//               "No proof uploaded",
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================= REUSABLE CARD =================
//   Widget buildItem(String title, String value) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Text(
//                 title,
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerViewProfile extends StatefulWidget {
  const WorkerViewProfile({super.key});

  @override
  State<WorkerViewProfile> createState() => _WorkerViewProfileState();
}

class _WorkerViewProfileState extends State<WorkerViewProfile> {
  bool loading = true;
  Map<String, dynamic>? profile;

  String url = "";
  String imgurl = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  // ================= LOAD PROFILE =================
  Future<void> loadProfile() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      url = sh.getString('url') ?? '';
      imgurl = sh.getString('imgurl') ?? '';
      String lid = sh.getString('lid') ?? '';

      final response = await http.post(
        Uri.parse('$url/myapp/worker_view_profile/'),
        body: {'lid': lid},
      );

      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          profile = jsonData['data'][0];
          loading = false;
        });
      } else {
        loading = false;
      }
    } catch (e) {
      loading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  // ================= OPEN PROOF =================
  Future<void> openProof(String proofPath) async {
    final String fullUrl = imgurl + proofPath;
    print("OPENING => $fullUrl");

    final Uri uri = Uri.parse(fullUrl);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Failed to open proof"),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      )
          : profile == null
          ? Center(
        child: Text(
          "Profile not found",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Photo
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.deepPurple.withOpacity(0.3),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.deepPurple[50],
                backgroundImage: profile!['photo'] != ""
                    ? NetworkImage(imgurl + profile!['photo'])
                    : const AssetImage("assets/images/default_user.png")
                as ImageProvider,
                child: profile!['photo'] == ""
                    ? Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.deepPurple[300],
                )
                    : null,
              ),
            ),

            const SizedBox(height: 24),

            // Profile Items
            buildItem("Name", profile!['name']),
            buildItem("Email", profile!['email']),
            buildItem("Phone", profile!['phone'].toString()),
            buildItem("Gender", profile!['gender']),
            buildItem("DOB", profile!['dob']),
            buildItem("Address", profile!['address']),

            const SizedBox(height: 20),

            // ================= PROOF SECTION =================
            Text(
              "Documents",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[800],
              ),
            ),
            const SizedBox(height: 12),

            profile!['proof'] != ""
                ? Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.deepPurple.withOpacity(0.1),
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.description,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                ),
                title: Text(
                  "Proof Document",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple[800],
                  ),
                ),
                subtitle: Text(
                  "Tap to view document",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.open_in_new,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                ),
                onTap: () => openProof(profile!['proof']),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            )
                : Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "No proof document uploaded",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= REUSABLE CARD =================
  Widget buildItem(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.deepPurple.withOpacity(0.05),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.deepPurple.withOpacity(0.02),
              Colors.deepPurple.withOpacity(0.01),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[800],
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}