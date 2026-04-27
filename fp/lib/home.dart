//
// import 'package:flutter/material.dart';
// import 'package:fp/view%20rating.dart';
// import 'package:fp/view_complaint.dart';
// import 'package:fp/work%20status.dart';
// import 'package:fp/worker_skill_add.dart';
// import 'package:fp/worker_skill_view.dart';
// import 'package:fp/worker_view_booking.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'complaint.dart';
// import 'loginn.dart';
//

//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
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
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
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
//                 //
//
//                 //
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Add Skill"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WorkerSkillAdd()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text(" Skill Details"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WorkerSkillView()),
//                     );
//                   },
//                 ),
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Work Requests"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => WorkerViewBooking()),
//                     );
//                   },
//                 ),
//
//
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("work status"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => WorkerViewBookingstatus()),
//                     );
//                   },
//                 ),
//
//                 //
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Worker Rating"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => WorkerViewRating()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Complaint"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => workerComplaintForm()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                   title: const Text("Complaint Status"),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => workerComplaintView()),
//                     );
//                   },
//                 ),
//                 // ListTile(
//                 //   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                 //   title: const Text("App Feedback"),
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => FeedbackPage()),
//                 //     );
//                 //   },
//                 // ),
//                 //
//                 // ListTile(
//                 //   leading: const Icon(Icons.list_alt, color: Colors.blue),
//                 //   title: const Text("View Profile"),
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => Profile()),
//                 //     );
//                 //   },
//                 // ),
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
//
//

