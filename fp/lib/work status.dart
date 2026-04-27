//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chat_worker.dart';
//
// class WorkerViewBookingstatus extends StatefulWidget {
//   const WorkerViewBookingstatus({super.key});
//
//   @override
//   State<WorkerViewBookingstatus> createState() => _WorkerViewBookingState();
// }
//
// class _WorkerViewBookingState extends State<WorkerViewBookingstatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid')!;
//     imgurl = sh.getString('imgurl')!;
//
//     final res = await http.post(
//       Uri.parse('$url/myapp/worker_view_booking_request_status/'),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(res.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         bookings = data['data'];
//         loading = false;
//       });
//     }
//   }
//
//   // ================= APPROVE / REJECT =================
//   Future<void> updateBookingStatus(String bookId, String status) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse('$url/myapp/worker_update_booking_status/'),
//       body: {
//         'book_id': bookId,
//         'status': status,
//       },
//     );
//
//     loadBookings();
//   }
//
//   // ================= UPDATE WORK STATUS =================
//   Future<void> updateWorkStatus(String bookId, String workStatus) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse('$url/myapp/worker_update_work_status/'),
//       body: {
//         'book_id': bookId,
//         'work_status': workStatus,
//       },
//     );
//
//     loadBookings();
//   }
//
//   // ================= WORK STATUS POPUP =================
//   void showWorkStatusPopup(String bookId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Update Work Status"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text("Pending"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "pending");
//                 },
//               ),
//               ListTile(
//                 title: const Text("Completed"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "completed");
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ================= OPEN CHAT =================
//   Future<void> openChat(String userId, String userName) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString("aid", userId);       // receiver login id
//     sh.setString("aname", userName);   // receiver name
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const UserWorkerChatt(),
//       ),
//     );
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Requests"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No booking requests"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           bool isPending = b['status'] == 'pending';
//           bool isApproved = b['status'] == 'approved';
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
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           imgurl + b['user_photo'],
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
//                             Text("User : ${b['user_name']}"),
//                             Text("Date : ${b['date']}"),
//                             if (isApproved)
//                               Text(
//                                 "Work Status : ${b['work_status']}",
//                                 style: const TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // ================= ACTION BUTTONS =================
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // ---- APPROVE / REJECT ----
//                       if (isPending) ...[
//                         ElevatedButton(
//                           onPressed: () {
//                             updateBookingStatus(
//                               b['book_id'].toString(),
//                               'approved',
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green),
//                           child: const Text("APPROVE"),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             updateBookingStatus(
//                               b['book_id'].toString(),
//                               'rejected',
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red),
//                           child: const Text("REJECT"),
//                         ),
//                       ],
//
//                       // ---- CHAT + UPDATE WORK ----
//                       if (isApproved) ...[
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             openChat(
//                               b['user_id'].toString(),
//                               b['user_name'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.chat),
//                           label: const Text("CHAT"),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.teal),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             showWorkStatusPopup(
//                               b['book_id'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.update),
//                           label: const Text("UPDATE WORK"),
//                         ),
//                       ],
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

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chat_worker.dart';
//
// class WorkerViewBookingstatus extends StatefulWidget {
//   const WorkerViewBookingstatus({super.key});
//
//   @override
//   State<WorkerViewBookingstatus> createState() =>
//       _WorkerViewBookingState();
// }
//
// class _WorkerViewBookingState extends State<WorkerViewBookingstatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid')!;
//     imgurl = sh.getString('imgurl')!;
//
//     final res = await http.post(
//       Uri.parse('$url/myapp/worker_view_booking_request_status/'),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(res.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         bookings = data['data'];
//         loading = false;
//       });
//     }
//   }
//
//
//
//   // ================= UPDATE WORK STATUS =================
//   Future<void> updateWorkStatus(String bookId, String workStatus) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse('$url/myapp/worker_update_work_status/'),
//       body: {
//         'book_id': bookId,
//         'work_status': workStatus,
//       },
//     );
//
//     loadBookings();
//   }
//
//   // ================= WORK STATUS POPUP =================
//   void showWorkStatusPopup(String bookId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Update Work Status"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text("Pending"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "pending");
//                 },
//               ),
//               ListTile(
//                 title: const Text("Completed"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "completed");
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ================= OPEN CHAT =================
//   Future<void> openChat(String userId, String userName) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString("aid", userId);
//     sh.setString("aname", userName);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const UserWorkerChatt(),
//       ),
//     );
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Requests"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No booking requests"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           bool isApproved = b['status'] == 'approved';
//           bool isPaid = b['status'] == 'paid';
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
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           imgurl + b['user_photo'],
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
//                             Text("User : ${b['user_name']}"),
//                             Text("Date : ${b['date']}"),
//                             Text("status : ${b['status']}"),
//
//                             // ✅ WORK STATUS (approved OR paid)
//                             if (isApproved || isPaid)
//                               Text(
//                                 "Work Status : ${b['work_status']}",
//                                 style: const TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                             // ✅ PAYMENT DETAILS (paid ONLY)
//                             if (isPaid) ...[
//                               const SizedBox(height: 6),
//                               Text(
//                                 "Payment Amount : ₹${b['amount']}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Payment Date : ${b['payment_date']}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // ================= ACTION BUTTONS =================
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.end,
//                     children: [
//
//                       // ---- CHAT + UPDATE WORK (approved ONLY) ----
//                       if (isApproved) ...[
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             openChat(
//                               b['user_id'].toString(),
//                               b['user_name'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.chat),
//                           label: const Text("CHAT"),
//                           style:
//                           ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             showWorkStatusPopup(
//                               b['book_id'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.update),
//                           label:
//                           const Text("UPDATE WORK"),
//                         ),
//                       ],
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

//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chat_worker.dart';
//
// class WorkerViewBookingstatus extends StatefulWidget {
//   const WorkerViewBookingstatus({super.key});
//
//   @override
//   State<WorkerViewBookingstatus> createState() =>
//       _WorkerViewBookingState();
// }
//
// class _WorkerViewBookingState extends State<WorkerViewBookingstatus> {
//   List bookings = [];
//   bool loading = true;
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadBookings();
//   }
//
//   // ================= LOAD BOOKINGS =================
//   Future<void> loadBookings() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String lid = sh.getString('lid')!;
//     imgurl = sh.getString('imgurl')!;
//
//     final res = await http.post(
//       Uri.parse('$url/myapp/worker_view_booking_request_status/'),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(res.body);
//
//     if (data['status'] == 'ok') {
//       setState(() {
//         bookings = data['data'];
//         loading = false;
//       });
//     }
//   }
//
//   // ================= UPDATE WORK STATUS =================
//   Future<void> updateWorkStatus(String bookId, String workStatus) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse('$url/myapp/worker_update_work_status/'),
//       body: {
//         'book_id': bookId,
//         'work_status': workStatus,
//       },
//     );
//
//     loadBookings();
//   }
//
//   // ================= WORK STATUS POPUP =================
//   void showWorkStatusPopup(String bookId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Update Work Status"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text("Pending"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "pending");
//                 },
//               ),
//               ListTile(
//                 title: const Text("Completed"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   updateWorkStatus(bookId, "completed");
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ================= OPEN CHAT =================
//   Future<void> openChat(String userId, String userName) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString("aid", userId);
//     sh.setString("aname", userName);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const UserWorkerChatt(),
//       ),
//     );
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Requests"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : bookings.isEmpty
//           ? const Center(child: Text("No booking requests"))
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final b = bookings[index];
//
//           bool isApproved = b['status'] == 'approved';
//           bool isPaid = b['status'] == 'paid';
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
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           imgurl + b['user_photo'],
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
//                             Text("User : ${b['user_name']}"),
//                             Text("Date : ${b['date']}"),
//                             Text("Status : ${b['status']}"),
//
//                             // ✅ WORK STATUS (approved OR paid)
//                             if (isApproved || isPaid)
//                               Text(
//                                 "Work Status : ${b['work_status']}",
//                                 style: const TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                             // ✅ PAYMENT DETAILS (paid ONLY)
//                             if (isPaid && b['payment'] != null) ...[
//                               const SizedBox(height: 6),
//                               Text(
//                                 "Payment Amount : ₹${b['payment']['amount']}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Payment Date : ${b['payment']['payment_date']}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // ================= ACTION BUTTONS =================
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // ---- CHAT + UPDATE WORK (approved ONLY) ----
//                       if (isApproved) ...[
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             openChat(
//                               b['user_id'].toString(),
//                               b['user_name'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.chat),
//                           label: const Text("CHAT"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             showWorkStatusPopup(
//                               b['book_id'].toString(),
//                             );
//                           },
//                           icon: const Icon(Icons.update),
//                           label:
//                           const Text("UPDATE WORK"),
//                         ),
//                       ],
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'chat (1) (1).dart';
import 'chat_worker.dart';

class WorkerViewBookingstatus extends StatefulWidget {
  const WorkerViewBookingstatus({super.key});

  @override
  State<WorkerViewBookingstatus> createState() =>
      _WorkerViewBookingState();
}

class _WorkerViewBookingState extends State<WorkerViewBookingstatus> {
  List bookings = [];
  bool loading = true;
  String imgurl = "";

  // Purple to Blue Gradient
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

  // ================= LOAD BOOKINGS =================
  Future<void> loadBookings() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    String lid = sh.getString('lid')!;
    imgurl = sh.getString('imgurl')!;

    final res = await http.post(
      Uri.parse('$url/myapp/worker_view_booking_request_status/'),
      body: {'lid': lid},
    );

    final data = jsonDecode(res.body);

    if (data['status'] == 'ok') {
      setState(() {
        bookings = data['data'];
        loading = false;
      });
    }
  }

  // ================= UPDATE WORK STATUS =================
  Future<void> updateWorkStatus(String bookId, String workStatus) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;

    await http.post(
      Uri.parse('$url/myapp/worker_update_work_status/'),
      body: {
        'book_id': bookId,
        'work_status': workStatus,
      },
    );

    loadBookings();
  }

  // ================= WORK STATUS POPUP =================
  void showWorkStatusPopup(String bookId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Update Work Status",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6A11CB),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusOption(
                "Pending",
                Icons.access_time_outlined,
                Colors.orange,
                    () {
                  Navigator.pop(context);
                  updateWorkStatus(bookId, "pending");
                },
              ),
              SizedBox(height: 12),
              _buildStatusOption(
                "Completed",
                Icons.check_circle_outline,
                Colors.green,
                    () {
                  Navigator.pop(context);
                  updateWorkStatus(bookId, "completed");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= OPEN CHAT =================
  // Future<void> openChat(String userId, String userName) async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   sh.setString("aid", userId);
  //   sh.setString("aname", userName);
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const UserWorkerChatt(),
  //     ),
  //   );
  // }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Status"),
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
            : bookings.isEmpty
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
                  Icons.assignment_turned_in_outlined,
                  size: 60,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20),
                Text(
                  "No Work Requests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You don't have any work status to view",
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
                    "Work Status",
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
                    bool isApproved = b['status'] == 'approved';
                    bool isPaid = b['status'] == 'paid';
                    return _buildBookingCard(b, isApproved, isPaid);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(
      Map<String, dynamic> booking, bool isApproved, bool isPaid) {
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
            // Header Row
            Row(
              children: [
                // User Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF6A11CB).withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      imgurl + booking['user_photo'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF6A11CB).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF6A11CB),
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['skill_name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6A11CB),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Requested by: ${booking['user_name']}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(booking['status']),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    booking['status'].toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(booking['status']),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: Colors.grey[200], height: 1),
            SizedBox(height: 16),
            // Details Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              children: [
                _buildDetailItem(
                  icon: Icons.calendar_today_outlined,
                  label: "Booking Date",
                  value: booking['date'],
                ),
                _buildDetailItem(
                  icon: Icons.access_time_outlined,
                  label: "Work Status",
                  value: (isApproved || isPaid) ? booking['work_status'] : 'N/A',
                  valueColor: (isApproved || isPaid)
                      ? _getWorkStatusColor(booking['work_status'])
                      : Colors.grey,
                ),
                if (isPaid && booking['payment'] != null) ...[
                  _buildDetailItem(
                    icon: Icons.currency_rupee_outlined,
                    label: "Amount",
                    value: "₹${booking['payment']['amount']}",
                    valueColor: Colors.green,
                  ),
                  _buildDetailItem(
                    icon: Icons.date_range_outlined,
                    label: "Payment Date",
                    value: booking['payment']['payment_date'],
                    valueColor: Colors.green,
                  ),
                ],
              ],
            ),
            SizedBox(height: 16),
            // Action Buttons (only for approved)
            if (isApproved) ...[
              Divider(color: Colors.grey[200], height: 1),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    // onPressed: ()
                    //
                    // {
                    //   openChat(
                    //     booking['user_id'].toString(),
                    //     booking['user_name'].toString(),
                    //   );
                    // },
                    onPressed: () async {
                      try {
                        Fluttertoast.showToast(msg: "Chat with ID: ${booking['user_id'].toString()}");
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString('clid', booking['user_id'].toString()); // Ensure lid is a string
                        sh.setString('name', booking['user_name'].toString()); // Ensure lid is a string
                        // Navigate to the ChatScreen and pass the tutor ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Workjer_User_Chat(title: ''),
                          ),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Error: $e");
                      }
                    },





                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6A11CB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat_outlined, size: 18),
                        SizedBox(width: 6),
                        Text("CHAT"),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      showWorkStatusPopup(booking['book_id'].toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2575FC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.update_outlined, size: 18),
                        SizedBox(width: 6),
                        Text("UPDATE WORK"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey[600]),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? Colors.grey[800],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusOption(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'paid':
        return Colors.green;
      case 'rejected':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Color _getWorkStatusColor(String workStatus) {
    switch (workStatus) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}