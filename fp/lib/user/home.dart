//
//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fp/user/feedback.dart';
// import 'package:fp/user/user%20complaint.dart';
// import 'package:fp/user/user%20view%20all%20skills.dart';
// import 'package:fp/user/user_view_complaint.dart';
// import 'package:fp/user/user_view_worker.dart';
// import 'package:fp/view_complaint.dart';
// import 'package:fp/worker_skill_add.dart';
// import 'package:fp/worker_skill_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../loginn.dart';
// import 'booking_status.dart';
//
// class UserHomepage extends StatefulWidget {
//   const UserHomepage({Key? key}) : super(key: key);
//
//   @override
//   State<UserHomepage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<UserHomepage> {
//   String? name = '';
//   String? email = '';
//   String? photo = '';
//   String? imgurl = '';
//   int _currentCarouselIndex = 0;
//
//   // Sample carousel images - replace with your actual images
//   // final List<String> carouselImageUrls = [
//   //   'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//   //   'https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//   //   'https://images.unsplash.com/photo-1576675466969-38eeae4b41f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//   // ];
//
//   final List<String> carouselImageUrls = [
//     'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//     'https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//     // 'https://images.unsplash.com/photo-1576675466969-38eeae4b41f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//     'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80', // Appliance repair
//
//   ];
//
//   // Navigation cards data for user
//   final List<Map<String, dynamic>> navigationCards = [
//     {
//       'icon': Icons.build_circle_outlined,
//       'title': 'View Skills',
//       'color': Color(0xFF6A11CB),
//       'route': UserViewallSkill(),
//     },
//     {
//       'icon': Icons.people_outline,
//       'title': 'View Workers',
//       'color': Color(0xFF2575FC),
//       'route': UserViewWorker(),
//     },
//     {
//       'icon': Icons.assignment_outlined,
//       'title': 'Booking Status',
//       'color': Color(0xFF9C27B0),
//       'route': UserViewBookingStatus(),
//     },
//     {
//       'icon': Icons.report_problem_outlined,
//       'title': 'Complaint',
//       'color': Color(0xFFF44336),
//       'route': ComplaintForm(),
//     },
//     {
//       'icon': Icons.visibility_outlined,
//       'title': 'Complaint Status',
//       'color': Color(0xFFFF9800),
//       'route': ComplaintView(),
//     },
//     {
//       'icon': Icons.feedback_outlined,
//       'title': 'Feedback',
//       'color': Color(0xFF4CAF50),
//       'route': FeedbackPage(),
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserInfo();
//   }
//
//   Future<void> _loadUserInfo() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       name = sh.getString('name') ?? 'User';
//       email = sh.getString('email') ?? 'user@example.com';
//       photo = sh.getString('photo');
//       imgurl = sh.getString('imgurl').toString();
//     });
//   }
//
//   // Purple to Blue Gradient
//   final LinearGradient _backgroundGradient = LinearGradient(
//     colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomepage()));
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text("FixPro User Dashboard"),
//           backgroundColor: Color(0xFF6A11CB),
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         drawer: _buildDrawer(),
//         body: Container(
//           decoration: BoxDecoration(gradient: _backgroundGradient),
//           child: Column(
//             children: [
//               // Carousel Section
//               _buildCarouselSection(),
//
//               // Navigation Cards Section
//               Expanded(
//                 child: _buildNavigationSection(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(gradient: _backgroundGradient),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // Drawer Header
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFF6A11CB),
//                 border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.white,
//                     backgroundImage: (photo != null && photo!.isNotEmpty)
//                         ? NetworkImage('$imgurl$photo')
//                         : AssetImage('assets/default_user.png') as ImageProvider,
//                     child: (photo == null || photo!.isEmpty)
//                         ? Icon(Icons.person, size: 30, color: Color(0xFF6A11CB))
//                         : null,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     name ?? 'User',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     email ?? 'user@fixpro.com',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Drawer Menu Items
//             _buildDrawerItem(Icons.home, "Home", () => Navigator.pop(context)),
//             _buildDrawerItem(Icons.build_circle_outlined, "View Skills",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewallSkill()))),
//             _buildDrawerItem(Icons.people_outline, "View Workers",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewWorker()))),
//             _buildDrawerItem(Icons.assignment_outlined, "Booking Status",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewBookingStatus()))),
//             _buildDrawerItem(Icons.report_problem_outlined, "Complaint",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintForm()))),
//             _buildDrawerItem(Icons.visibility_outlined, "Complaint Status",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintView()))),
//             _buildDrawerItem(Icons.feedback_outlined, "Feedback",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()))),
//
//             Divider(color: Colors.white.withOpacity(0.3), height: 20),
//
//             _buildDrawerItem(Icons.logout, "Logout", () async {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             }, isLogout: true),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
//     return ListTile(
//       leading: Icon(icon, color: isLogout ? Colors.redAccent : Colors.white.withOpacity(0.8)),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isLogout ? Colors.redAccent : Colors.white,
//           fontWeight: isLogout ? FontWeight.w600 : FontWeight.normal,
//         ),
//       ),
//       onTap: onTap,
//       tileColor: isLogout ? Colors.red.withOpacity(0.1) : null,
//     );
//   }
//
//   Widget _buildCarouselSection() {
//     return Container(
//       padding: EdgeInsets.only(top: 16),
//       child: Column(
//         children: [
//           CarouselSlider(
//             items: carouselImageUrls.map((url) {
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 15,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.network(
//                     url,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         ),
//                       );
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFF6A11CB).withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.build, color: Colors.white, size: 50),
//                               SizedBox(height: 10),
//                               Text(
//                                 'FixPro Services',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             }).toList(),
//             options: CarouselOptions(
//               height: 180,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               aspectRatio: 16/9,
//               autoPlayInterval: Duration(seconds: 3),
//               autoPlayAnimationDuration: Duration(milliseconds: 800),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               pauseAutoPlayOnTouch: true,
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _currentCarouselIndex = index;
//                 });
//               },
//               viewportFraction: 0.8,
//             ),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: carouselImageUrls.asMap().entries.map((entry) {
//               return Container(
//                 width: 8.0,
//                 height: 8.0,
//                 margin: EdgeInsets.symmetric(horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentCarouselIndex == entry.key
//                       ? Colors.white
//                       : Colors.white.withOpacity(0.4),
//                 ),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 20),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Welcome to FixPro",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//                 letterSpacing: 0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Find the best repair services for your needs",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.9),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 10),
//           // Welcome message with user name
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Hello, ${name?.split(' ').first ?? 'User'}! 👋",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavigationSection() {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Quick Actions",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF6A11CB),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF6A11CB).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "${navigationCards.length} Options",
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF6A11CB),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(16),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 1.2,
//               ),
//               itemCount: navigationCards.length,
//               itemBuilder: (context, index) {
//                 return _buildNavigationCard(navigationCards[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavigationCard(Map<String, dynamic> card) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: card['color'].withOpacity(0.2),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(16),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => card['route'] as Widget),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   card['color'].withOpacity(0.9),
//                   card['color'].withOpacity(0.7),
//                 ],
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       card['icon'] as IconData,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     card['title'].toString(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 6),
//                   Icon(
//                     Icons.arrow_forward_ios,
//                     color: Colors.white.withOpacity(0.8),
//                     size: 16,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fp/user/feedback.dart';
import 'package:fp/user/user%20complaint.dart';
import 'package:fp/user/user%20view%20all%20skills.dart';
import 'package:fp/user/user_view_complaint.dart';
import 'package:fp/user/user_view_worker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../loginn.dart';
import 'booking_status.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({Key? key}) : super(key: key);

  @override
  State<UserHomepage> createState() => _HomePageState();
}