//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fp/view%20rating.dart';
// import 'package:fp/view_complaint.dart';
// import 'package:fp/work%20status.dart';
// import 'package:fp/worker_skill_add.dart';
// import 'package:fp/worker_skill_view.dart';
// import 'package:fp/worker_view_booking.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'complaint.dart';
// import 'loginn.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? name = '';
//   String? email = '';
//   String? photo = '';
//   String? imgurl='';
//   int _currentCarouselIndex = 0;
//
//   // Sample carousel images - replace with your actual images
//   final List<String> carouselImageUrls = [
//     'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//     'https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//     'https://images.unsplash.com/photo-1576675466969-38eeae4b41f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
//   ];
//
//   // Sample skills data - replace with actual skills from your database
//   final List<Map<String, dynamic>> sampleSkills = [
//     {'icon': Icons.build, 'title': 'Electrical', 'count': 15},
//     {'icon': Icons.plumbing, 'title': 'Plumbing', 'count': 12},
//     {'icon': Icons.carpenter, 'title': 'Carpentry', 'count': 8},
//     {'icon': Icons.ac_unit, 'title': 'AC Repair', 'count': 10},
//     {'icon': Icons.computer, 'title': 'Computer', 'count': 20},
//     {'icon': Icons.phone_android, 'title': 'Mobile Repair', 'count': 18},
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
//       name = sh.getString('name') ?? 'Worker';
//       email = sh.getString('email') ?? 'worker@fixpro.com';
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
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text("FixPro Worker Dashboard"),
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
//               // Skills Section
//               Expanded(
//                 child: _buildSkillsSection(),
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
//                     name ?? 'Worker',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     email ?? 'worker@fixpro.com',
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
//             _buildDrawerItem(Icons.add_circle_outline, "Add Skill",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerSkillAdd()))),
//             _buildDrawerItem(Icons.list_alt, "Skill Details",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerSkillView()))),
//             _buildDrawerItem(Icons.assignment, "Work Requests",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewBooking()))),
//             _buildDrawerItem(Icons.work_outline, "Work Status",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewBookingstatus()))),
//             _buildDrawerItem(Icons.star_border, "Worker Rating",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewRating()))),
//             _buildDrawerItem(Icons.report_problem, "Complaint",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => workerComplaintForm()))),
//             _buildDrawerItem(Icons.visibility, "Complaint Status",
//                     () => Navigator.push(context, MaterialPageRoute(builder: (context) => workerComplaintView()))),
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
//                               Icon(Icons.broken_image, color: Colors.white, size: 50),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Repair Service',
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
//               "Professional Repair Services",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//                 letterSpacing: 0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSkillsSection() {
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
//                   "Your Skills",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF6A11CB),
//                   ),
//                 ),
//                 Text(
//                   "${sampleSkills.length} Skills",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
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
//               itemCount: sampleSkills.length,
//               itemBuilder: (context, index) {
//                 return _buildSkillCard(sampleSkills[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSkillCard(Map<String, dynamic> skill) {
//     return Container(
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
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(16),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () {
//             // Navigate to skill details or related work
//           },
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF6A11CB).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     skill['icon'] as IconData,
//                     color: Color(0xFF6A11CB),
//                     size: 28,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   skill['title'].toString(),
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   "${skill['count']} Jobs",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fp/profile.dart';
import 'package:fp/view%20rating.dart';
import 'package:fp/view_complaint.dart';
import 'package:fp/work%20status.dart';
import 'package:fp/worker_skill_add.dart';
import 'package:fp/worker_skill_view.dart';
import 'package:fp/worker_view_booking.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'complaint.dart';
import 'loginn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name = '';
  String? email = '';
  String? photo = '';
  String? imgurl='';
  int _currentCarouselIndex = 0;

  // Sample carousel images - replace with your actual images
  final List<String> carouselImageUrls = [
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    // 'https://images.unsplash.com/photo-1576675466969-38eeae4b41f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80', // Appliance repair

  ];


  // final List<String> carouselImageUrls = [
  //   'assets/bg1.jpg',
  //   'assets/bg2.jpg',
  //   'assets/images.jpg',
  // ];

  // Navigation cards data - REMOVED "Complaint Status"
  final List<Map<String, dynamic>> navigationCards = [
    {
      'icon': Icons.add_circle_outline,
      'title': 'Add Skill',
      'color': Color(0xFF6A11CB),
      'route': WorkerSkillAdd(),
    },
    {
      'icon': Icons.list_alt,
      'title': 'Skill Details',
      'color': Color(0xFF2575FC),
      'route': WorkerSkillView(),
    },
    {
      'icon': Icons.assignment,
      'title': 'Work Requests',
      'color': Color(0xFF9C27B0),
      'route': WorkerViewBooking(),
    },
    {
      'icon': Icons.work_outline,
      'title': 'Work Status',
      'color': Color(0xFF2196F3),
      'route': WorkerViewBookingstatus(),
    },
    {
      'icon': Icons.star_border,
      'title': 'Rating',
      'color': Color(0xFFFF9800),
      'route': WorkerViewRating(),
    },
    {
      'icon': Icons.report_problem,
      'title': 'Complaint',
      'color': Color(0xFFF44336),
      'route': workerComplaintView(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      name = sh.getString('name') ?? 'Worker';
      email = sh.getString('email') ?? 'worker@fixpro.com';
      photo = sh.getString('photo');
      imgurl = sh.getString('imgurl').toString();
    });
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("FixPro Worker Dashboard"),
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

              // Navigation Cards Section
              Expanded(
                child: _buildNavigationSection(),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A0C71), Color(0xFF1E469A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // User Profile Section
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 24,
                right: 24,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: (photo != null && photo!.isNotEmpty)
                          ? NetworkImage('$imgurl$photo')
                          : AssetImage('assets/default_user.png') as ImageProvider,
                      child: (photo == null || photo!.isEmpty)
                          ? Icon(Icons.person, size: 30, color: Color(0xFF6A11CB))
                          : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? 'Worker',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          email ?? 'worker@fixpro.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'FixPro Worker',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // Dashboard Section
                    _buildDrawerSection('Dashboard', Icons.dashboard_outlined, [
                      _buildMenuItem(
                        icon: Icons.home_outlined,
                        title: 'Home',
                        onTap: () => Navigator.pop(context),
                        isActive: true,
                      ),
                    ]),

                    // Services Section
                    _buildDrawerSection('Services', Icons.build_circle_outlined, [
                      _buildMenuItem(
                        icon: Icons.add_circle_outline,
                        title: 'Add Skill',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerSkillAdd())),
                      ),
                      _buildMenuItem(
                        icon: Icons.list_alt_outlined,
                        title: 'Skill Details',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerSkillView())),
                      ),
                    ]),

                    // Work Section
                    _buildDrawerSection('Work Management', Icons.work_outlined, [
                      _buildMenuItem(
                        icon: Icons.assignment_outlined,
                        title: 'Work Requests',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerViewBooking())),
                      ),
                      _buildMenuItem(
                        icon: Icons.timeline_outlined,
                        title: 'Work Status',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerViewBookingstatus())),
                      ),
                    ]),

                    // Feedback Section
                    _buildDrawerSection('Feedback ', Icons.feedback_outlined, [
                      _buildMenuItem(
                        icon: Icons.star_border_outlined,
                        title: 'My Ratings',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerViewRating())),
                      ),
                      // _buildMenuItem(
                      //   icon: Icons.report_problem_outlined,
                      //   title: 'Submit Complaint',
                      //   onTap: () => Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => workerComplaintForm())),
                      // ),
                      _buildMenuItem(
                        icon: Icons.visibility_outlined,
                        title: 'Complaint ',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => workerComplaintView())),
                      ),

                      _buildMenuItem(
                        icon: Icons.visibility_outlined,
                        title: 'Profile ',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WorkerViewProfile())),
                      ),
                    ]),

                    SizedBox(height: 30),

                    // Logout Button
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Colors.redAccent,
                                  size: 22,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.redAccent.withOpacity(0.7),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerSection(String title, IconData icon, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Column(children: items),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.white.withOpacity(0.8),
                  size: 22,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? Colors.white : Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget _buildDrawer() {
  //   return Drawer(
  //     child: Container(
  //       decoration: BoxDecoration(gradient: _backgroundGradient),
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
  //           // Drawer Header
  //           DrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Color(0xFF460B86),
  //               border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 CircleAvatar(
  //                   radius: 30,
  //                   backgroundColor: Colors.white,
  //                   backgroundImage: (photo != null && photo!.isNotEmpty)
  //                       ? NetworkImage('$imgurl$photo')
  //                       : AssetImage('assets/default_user.png') as ImageProvider,
  //                   child: (photo == null || photo!.isEmpty)
  //                       ? Icon(Icons.person, size: 30, color: Color(0xFF570FA6))
  //                       : null,
  //                 ),
  //                 SizedBox(height: 10),
  //                 Text(
  //                   name ?? 'Worker',
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(height: 5),
  //                 Text(
  //                   email ?? 'worker@fixpro.com',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.white.withOpacity(0.8),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           // Drawer Menu Items
  //           _buildDrawerItem(Icons.home, "Home", () => Navigator.pop(context)),
  //           _buildDrawerItem(Icons.add_circle_outline, "Add Skill",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerSkillAdd()))),
  //           _buildDrawerItem(Icons.list_alt, "Skill Details",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerSkillView()))),
  //           _buildDrawerItem(Icons.assignment, "Work Requests",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewBooking()))),
  //           _buildDrawerItem(Icons.work_outline, "Work Status",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewBookingstatus()))),
  //           _buildDrawerItem(Icons.star_border, "Rating",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerViewRating()))),
  //           _buildDrawerItem(Icons.report_problem, "Complaint",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => workerComplaintForm()))),
  //           _buildDrawerItem(Icons.visibility, "Complaint Status",
  //                   () => Navigator.push(context, MaterialPageRoute(builder: (context) => workerComplaintView()))),
  //
  //           Divider(color: Colors.white.withOpacity(0.3), height: 20),
  //
  //           _buildDrawerItem(Icons.logout, "Logout", () async {
  //             Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(builder: (context) => LoginPage()),
  //             );
  //           }, isLogout: true),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
              "Welcome to FixPro Dashboard",
              style: TextStyle(
                fontSize: 20,
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
              "Manage your repair services efficiently",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationSection() {
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6A11CB),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF6A11CB).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${navigationCards.length} Options",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6A11CB),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.08,
              ),
              itemCount: navigationCards.length,
              itemBuilder: (context, index) {
                return _buildNavigationCard(navigationCards[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(Map<String, dynamic> card) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: card['color'].withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => card['route'] as Widget),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  card['color'].withOpacity(0.9),
                  card['color'].withOpacity(0.7),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      card['icon'] as IconData,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    card['title'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(height: 6),
                  // Icon(
                  //   Icons.arrow_forward_ios,
                  //   color: Colors.white.withOpacity(0.8),
                  //   size: 16,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}