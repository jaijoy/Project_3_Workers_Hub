//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WorkerViewBooking extends StatefulWidget {
//   const WorkerViewBooking({super.key});
//
//   @override
//   State<WorkerViewBooking> createState() => _WorkerViewBookingState();
// }
//
// class _WorkerViewBookingState extends State<WorkerViewBooking> {
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
//   // 🔹 LOAD BOOKINGS
//   Future<void> loadBookings() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     imgurl = sh.getString('imgurl')!;
//     String lid = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse('$url/myapp/worker_view_booking_request/'),
//       body: {'lid': lid},
//     );
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       setState(() {
//         bookings = jsonData['data'];
//         loading = false;
//       });
//     }
//   }
//
//   // 🔹 ACCEPT / REJECT BOOKING
//   Future<void> updateStatus(String bookId, String status) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     print(url);
//     print('url===============');
//     print('url===============');
//     print('url===============');
//     print('url===============');
//
//     final response = await http.post(
//       Uri.parse('$url/myapp/worker_update_booking_status/'),
//       body: {
//         'book_id': bookId,
//         'status': status,
//       },
//     );
//
//     final res = jsonDecode(response.body);
//
//     if (res['status'] == 'ok') {
//       loadBookings();
//     }
//   }
//
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
//           bool isPending = b['status'] == 'pending';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 🔹 USER PHOTO
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                       imgurl + b['user_photo'],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//
//                   // 🔹 DETAILS
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
//                         Text("User : ${b['user_name']}"),
//                         Text("Date : ${b['date']}"),
//                         const SizedBox(height: 12),
//
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: isPending
//                               ? Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   updateStatus(
//                                       b['book_id'],
//                                       'approved');
//                                 },
//                                 style:
//                                 ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                   Colors.green,
//                                 ),
//                                 child:
//                                 const Text("APPROVE"),
//                               ),
//                               const SizedBox(width: 10),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   updateStatus(
//                                       b['book_id'],
//                                       'rejected');
//                                 },
//                                 style:
//                                 ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                   Colors.red,
//                                 ),
//                                 child:
//                                 const Text("REJECT"),
//                               ),
//                             ],
//                           )
//                               : Chip(
//                             label: Text(
//                               b['status']
//                                   .toUpperCase(),
//                               style: const TextStyle(
//                                   color: Colors.white),
//                             ),
//                             backgroundColor:
//                             b['status'] ==
//                                 'approved'
//                                 ? Colors.green
//                                 : Colors.red,
//                           ),
//                         ),
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerViewBooking extends StatefulWidget {
  const WorkerViewBooking({super.key});

  @override
  State<WorkerViewBooking> createState() => _WorkerViewBookingState();
}

class _WorkerViewBookingState extends State<WorkerViewBooking> {
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

  // 🔹 LOAD BOOKINGS
  Future<void> loadBookings() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    imgurl = sh.getString('imgurl')!;
    String lid = sh.getString('lid')!;

    final response = await http.post(
      Uri.parse('$url/myapp/worker_view_booking_request/'),
      body: {'lid': lid},
    );

    final jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      setState(() {
        bookings = jsonData['data'];
        loading = false;
      });
    }
  }

  // 🔹 ACCEPT / REJECT BOOKING
  Future<void> updateStatus(String bookId, String status) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;

    final response = await http.post(
      Uri.parse('$url/myapp/worker_update_booking_status/'),
      body: {
        'book_id': bookId,
        'status': status,
      },
    );

    final res = jsonDecode(response.body);

    if (res['status'] == 'ok') {
      loadBookings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Requests"),
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
                  Icons.assignment_outlined,
                  size: 60,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20),
                Text(
                  "No Booking Requests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You don't have any work requests yet",
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
                    "Work Requests",
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
                      "${bookings.length} ${bookings.length == 1 ? 'Request' : 'Requests'}",
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
                    bool isPending = b['status'] == 'pending';
                    return _buildBookingCard(b, isPending);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, bool isPending) {
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
                        booking['user_name'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isPending
                        ? Colors.orange.withOpacity(0.1)
                        : booking['status'] == 'approved'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isPending
                          ? Colors.orange
                          : booking['status'] == 'approved'
                          ? Colors.green
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    booking['status'].toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isPending
                          ? Colors.orange
                          : booking['status'] == 'approved'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: Colors.grey[200], height: 1),
            SizedBox(height: 16),
            // Details Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(
                  icon: Icons.calendar_today_outlined,
                  label: "Date",
                  value: booking['date'],
                ),
                _buildDetailItem(
                  icon: Icons.access_time_outlined,
                  label: "Status",
                  value: booking['status'].toUpperCase(),
                  valueColor: isPending
                      ? Colors.orange
                      : booking['status'] == 'approved'
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Action Buttons (only for pending)
            if (isPending) ...[
              Divider(color: Colors.grey[200], height: 1),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmDialog(
                        booking['book_id'].toString(),
                        'approved',
                        'Approve Request',
                        'Are you sure you want to approve this work request?',
                        Colors.green,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, size: 18),
                        SizedBox(width: 6),
                        Text("APPROVE"),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmDialog(
                        booking['book_id'].toString(),
                        'rejected',
                        'Reject Request',
                        'Are you sure you want to reject this work request?',
                        Colors.redAccent,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel_outlined, size: 18),
                        SizedBox(width: 6),
                        Text("REJECT"),
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
            Icon(icon, size: 16, color: Colors.grey[600]),
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

  void _showConfirmDialog(
      String bookId,
      String status,
      String title,
      String message,
      Color accentColor,
      ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              status == 'approved'
                  ? Icons.check_circle_outline
                  : Icons.cancel_outlined,
              color: accentColor,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: accentColor,
              ),
            ),
          ],
        ),
        content: Text(
          message,
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
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              updateStatus(bookId, status);
            },
            child: Text(
              status == 'approved' ? "APPROVE" : "REJECT",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}