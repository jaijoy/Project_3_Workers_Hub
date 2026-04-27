// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WorkerSkillView extends StatefulWidget {
//   const WorkerSkillView({Key? key}) : super(key: key);
//
//   @override
//   State<WorkerSkillView> createState() => _WorkerSkillViewState();
// }
//
// class _WorkerSkillViewState extends State<WorkerSkillView> {
//   List skills = [];
//   bool loading = true;
//
//   Future<void> fetchSkills() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//
//     var response = await http.post(
//       Uri.parse("$url/myapp/worker_skill_view"),
//       body: {"lid": lid},
//     );
//
//     var data = jsonDecode(response.body);
//     if (data['status'] == 'ok') {
//       setState(() {
//         skills = data['data'];
//         loading = false;
//       });
//     }
//   }
//
//   Future<void> deleteSkill(String sid) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//
//     await http.post(
//       Uri.parse("$url/myapp/worker_skill_delete"),
//       body: {"sid": sid},
//     );
//
//     fetchSkills();
//   }
//
//   void editDialog(String sid, String skill, String desc) {
//     TextEditingController skillCtrl =
//     TextEditingController(text: skill);
//     TextEditingController descCtrl =
//     TextEditingController(text: desc);
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit Skill"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: skillCtrl,
//               decoration: const InputDecoration(
//                 labelText: "Skill Name",
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: descCtrl,
//               decoration: const InputDecoration(
//                 labelText: "Description",
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             child: const Text("Update"),
//             onPressed: () async {
//               SharedPreferences sh =
//               await SharedPreferences.getInstance();
//               String url = sh.getString('url') ?? '';
//
//               await http.post(
//                 Uri.parse("$url/myapp/worker_skill_edit"),
//                 body: {
//                   "sid": sid,
//                   "skill_name": skillCtrl.text.trim(),
//                   "discription": descCtrl.text.trim(),
//                 },
//               );
//
//               Navigator.pop(context);
//               fetchSkills();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSkills();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Skills"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : skills.isEmpty
//           ? const Center(child: Text("No skills added"))
//           : ListView.builder(
//         itemCount: skills.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             child: ListTile(
//               title: Text(
//                 skills[index]['skill_name'],
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold),
//               ),
//               subtitle:
//               Text(skills[index]['discription']),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit,
//                         color: Colors.blue),
//                     onPressed: () {
//                       editDialog(
//                         skills[index]['id'].toString(),
//                         skills[index]['skill_name'],
//                         skills[index]['discription'],
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete,
//                         color: Colors.red),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title:
//                           const Text("Delete Skill"),
//                           content: const Text(
//                               "Are you sure?"),
//                           actions: [
//                             TextButton(
//                               onPressed: () =>
//                                   Navigator.pop(context),
//                               child:
//                               const Text("Cancel"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 deleteSkill(skills[index]
//                                 ['id']
//                                     .toString());
//                               },
//                               child:
//                               const Text("Delete"),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
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


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerSkillView extends StatefulWidget {
  const WorkerSkillView({Key? key}) : super(key: key);

  @override
  State<WorkerSkillView> createState() => _WorkerSkillViewState();
}

class _WorkerSkillViewState extends State<WorkerSkillView> {
  List skills = [];
  bool loading = true;

  // Purple to Blue Gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  Future<void> fetchSkills() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';

    var response = await http.post(
      Uri.parse("$url/myapp/worker_skill_view"),
      body: {"lid": lid},
    );

    var data = jsonDecode(response.body);
    if (data['status'] == 'ok') {
      setState(() {
        skills = data['data'];
        loading = false;
      });
    }
  }

  Future<void> deleteSkill(String sid) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';

    await http.post(
      Uri.parse("$url/myapp/worker_skill_delete"),
      body: {"sid": sid},
    );

    fetchSkills();
  }

  void editDialog(String sid, String skill, String desc) {
    TextEditingController skillCtrl = TextEditingController(text: skill);
    TextEditingController descCtrl = TextEditingController(text: desc);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "Edit Skill",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6A11CB),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogField(
              controller: skillCtrl,
              label: "SKILL NAME",
              hint: "Enter skill name",
              icon: Icons.build_outlined,
            ),
            const SizedBox(height: 20),
            _buildDialogField(
              controller: descCtrl,
              label: "DESCRIPTION",
              hint: "Enter description",
              icon: Icons.description_outlined,
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6A11CB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("UPDATE"),
            onPressed: () async {
              SharedPreferences sh = await SharedPreferences.getInstance();
              String url = sh.getString('url') ?? '';

              await http.post(
                Uri.parse("$url/myapp/worker_skill_edit"),
                body: {
                  "sid": sid,
                  "skill_name": skillCtrl.text.trim(),
                  "discription": descCtrl.text.trim(),
                },
              );

              Navigator.pop(context);
              fetchSkills();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Skills"),
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
                  "No Skills Added",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Add your first skill to get started",
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
                    "Your Skills",
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
                    return _buildSkillCard(
                      id: skills[index]['id'].toString(),
                      skillName: skills[index]['skill_name'],
                      description: skills[index]['discription'],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard({
    required String id,
    required String skillName,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF6A11CB).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.build_outlined,
                          color: Color(0xFF6A11CB),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          skillName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6A11CB),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xFF6A11CB), size: 20),
                          SizedBox(width: 8),
                          Text("Edit"),
                        ],
                      ),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.redAccent, size: 20),
                          SizedBox(width: 8),
                          Text("Delete"),
                        ],
                      ),
                      value: 'delete',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      editDialog(id, skillName, description);
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            "Delete Skill",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.redAccent,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to delete this skill?",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                deleteSkill(id);
                              },
                              child: const Text("DELETE"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey[200], height: 1),
            SizedBox(height: 12),
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
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
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
              child: TextField(
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
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}