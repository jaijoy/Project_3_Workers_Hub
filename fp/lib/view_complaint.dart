// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'complaint.dart';
//
//
// class workerComplaintView extends StatefulWidget {
//   const workerComplaintView({super.key});
//
//   @override
//   State<workerComplaintView> createState() =>
//       _ComplaintViewState();
// }
//
// class _ComplaintViewState extends State<workerComplaintView> {
//   List complaints = [];
//   bool isLoading = true;
//
//   // 🔹 Fetch complaint data from Django
//   Future<void> fetchComplaints() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final response = await http.post(
//         Uri.parse("$urls/myapp/worker_complaint_view/"),
//         body: {'lid': lid},
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//
//         if (jsonData['status'] == 'ok') {
//           setState(() {
//             complaints = jsonData['data'];
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//             complaints = [];
//           });
//         }
//       } else {
//         throw Exception('Failed to load complaints');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchComplaints();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("View Complaints"),
//         backgroundColor: Colors.blue,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : complaints.isEmpty
//           ? const Center(child: Text("No complaints found"))
//           : RefreshIndicator(
//         onRefresh: fetchComplaints,
//         child: ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: complaints.length,
//           itemBuilder: (context, index) {
//             final item = complaints[index];
//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Date: ${item['date']}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "Complaint:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(item['complaint']),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Reply:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       item['reply'].isNotEmpty
//                           ? item['reply']
//                           : "No reply yet",
//                       style: TextStyle(
//                         color: item['reply'].isNotEmpty
//                             ? Colors.black
//                             : Colors.redAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Go to Add Complaint Page
//           bool? added = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const workerComplaintForm()),
//           );
//
//           if (added == true) {
//             fetchComplaints(); // refresh list when a new complaint is added
//           }
//         },
//         backgroundColor: Colors.blue,
//         child: const Icon(Icons.add_comment),
//       ),
//     );
//   }
// }


// def user_complaint_view(request):
// login_id = request.POST["lid"]
// user = user_Tbl.objects.get(LOGIN=login_id)
// data = complaint_Tbll.objects.filter(LOGIN=user.LOGIN)
// l=[]
// for i in data:
// l.append({
// 'id': i.id,
// 'date': str(i.date),
// 'complaint': str(i.complaint),
// 'reply': str(i.reply)
// })
//
// return JsonResponse({'status': 'ok','data':l})



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'complaint.dart';

class workerComplaintView extends StatefulWidget {
  const workerComplaintView({super.key});

  @override
  State<workerComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<workerComplaintView> {
  List complaints = [];
  bool isLoading = true;

  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  Future<void> fetchComplaints() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final response = await http.post(
        Uri.parse("$urls/myapp/worker_complaint_view/"),
        body: {'lid': lid},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            complaints = jsonData['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            complaints = [];
          });
        }
      } else {
        throw Exception('Failed to load complaints');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint Status"),
        backgroundColor: Color(0xFF6A11CB),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : complaints.isEmpty
            ? Center(
          child: Text(
            "No complaints found",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            final item = complaints[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${item['date']}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['complaint'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(height: 1),
                    SizedBox(height: 12),
                    Text(
                      item['reply'].isNotEmpty
                          ? "Reply: ${item['reply']}"
                          : "No reply yet",
                      style: TextStyle(
                        color: item['reply'].isNotEmpty
                            ? Colors.green[700]
                            : Colors.orange[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const workerComplaintForm()),
          );
          fetchComplaints();
        },
        backgroundColor: Color(0xFF6A11CB),
        child: Icon(Icons.add),
      ),
    );
  }
}