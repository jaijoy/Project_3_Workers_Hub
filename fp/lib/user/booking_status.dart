// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() => _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // 🔹 LOAD USER BOOKINGS
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           bookings = jsonData['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
//
//   Color statusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings yet"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   // 🔹 WORKER PHOTO
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundImage: NetworkImage(
//                       '$imgurl${b['worker_photo']}',
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           b['skill_name'],
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text("Worker : ${b['worker_name']}"),
//                         Text("Date   : ${b['date']}"),
//                         const SizedBox(height: 6),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Chip(
//                             label: Text(
//                               b['status'].toUpperCase(),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             backgroundColor: statusColor(b['status']),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
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
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() => _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   /// 🔹 Load bookings from server
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           bookings = jsonData['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
//
//   /// 🔹 Update work status request
//   Future<void> updateWorkStatus(String bookingId, String status) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/update_work_status/'),
//         body: {
//           'lid': lid,
//           'booking_id': bookingId,
//
//         },
//       );
//
//       final jsonData = jsonDecode(response.body);
//       if (jsonData['status'] == 'ok') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Work status updated to $status")),
//         );
//         loadBookings(); // Refresh the list
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Failed to update status")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
//
//   /// 🔹 Show dropdown dialog for updating work status
//   void showDropdownStatusDialog(String bookingId, String currentStatus) {
//     String selectedStatus = currentStatus;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Update Work Status"),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return DropdownButton<String>(
//                 value: selectedStatus,
//                 items: ['Pending', 'Completed']
//                     .map((e) => DropdownMenuItem(
//                   value: e,
//                   child: Text(e),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedStatus = value!;
//                   });
//                 },
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 updateWorkStatus(bookingId, selectedStatus);
//               },
//               child: const Text("Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Color statusColor(String status) {
//     if (status.toLowerCase() == 'approved') return Colors.green;
//     if (status.toLowerCase() == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings yet"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//           bool approved = b['status'].toLowerCase() == 'approved';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage:
//                         NetworkImage('$imgurl${b['worker_photo']}'),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text("Worker: ${b['worker_name']}"),
//                             Text("Date: ${b['date']}"),
//                             const SizedBox(height: 4),
//                             Text("Work Status: ${b['work_status']}"),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: statusColor(b['status']),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   if (approved)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text(
//                                         "Chat feature not implemented")));
//                           },
//                           icon: const Icon(Icons.chat),
//                           label: const Text("Chat"),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue),
//                         ),
//                         const SizedBox(width: 10),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             showDropdownStatusDialog(
//                                 b['booking_id'], b['work_status']);
//                           },
//                           icon: const Icon(Icons.update),
//                           label: const Text("Update Status"),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange),
//                         ),
//                       ],
//                     ),
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
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() => _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   /// 🔹 LOAD BOOKINGS
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(res.body);
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookings = data['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   /// 🔹 UPDATE WORK STATUS
//   Future<void> updateWorkStatus(String bookingId, String workStatus) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/update_work_status/'),
//         body: {
//           'booking_id': bookingId,
//           'work_status': workStatus,
//           'lid': lid,
//         },
//       );
//
//       final data = jsonDecode(res.body);
//       if (data['status'] == 'ok') {
//         loadBookings(); // refresh UI
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Update failed")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   Color bookingStatusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//           bool approved = b['status'] == 'approved';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                           '$imgurl${b['worker_photo']}',
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text("Worker: ${b['worker_name']}"),
//                             Text("Date: ${b['date']}"),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor:
//                         bookingStatusColor(b['status']),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   /// 🔹 WORK STATUS DROPDOWN (ONLY IF APPROVED)
//                   if (approved)
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Work Status",
//                           style:
//                           TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         DropdownButton<String>(
//                           value: b['work_status'],
//                           items: const [
//                             DropdownMenuItem(
//                               value: 'pending',
//                               child: Text("Pending"),
//                             ),
//                             DropdownMenuItem(
//                               value: 'completed',
//                               child: Text("Completed"),
//                             ),
//                           ],
//                           onChanged: (value) {
//                             if (value != null &&
//                                 value != b['work_status']) {
//                               updateWorkStatus(
//                                   b['booking_id'], value);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//
//                   const SizedBox(height: 8),
//
//                   /// 🔹 CHAT BUTTON
//                   if (approved)
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content:
//                                 Text("Chat not implemented")),
//                           );
//                         },
//                         icon: const Icon(Icons.chat),
//                         label: const Text("Chat"),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue),
//                       ),
//                     ),
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
//
//
//
//
//


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() =>
//       _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   /// 🔹 LOAD BOOKINGS
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(res.body);
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookings = data['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   /// 🔹 UPDATE WORK STATUS
//   Future<void> updateWorkStatus(
//       int index, String bookingId, String newStatus) async {
//
//     String oldStatus = bookings[index]['work_status'];
//
//     // 🔹 INSTANT UI UPDATE
//     setState(() {
//       bookings[index]['work_status'] = newStatus;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/update_work_status/'),
//         body: {
//           'booking_id': bookingId,
//           'work_status': newStatus,
//           'lid': lid,
//         },
//       );
//
//       final data = jsonDecode(res.body);
//
//       if (data['status'] != 'ok') {
//         // 🔹 REVERT IF FAILED
//         setState(() {
//           bookings[index]['work_status'] = oldStatus;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Update failed")),
//         );
//       }
//     } catch (e) {
//       // 🔹 REVERT ON ERROR
//       setState(() {
//         bookings[index]['work_status'] = oldStatus;
//       });
//
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   Color bookingStatusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//           bool approved = b['status'] == 'approved';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                           '$imgurl${b['worker_photo']}',
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text("Worker: ${b['worker_name']}"),
//                             Text("Date: ${b['date']}"),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(
//                               color: Colors.white),
//                         ),
//                         backgroundColor:
//                         bookingStatusColor(b['status']),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   /// 🔹 WORK STATUS DROPDOWN
//                   if (approved)
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Work Status",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold),
//                         ),
//                         DropdownButton<String>(
//                           value: b['work_status'],
//                           items: const [
//                             DropdownMenuItem(
//                               value: 'pending',
//                               child: Text("Pending"),
//                             ),
//                             DropdownMenuItem(
//                               value: 'completed',
//                               child: Text("Completed"),
//                             ),
//                           ],
//                           onChanged: (value) {
//                             if (value != null &&
//                                 value != b['work_status']) {
//                               updateWorkStatus(
//                                 index,
//                                 b['booking_id'],
//                                 value,
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//
//                   const SizedBox(height: 8),
//
//                   /// 🔹 CHAT BUTTON
//                   if (approved)
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(
//                             const SnackBar(
//                                 content: Text(
//                                     "Chat not implemented")),
//                           );
//                         },
//                         icon: const Icon(Icons.chat),
//                         label: const Text("Chat"),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue),
//                       ),
//                     ),
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
// import 'chat.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() =>
//       _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(res.body);
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookings = data['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   Color bookingStatusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//           bool approved = b['status'] == 'approved';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   // ================= HEADER =================
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                           '$imgurl${b['worker_photo']}',
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text("Worker : ${b['worker_name']}"),
//                             Text("Date : ${b['date']}"),
//                             Text(
//                               "Work Status : ${b['work_status']}",
//                             ),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         backgroundColor:
//                         bookingStatusColor(b['status']),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // ================= CHAT BUTTON =================
//                   if (approved)
//                     ElevatedButton.icon(
//                       onPressed: () async {
//                         SharedPreferences sh =
//                         await SharedPreferences.getInstance();
//
//                         sh.setString(
//                             "aid",
//                             b['worker_login_id'].toString());
//                         sh.setString(
//                             "aname",
//                             b['worker_name'].toString());
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                             const UserWorkerChat(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.chat),
//                       label: const Text("Chat"),
//                     ),
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
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chat.dart';
// import 'payment_page.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() =>
//       _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(res.body);
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookings = data['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   Color bookingStatusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           bool approved = b['status'] == 'approved';
//           bool completed = b['work_status'] == 'completed';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ================= HEADER =================
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                           '$imgurl${b['worker_photo']}',
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text("Worker : ${b['worker_name']}"),
//                             Text("Date : ${b['date']}"),
//
//                             // ✅ SHOW WORK STATUS ONLY AFTER APPROVAL
//                             if (approved)
//                               Text(
//                                 "Work Status : ${b['work_status']}",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor:
//                         bookingStatusColor(b['status']),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // ================= ACTION BUTTONS =================
//                   if (approved)
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         // CHAT
//                         ElevatedButton.icon(
//                           onPressed: () async {
//                             SharedPreferences sh =
//                             await SharedPreferences.getInstance();
//                             sh.setString(
//                                 "aid",
//                                 b['worker_login_id'].toString());
//                             sh.setString(
//                                 "aname",
//                                 b['worker_name'].toString());
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                 const UserWorkerChat(),
//                               ),
//                             );
//                           },
//                           icon: const Icon(Icons.chat),
//                           label: const Text("Chat"),
//                         ),
//
//                         // PAYMENT BUTTON (ONLY IF COMPLETED)
//                         if (completed)
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => PaymentPage(
//                                     bookingId:
//                                     b['booking_id'].toString(),
//                                     workerName: b['worker_name'],
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.payment),
//                             label: const Text("Pay Now"),
//                           ),
//                       ],
//                     ),
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
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fp/user/rating_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chat.dart';
// import 'payment_page.dart';
//
// class UserViewBookingStatus extends StatefulWidget {
//   const UserViewBookingStatus({super.key});
//
//   @override
//   State<UserViewBookingStatus> createState() =>
//       _UserViewBookingStatusState();
// }
//
// class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final res = await http.post(
//         Uri.parse('$url/myapp/user_view_booking_status/'),
//         body: {'lid': lid},
//       );
//
//       final data = jsonDecode(res.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookings = data['data'];
//           loading = false;
//         });
//       }
//     } catch (e) {
//       loading = false;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   Color bookingStatusColor(String status) {
//     if (status == 'approved') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     if (status == 'paid') return Colors.blue;
//     return Colors.orange;
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Bookings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           bool approved = b['status'] == 'approved';
//           bool paid = b['status'] == 'paid';
//           bool completed =
//               b['work_status'] == 'completed';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   // ================= HEADER =================
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                           '$imgurl${b['worker_photo']}',
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               b['skill_name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight:
//                                 FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                                 "Worker : ${b['worker_name']}"),
//                             Text("Date : ${b['date']}"),
//
//                             // WORK STATUS (approved or paid)
//                             if (approved || paid)
//                               Text(
//                                 "Work Status : ${b['work_status']}",
//                                 style: const TextStyle(
//                                   fontWeight:
//                                   FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       Chip(
//                         label: Text(
//                           b['status'].toUpperCase(),
//                           style: const TextStyle(
//                               color: Colors.white),
//                         ),
//                         backgroundColor:
//                         bookingStatusColor(
//                             b['status']),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 14),
//
//                   // ================= ACTION BUTTONS =================
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       // 💬 CHAT (ONLY APPROVED & NOT PAID)
//                       if (approved && !paid)
//                         ElevatedButton.icon(
//                           onPressed: () async {
//                             SharedPreferences sh =
//                             await SharedPreferences
//                                 .getInstance();
//                             sh.setString(
//                                 "aid",
//                                 b['worker_login_id']
//                                     .toString());
//                             sh.setString(
//                                 "aname",
//                                 b['worker_name']
//                                     .toString());
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                 const UserWorkerChat(),
//                               ),
//                             );
//                           },
//                           icon:
//                           const Icon(Icons.chat),
//                           label: const Text("Chat"),
//                         ),
//
//                       // 💰 PAY (ONLY COMPLETED & NOT PAID)
//                       if (completed && !paid)
//                         ElevatedButton.icon(
//                           style:
//                           ElevatedButton.styleFrom(
//                             backgroundColor:
//                             Colors.green,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     PaymentPage(
//                                       bookingId:
//                                       b['booking_id']
//                                           .toString(),
//                                       workerName:
//                                       b['worker_name'],
//                                     ),
//                               ),
//                             );
//                           },
//                           icon: const Icon(
//                               Icons.payment),
//                           label:
//                           const Text("Pay Now"),
//                         ),
//
//                       // ⭐ RATING (ONLY PAID)
//                       if (paid)
//                         ElevatedButton.icon(
//                           style:
//                           ElevatedButton.styleFrom(
//                             backgroundColor:
//                             Colors.orange,
//                           ),
//                           onPressed: () async {
//                             SharedPreferences sh =
//                             await SharedPreferences
//                                 .getInstance();
//
//                             sh.setString(
//                               "rating_book_id",
//                               b['booking_id']
//                                   .toString(),
//                             );
//
//                             // Navigate to rating screen if needed
//                             Navigator.push(context,
//                               MaterialPageRoute(builder: (_) => ProductRatingPage()));
//                           },
//                           icon:
//                           const Icon(Icons.star),
//                           label:
//                           const Text("Rate"),
//                         ),
//                     ],
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
import 'package:fp/user/rating_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';
import 'payment_page.dart';

class UserViewBookingStatus extends StatefulWidget {
  const UserViewBookingStatus({super.key});

  @override
  State<UserViewBookingStatus> createState() =>
      _UserViewBookingStatusState();
}

class _UserViewBookingStatusState extends State<UserViewBookingStatus> {
  List bookings = [];
  bool loading = true;
  String imgurl = '';

  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url')!;
      String lid = sh.getString('lid')!;
      imgurl = sh.getString('imgurl')!;

      final res = await http.post(
        Uri.parse('$url/myapp/user_view_booking_status/'),
        body: {'lid': lid},
      );

      final data = jsonDecode(res.body);

      if (data['status'] == 'ok') {
        setState(() {
          bookings = data['data'];
          loading = false;
        });
      }
    } catch (e) {
      loading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Color bookingStatusColor(String status) {
    if (status == 'approved') return Colors.green;
    if (status == 'rejected') return Colors.red;
    if (status == 'paid') return Colors.blue;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: Color(0xFF6A11CB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: loading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : bookings.isEmpty
            ? const Center(child: Text("No bookings found", style: TextStyle(color: Colors.white)))
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking Status",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${bookings.length} ${bookings.length == 1 ? 'Booking' : 'Bookings'}",
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
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final b = bookings[index];
                    bool approved = b['status'] == 'approved';
                    bool paid = b['status'] == 'paid';
                    bool completed = b['work_status'] == 'completed';

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
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Color(0xFF6A11CB).withOpacity(0.1),
                                  child: b['worker_photo'] != null && b['worker_photo'].toString().isNotEmpty
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.network(
                                      '$imgurl${b['worker_photo']}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Color(0xFF6A11CB),
                                        );
                                      },
                                    ),
                                  )
                                      : Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color(0xFF6A11CB),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        b['skill_name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF6A11CB),
                                        ),
                                      ),
                                      Text("Worker : ${b['worker_name']}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                      Text("Date : ${b['date']}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                      if (approved || paid)
                                        Text(
                                          "Work Status : ${b['work_status']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF2575FC),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: bookingStatusColor(b['status']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: bookingStatusColor(b['status']),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    b['status'].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: bookingStatusColor(b['status']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (approved && !paid)
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sh = await SharedPreferences.getInstance();
                                      sh.setString("aid", b['worker_login_id'].toString());
                                      sh.setString("aname", b['worker_name'].toString());
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserWorkerChat()));
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF6A11CB).withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.chat, color: Colors.white, size: 18),
                                            SizedBox(width: 6),
                                            Text("Chat", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (completed && !paid)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentPage(
                                            bookingId: b['booking_id'].toString(),
                                            workerName: b['worker_name'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.green, Color(0xFF10B981)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.green.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.payment, color: Colors.white, size: 18),
                                            SizedBox(width: 6),
                                            Text("Pay Now", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (paid)
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sh = await SharedPreferences.getInstance();
                                      sh.setString("rating_book_id", b['booking_id'].toString());
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductRatingPage()));
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.orange, Color(0xFFFF9800)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.orange.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star, color: Colors.white, size: 18),
                                            SizedBox(width: 6),
                                            Text("Rate", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
}