// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WorkerViewRating extends StatefulWidget {
//   const WorkerViewRating({super.key});
//
//   @override
//   State<WorkerViewRating> createState() => _WorkerViewRatingState();
// }
//
// class _WorkerViewRatingState extends State<WorkerViewRating> {
//   List ratings = [];
//   bool loading = true;
//   String imgurl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadRatings();
//   }
//
//   // ================= LOAD RATINGS =================
//   Future<void> loadRatings() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       imgurl = sh.getString('imgurl')!;
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/worker_view_rating/'),
//         body: {'lid': lid},
//       );
//
//       final jsonData = jsonDecode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           ratings = jsonData['data'];
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
//   // ================= STAR UI =================
//   Widget buildStars(String rating) {
//     double value = double.tryParse(rating) ?? 0;
//
//     return Row(
//       children: List.generate(5, (index) {
//         return Icon(
//           index < value ? Icons.star : Icons.star_border,
//           color: Colors.amber,
//           size: 20,
//         );
//       }),
//     );
//   }
//
//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Ratings"),
//         backgroundColor: Colors.teal,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ratings.isEmpty
//           ? const Center(child: Text("No ratings found"))
//           : ListView.builder(
//         itemCount: ratings.length,
//         itemBuilder: (context, index) {
//           final r = ratings[index];
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ============ USER HEADER ============
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           imgurl + r['photo'],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               r['user'],
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               r['email'],
//                               style: const TextStyle(
//                                   color: Colors.grey),
//                             ),
//                             // Text(
//                             //   r['skill_name'],
//                             //   style: const TextStyle(
//                             //     fontWeight: FontWeight.w600,
//                             //     color: Colors.teal,
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // ============ STAR RATING ============
//                   buildStars(r['rating']),
//
//                   const SizedBox(height: 6),
//
//                   // ============ REVIEW ============
//                   Text(
//                     r['review'],
//                     style: const TextStyle(fontSize: 14),
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Text(
//                       r['date'],
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
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


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerViewRating extends StatefulWidget {
  const WorkerViewRating({super.key});

  @override
  State<WorkerViewRating> createState() => _WorkerViewRatingState();
}

class _WorkerViewRatingState extends State<WorkerViewRating> {
  List ratings = [];
  bool loading = true;
  String imgurl = "";

  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    loadRatings();
  }

  Future<void> loadRatings() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url')!;
      String lid = sh.getString('lid')!;
      imgurl = sh.getString('imgurl')!;

      final response = await http.post(
        Uri.parse('$url/myapp/worker_view_rating/'),
        body: {'lid': lid},
      );

      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          ratings = jsonData['data'];
          loading = false;
        });
      }
    } catch (e) {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Ratings"),
        backgroundColor: Color(0xFF6A11CB),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: loading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : ratings.isEmpty
            ? Center(
          child: Text(
            "No ratings found",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: ratings.length,
          itemBuilder: (context, index) {
            final r = ratings[index];
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            imgurl + r['photo'],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['user'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6A11CB),
                                ),
                              ),
                              Text(
                                r['email'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (starIndex) {
                        double rating = double.tryParse(r['rating']) ?? 0;
                        return Icon(
                          starIndex < rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    SizedBox(height: 8),
                    Text(
                      r['review'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        r['date'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}