class _HomePageState extends State<UserHomepage> {
  String? name = '';
  String? email = '';
  String? photo = '';
  String? imgurl = '';
  int _currentCarouselIndex = 0;
  List skills = [];
  bool loadingSkills = true;

  // Sample carousel images - replace with your actual images
  final List<String> carouselImageUrls = [
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
  ];

  // Navigation cards data for user
  final List<Map<String, dynamic>> navigationCards = [
    {
      'icon': Icons.build_circle_outlined,
      'title': 'View Skills',
      'color': Color(0xFF6A11CB),
      'route': UserViewallSkill(),
    },
    {
      'icon': Icons.people_outline,
      'title': 'View Workers',
      'color': Color(0xFF2575FC),
      'route': UserViewWorker(),
    },
    {
      'icon': Icons.assignment_outlined,
      'title': 'Booking Status',
      'color': Color(0xFF9C27B0),
      'route': UserViewBookingStatus(),
    },
    {
      'icon': Icons.report_problem_outlined,
      'title': 'Complaint',
      'color': Color(0xFFF44336),
      'route': ComplaintForm(),
    },
    {
      'icon': Icons.visibility_outlined,
      'title': 'Complaint Status',
      'color': Color(0xFFFF9800),
      'route': userComplaintView(),
    },
    {
      'icon': Icons.feedback_outlined,
      'title': 'Feedback',
      'color': Color(0xFF4CAF50),
      'route': FeedbackPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadSkills();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      name = sh.getString('name') ?? 'User';
      email = sh.getString('email') ?? 'user@example.com';
      photo = sh.getString('photo');
      imgurl = sh.getString('imgurl').toString();
    });
  }

  /// 🔹 LOAD SKILLS FOR HOME PAGE
  Future<void> _loadSkills() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final response = await http.post(
        Uri.parse('$url/myapp/user_view_all_skill/'),
        body: {'lid': lid},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            skills = jsonData['data'];
            loadingSkills = false;
          });
        } else {
          setState(() {
            skills = [];
            loadingSkills = false;
          });
        }
      } else {
        setState(() {
          skills = [];
          loadingSkills = false;
        });
      }
    } catch (e) {
      setState(() {
        skills = [];
        loadingSkills = false;
      });
    }
  }

  /// 🔹 BOOK SKILL FROM HOME PAGE
  Future<void> _bookSkill(String skillId) async {
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
        _showSnackBar("Booking submitted successfully!");
        _loadSkills(); // Refresh the skills list
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
      ),
    );
  }

  // Purple to Blue Gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomepage()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("FixPro User Dashboard"),
          backgroundColor: Color(0xFF6A11CB),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: _buildDrawer(),
        body: Container(
          decoration: BoxDecoration(gradient: _backgroundGradient),
          child: Column(
            children: [
              // Carousel Section
              _buildCarouselSection(),

              // Skills Section (replaces Quick Actions)
              Expanded(
                child: _buildSkillsSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6A11CB),
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: (photo != null && photo!.isNotEmpty)
                        ? NetworkImage('$imgurl$photo')
                        : AssetImage('assets/default_user.png') as ImageProvider,
                    child: (photo == null || photo!.isEmpty)
                        ? Icon(Icons.person, size: 30, color: Color(0xFF6A11CB))
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    name ?? 'User',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    email ?? 'user@fixpro.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Menu Items
            _buildDrawerItem(Icons.home, "Home", () => Navigator.pop(context)),
            _buildDrawerItem(Icons.build_circle_outlined, "View Skills",
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewallSkill()))),
            _buildDrawerItem(Icons.people_outline, "View Workers",
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewWorker()))),
            _buildDrawerItem(Icons.assignment_outlined, "Booking Status",
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewBookingStatus()))),

            // _buildDrawerItem(Icons.report_problem_outlined, "Complaint",
            //         () => Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintForm()))),


            _buildDrawerItem(Icons.visibility_outlined, "Complaint",
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => userComplaintView()))),
            _buildDrawerItem(Icons.feedback_outlined, "Feedback",
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()))),

            Divider(color: Colors.white.withOpacity(0.3), height: 20),

            _buildDrawerItem(Icons.logout, "Logout", () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.redAccent : Colors.white.withOpacity(0.8)),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.redAccent : Colors.white,
          fontWeight: isLogout ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      tileColor: isLogout ? Colors.red.withOpacity(0.1) : null,
    );
  }

  Widget _buildCarouselSection() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          CarouselSlider(
            items: carouselImageUrls.map((url) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF6A11CB).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.build, color: Colors.white, size: 50),
                              SizedBox(height: 10),
                              Text(
                                'FixPro Services',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
            }).toList(),
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16/9,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCarouselIndex = index;
                });
              },
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselImageUrls.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarouselIndex == entry.key
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Welcome to FixPro",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Find the best repair services for your needs",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          // Welcome message with user name
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hello, ${name?.split(' ').first ?? 'User'}! 👋",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Skills",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6A11CB),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserViewallSkill()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF6A11CB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6A11CB),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Color(0xFF6A11CB),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: loadingSkills
                ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6A11CB),
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _loadSkills();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6A11CB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                bool booked = skill['booked'] == true;
                return _buildHomeSkillCard(skill, booked);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeSkillCard(Map<String, dynamic> skill, bool isBooked) {
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
                // Quick Book Button
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: isBooked
                        ? null
                        : () {
                      _bookSkill(skill['skill_id'].toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBooked
                          ? Colors.grey[300]
                          : Color(0xFF6A11CB),
                      foregroundColor: isBooked ? Colors.grey[600] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isBooked
                              ? Icons.check_circle_outline
                              : Icons.bookmark_add_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          isBooked ? "Booked" : "Book",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Description
            Text(
              skill['discription'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            // View Details Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserViewallSkill(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF2575FC),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




}







// import 'package:flutter/material.dart';
// import 'package:fp/user/feedback.dart';
// import 'package:fp/user/user%20complaint.dart';
// import 'package:fp/user/user%20view%20all%20skills.dart';
// import 'package:fp/user/user_view_complaint.dart';
// import 'package:fp/user/user_view_worker.dart';
// import 'package:fp/view_complaint.dart';
// import 'package:fp/worker_skill_add.dart';
// import 'package:fp/worker_skill_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../loginn.dart';
// import 'booking_status.dart';
//
//
// //
// // final List<String> carouselImageUrls = [
// //   'assets/bg1.jpg',
// //   'assets/bg2.jpg',
// //   'assets/images.jpg',
// // ];
//
//
// class UserHomepage extends StatefulWidget {
//   const UserHomepage({Key? key}) : super(key: key);
//
//   @override
//   State<UserHomepage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<UserHomepage> {
//   String? name = '';
//   String? email = '';
//   String? photo = '';
//   String? imgurl='';
//   @override
//   void initState() {
//     super.initState();
//     _loadUserInfo();
//   }
//
//   Future<void> _loadUserInfo() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       name = sh.getString('name') ?? 'User';
//       email = sh.getString('email') ?? 'user@example.com';
//       photo = sh.getString('photo');
//       imgurl = sh.getString('imgurl').toString();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // after login ..not going to back unless logout
//     return WillPopScope(
//       onWillPop: ()async{
//         Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomepage(),));
//         return false;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text("Home"),
//             backgroundColor: Colors.blue[700],
//           ),
//
//           // 🧭 Drawer Section
//           drawer: Drawer(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 // Drawer Header
//                 UserAccountsDrawerHeader(
//                   decoration: BoxDecoration(color: Colors.blue[700]),
//                   accountName: Text(
//                     "Welcome $name",
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   accountEmail: Text(email ?? ''),
//
//                   currentAccountPicture: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     backgroundImage: (photo != null && photo!.isNotEmpty)
//                         ? NetworkImage('$imgurl$photo') // full URL to your image
//                         : const AssetImage('assets/default_user.png') as ImageProvider,
//                   ),
//                 ),
//
//
//                 // Drawer Menu Items
//                 ListTile(
//                   leading: const Icon(Icons.home, color: Colors.blue),
//                   title: const Text("Home"),
//                   onTap: () {
//                     Navigator.pop(context); // just close the drawer
//                   },
//                 ),
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("View Skills"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => UserViewallSkill()),
//                     );
//                   },
//                 ),
//
//
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("View Worker"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => UserViewWorker()),
//                     );
//                   },
//                 ),
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Booking Status"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => UserViewBookingStatus()),
//                     );
//                   },
//                 ),
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Complaint"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ComplaintForm()),
//                     );
//                   },
//                 ),
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Complaint Status"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ComplaintView()),
//                     );
//                   },
//                 ),
//
//
//
//
//
//
//
//
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Feedback"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => FeedbackPage()),
//                     );
//                   },
//                 ),
//
//                 const Divider(),
//                 ListTile(
//                   leading: const Icon(Icons.logout, color: Colors.red),
//                   title: const Text("Logout"),
//                   onTap: () async {
//                     // SharedPreferences sh = await SharedPreferences.getInstance();
//                     // await sh.clear(); // clears user data
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) =>  LoginPage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           body: Container(
//             decoration: const BoxDecoration(
//               // Retaining a smooth, professional gradient
//               gradient: LinearGradient(
//                 colors: [Color(0xFF0D47A1),Color(0xFF2196F3)], // Slightly deeper, more vibrant blue/teal
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Center(
//               child: SingleChildScrollView( // Use SingleChildScrollView for safety
//                 padding: const EdgeInsets.all(30.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Profile Photo/Icon - Styled for a Freelancer
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3), // White border for emphasis
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black38,
//                             blurRadius: 15,
//                             offset: const Offset(0, 8),
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         radius: 60,
//                         backgroundColor: Colors.white,
//                         // Using a laptop/screen icon for a generic professional freelancer look
//                         child: Icon(Icons.laptop_chromebook_outlined, size: 70, color: Colors.blue[700]),
//                         // Note: You would replace the Icon with NetworkImage(fullPhotoUrl) if available
//                       ),
//                     ),
//
//                     const SizedBox(height: 35),
//
//                     // Welcome text - More pronounced
//                     Text(
//                       "Welcome, $name!",
//                       style: const TextStyle(
//                         fontSize: 25, // Larger font
//                         fontWeight: FontWeight.w900, // Extra bold
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 5.0,
//                             color: Colors.black38,
//                             offset: Offset(1.0, 1.0),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // Email
//                     Text(
//                       "$email",
//                       style: const TextStyle(
//                         fontSize: 17,
//                         color: Colors.white70,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//
//                     const SizedBox(height: 50),
//
//                     // 🌟 Freelancer Icon Row (Adds industry flair)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.code, color: Colors.white70, size: 30),
//                         const SizedBox(width: 25),
//                         Icon(Icons.design_services, color: Colors.white, size: 30),
//                         const SizedBox(width: 25),
//                         Icon(Icons.analytics_outlined, color: Colors.white70, size: 30),
//                       ],
//                     ),
//
//                     const SizedBox(height: 50),
//
//                     // Tag line / motivational text - Cleaned up and highlighted
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.25), // Stronger background contrast
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.white, width: 1.5), // Solid white border
//                       ),
//                       child: Column(
//                         children: [
//                           const Text(
//                             "Your workspace is ready. Time to secure that next project! 🚀",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 17,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Navigate using the menu icon above.",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white.withOpacity(0.8),
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // NOTE: The Log Out Button has been successfully removed.
//                   ],
//                 ),
//               ),
//             ),
//           )
//       ),
//     );
//   }
// }


