// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewallSkill extends StatefulWidget {
//   // final String workerId;
//
//   const UserViewallSkill({super.key});
//
//   @override
//   State<UserViewallSkill> createState() => _UserViewSkillState();
// }
//
// class _UserViewSkillState extends State<UserViewallSkill> {
//   List skills = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadSkills();
//   }
//
//   /// 🔹 LOAD WORKER SKILLS
//   Future<void> loadSkills() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_view_all_skill/'),
//         body: {
//           // 'wid': widget.workerId,
//           'lid': lid,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData['status'] == 'ok') {
//           setState(() {
//             skills = jsonData['data'];
//             loading = false;
//           });
//         }
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
//
//   /// 🔹 BOOK SKILL
//   Future<void> bookSkill(String skillId) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_book_skill/'),
//         body: {
//           'lid': lid,
//           'skill_id': skillId,
//         },
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Booking submitted (Pending)")),
//         );
//         loadSkills(); // refresh list
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Already booked")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Worker Skills"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : skills.isEmpty
//           ? const Center(child: Text("No skills added"))
//           : ListView.builder(
//         itemCount: skills.length,
//         itemBuilder: (context, index) {
//           final s = skills[index];
//           bool booked = s['booked'] == true;
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     s['skill_name'],
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(s['discription']),
//                   const SizedBox(height: 12),
//
//                   /// 🔹 BOOK BUTTON
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: booked
//                           ? null
//                           : () {
//                         bookSkill(s['skill_id']);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                         booked ? Colors.grey : Colors.teal,
//                       ),
//                       child: Text(
//                         booked ? "BOOKED" : "BOOK",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewallSkill extends StatefulWidget {
//   const UserViewallSkill({super.key});
//
//   @override
//   State<UserViewallSkill> createState() => _UserViewSkillState();
// }
//
// class _UserViewSkillState extends State<UserViewallSkill> {
//   List skills = [];
//   bool loading = true;
//
//   // Purple to Blue Gradient
//   final LinearGradient _backgroundGradient = LinearGradient(
//     colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     loadSkills();
//   }
//
//   /// 🔹 LOAD WORKER SKILLS
//   Future<void> loadSkills() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_view_all_skill/'),
//         body: {
//           'lid': lid,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData['status'] == 'ok') {
//           setState(() {
//             skills = jsonData['data'];
//             loading = false;
//           });
//         }
//       }
//     } catch (e) {
//       loading = false;
//       _showSnackBar("Error: $e", isError: true);
//     }
//   }
//
//   /// 🔹 BOOK SKILL
//   Future<void> bookSkill(String skillId) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_book_skill/'),
//         body: {
//           'lid': lid,
//           'skill_id': skillId,
//         },
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         _showSnackBar("Booking submitted (Pending)");
//         loadSkills(); // refresh list
//       } else {
//         _showSnackBar("Already booked", isError: true);
//       }
//     } catch (e) {
//       _showSnackBar("Error: $e", isError: true);
//     }
//   }
//
//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: TextStyle(
//             color: isError ? Colors.white : Color(0xFF6A11CB),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: isError ? Colors.redAccent : Colors.white,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         margin: EdgeInsets.all(20),
//         duration: Duration(seconds: 3),
//         elevation: 6,
//         action: SnackBarAction(
//           label: 'OK',
//           textColor: isError ? Colors.white : Color(0xFF6A11CB),
//           onPressed: () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Skills"),
//         backgroundColor: Color(0xFF6A11CB),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: _backgroundGradient),
//         child: loading
//             ? Center(
//           child: CircularProgressIndicator(
//             color: Colors.white,
//           ),
//         )
//             : skills.isEmpty
//             ? Center(
//           child: Container(
//             padding: EdgeInsets.all(30),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 15,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.build_outlined,
//                   size: 60,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "No Skills Available",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "There are no skills available yet",
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//             : Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "All Available Skills",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "${skills.length} ${skills.length == 1 ? 'Skill' : 'Skills'}",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: ListView.builder(
//                   padding: EdgeInsets.all(16),
//                   itemCount: skills.length,
//                   itemBuilder: (context, index) {
//                     final s = skills[index];
//                     bool booked = s['booked'] == true;
//                     return _buildSkillCard(s, booked);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSkillCard(Map<String, dynamic> skill, bool isBooked) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: Color(0xFF6A11CB).withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF6A11CB).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.build_outlined,
//                     color: Color(0xFF6A11CB),
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         skill['skill_name'],
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF6A11CB),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4),
//                       if (isBooked)
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: Colors.orange,
//                               width: 1,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 size: 12,
//                                 color: Colors.orange,
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 "BOOKED",
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Divider(color: Colors.grey[200], height: 1),
//             SizedBox(height: 12),
//             // Description
//             Text(
//               "Description",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 1.0,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               skill['discription'],
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[800],
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 20),
//             // Book Button
//             Align(
//               alignment: Alignment.centerRight,
//               child: SizedBox(
//                 width: 150,
//                 child: ElevatedButton(
//                   onPressed: isBooked
//                       ? null
//                       : () {
//                     bookSkill(skill['skill_id'].toString());
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: isBooked
//                         ? Colors.grey
//                         : Color(0xFF6A11CB),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     elevation: 0,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         isBooked
//                             ? Icons.check_circle_outline
//                             : Icons.bookmark_add_outlined,
//                         size: 18,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         isBooked ? "BOOKED" : "BOOK NOW",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
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

class UserViewallSkill extends StatefulWidget {
  const UserViewallSkill({super.key});

  @override
  State<UserViewallSkill> createState() => _UserViewSkillState();
}

class _UserViewSkillState extends State<UserViewallSkill> {
  List skills = [];
  bool loading = true;

  // Purple to Blue Gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  /// 🔹 LOAD WORKER SKILLS
  Future<void> loadSkills() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final response = await http.post(
        Uri.parse('$url/myapp/user_view_all_skill/'),
        body: {
          'lid': lid,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            skills = jsonData['data'];
            loading = false;
          });
        }
      }
    } catch (e) {
      loading = false;
      _showSnackBar("Error: $e", isError: true);
    }
  }

  /// 🔹 BOOK SKILL
  Future<void> bookSkill(String skillId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final response = await http.post(
        Uri.parse('$url/myapp/user_book_skill/'),
        body: {
          'lid': lid,
          'skill_id': skillId,
        },
      );

      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        _showSnackBar("Booking submitted (Pending)");
        loadSkills(); // refresh list
      } else {
        _showSnackBar("Already booked", isError: true);
      }
    } catch (e) {
      _showSnackBar("Error: $e", isError: true);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Skills"),
        backgroundColor: Color(0xFF6A11CB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: loading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : skills.isEmpty
            ? Center(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.build_outlined,
                  size: 60,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20),
                Text(
                  "No Skills Available",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "There are no skills available yet",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        )
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Available Skills",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${skills.length} ${skills.length == 1 ? 'Skill' : 'Skills'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final s = skills[index];
                    bool booked = s['booked'] == true;
                    return _buildSkillCard(s, booked);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, bool isBooked) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Color(0xFF6A11CB).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Skill Info
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF6A11CB).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.build_outlined,
                    color: Color(0xFF6A11CB),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill['skill_name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6A11CB),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      if (isBooked)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 12,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "BOOKED",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Worker Information Section
            _buildWorkerInfo(skill),

            SizedBox(height: 16),
            Divider(color: Colors.grey[200], height: 1),
            SizedBox(height: 12),

            // Description
            Text(
              "Description",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 6),
            Text(
              skill['discription'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),

            // Book Button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: isBooked
                      ? null
                      : () {
                    bookSkill(skill['skill_id'].toString());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isBooked
                        ? Colors.grey
                        : Color(0xFF6A11CB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isBooked
                            ? Icons.check_circle_outline
                            : Icons.bookmark_add_outlined,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        isBooked ? "BOOKED" : "BOOK NOW",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerInfo(Map<String, dynamic> skill) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF2575FC).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF2575FC).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF2575FC).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: Color(0xFF2575FC),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Worker Information",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  skill['worker_name'] ?? 'Unknown Worker',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2575FC),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        skill['worker_email'] ?? 'No email provided',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}