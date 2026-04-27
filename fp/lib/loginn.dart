// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fp/register.dart';
// import 'package:fp/user/user_register.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'home.dart';
// import 'ip.dart';
//
// // --- (MyApp and main remain the same) ---
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TrawlDoor Login System',
//       // Using a dark theme for this design
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         brightness: Brightness.dark, // Crucial for the dark aesthetic
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         // Customize text selection/cursor color for better look
//         textSelectionTheme: TextSelectionThemeData(
//           cursorColor: Colors.cyanAccent,
//           selectionColor: Colors.cyanAccent.withOpacity(0.3),
//         ),
//       ),
//       home: LoginPage(),
//     );
//   }
// }
// // ----------------------------------------
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   // Define the new color palette
//   static const Color primaryColor = Color(0xFF1E1E1E); // Very dark background
//   static const Color accentColor = Colors.cyanAccent; // Bright accent for focus
//   static const Color cardColor = Color(0xFF2C2C2C); // Slightly lighter card
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigate back to the IP settings page
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => ContractEaseIp()));
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: primaryColor, // Set the main background color
//         body: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // App Logo/Icon Placeholder
//                 Icon(
//                   Icons.assignment_turned_in_outlined, // Contract related icon
//                   color: accentColor,
//                   size: 80,
//                 ),
//                 SizedBox(height: 16),
//                 // Heading
//                 Text(
//                   'TrawlDoor',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.w300, // Thinner font weight
//                     color: Colors.white,
//                     letterSpacing: 4.0,
//                   ),
//                 ),
//                 SizedBox(height: 60),
//
//                 // Login Card/Container
//                 Container(
//                   padding: EdgeInsets.all(30.0),
//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 20,
//                         offset: Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         'Secure Access',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 30),
//
//                       // Username TextField
//                       _buildTextField(
//                         controller: _usernameController,
//                         label: 'Username',
//                         icon: Icons.person_outline,
//                       ),
//                       SizedBox(height: 25),
//
//                       // Password TextField
//                       _buildTextField(
//                         controller: _passwordController,
//                         label: 'Password',
//                         icon: Icons.lock_outline,
//                         isPassword: true,
//                       ),
//                       SizedBox(height: 40),
//
//                       // Login Button
//                       SizedBox(
//                         width: double.infinity, // Make button stretch
//                         child: ElevatedButton(
//                           onPressed: () {
//                             senddata();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: accentColor, // Use the bright accent
//                             foregroundColor: primaryColor, // Dark text on bright background
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             textStyle: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             elevation: 5,
//                           ),
//                           child: Text('LOG IN'),
//                         ),
//                       ),
//
//                       SizedBox(height: 30),
//
//                       // Registration link
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Don't have an account?",
//                             style: TextStyle(color: Colors.grey[400]),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => WorkerRegistration()),
//                               );
//                             },
//                             child: Text(
//                               'Worker Register Here',
//                               style: TextStyle(
//                                 color: accentColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => regapp()),
//                               );
//                             },
//                             child: Text(
//                               'User Register Here',
//                               style: TextStyle(
//                                 color: accentColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Custom Widget for the TextFields to keep the design DRY
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isPassword = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       style: TextStyle(color: Colors.white), // Input text color
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[500]), // Label color
//         prefixIcon: Icon(icon, color: accentColor), // Icon color
//         filled: true,
//         fillColor: primaryColor, // Dark fill color for high contrast
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Color(0xFF3A3A3A), width: 1), // Subtle border
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: accentColor, width: 2), // Highlight border
//         ),
//       ),
//     );
//   }
//
//   // The senddata function remains the same as its logic is backend related
//   void senddata() async {
//     String username = _usernameController.text;
//     String password = _passwordController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     final urls = Uri.parse(url + "/myapp/android_login/");
//
//     final response = await http.post(urls, body: {
//       'username': username,
//       'password': password,
//     });
//
//     if (response.statusCode == 200) {
//       String status = jsonDecode(response.body)['status'];
//       print(status + "oooooooooooooooooooooo");
//       if (status == 'ok') {
//         Fluttertoast.showToast(msg: 'Login Success', backgroundColor: accentColor, textColor: primaryColor);
//
//         String type = jsonDecode(response.body)['type'];
//         String lid = jsonDecode(response.body)['lid'].toString();
//
//         sh.setString("lid", lid);
//         sh.setString("name", jsonDecode(response.body)['name']);
//         sh.setString("email", jsonDecode(response.body)['email']);
//         sh.setString("photo", jsonDecode(response.body)['photo']);
//
//         if (type == 'Worker') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//           );
//         }
//
//         if (type == 'Customer') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//           );
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Invalid Credentials', backgroundColor: Colors.redAccent, textColor: Colors.white);
//       }
//     } else {
//       Fluttertoast.showToast(msg: 'Network Error', backgroundColor: Colors.redAccent, textColor: Colors.white);
//     }
//   }
// }
//
//


//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fp/register.dart';
// import 'package:fp/user/home.dart';
// import 'package:fp/user/user_register.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'home.dart';
// import 'ip.dart';
//
// // --- (MyApp and main remain the same) ---
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TrawlDoor Login System',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         brightness: Brightness.dark,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textSelectionTheme: TextSelectionThemeData(
//           cursorColor: Colors.cyanAccent,
//           selectionColor: Colors.cyanAccent.withOpacity(0.3),
//         ),
//       ),
//       home: LoginPage(),
//     );
//   }
// }
// // ----------------------------------------
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   // Define the new color palette
//   static const Color primaryColor = Color(0xFF121212);
//   static const Color accentColor = Colors.cyanAccent;
//   static const Color cardColor = Color(0xFF2C2C2C);
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => ContractEaseIp()));
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: primaryColor,
//         body: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // App Logo/Icon
//                 Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 15,
//                         offset: Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.assignment_turned_in_outlined,
//                     color: accentColor,
//                     size: 50,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Heading
//                 Text(
//                   'TrawlDoor',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     letterSpacing: 2.0,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Secure Contract Management',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 SizedBox(height: 50),
//
//                 // Login Card/Container
//                 Container(
//                   padding: EdgeInsets.all(30.0),
//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.6),
//                         blurRadius: 25,
//                         offset: Offset(0, 12),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         'Secure Access',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 30),
//
//                       // Username TextField
//                       _buildTextField(
//                         controller: _usernameController,
//                         label: 'Username',
//                         icon: Icons.person_outline,
//                       ),
//                       SizedBox(height: 25),
//
//                       // Password TextField
//                       _buildPasswordField(),
//                       SizedBox(height: 40),
//
//                       // Login Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             senddata();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: accentColor,
//                             foregroundColor: primaryColor,
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             textStyle: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             elevation: 8,
//                             shadowColor: accentColor.withOpacity(0.4),
//                           ),
//                           child: Text('LOGIN'),
//                         ),
//                       ),
//
//                       SizedBox(height: 30),
//
//                       // Registration links
//                       Text(
//                         "Don't have an account?",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//                                 color: primaryColor,
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => WorkerRegistration()),
//                                   );
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.work_outline, color: accentColor, size: 18),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Worker',
//                                       style: TextStyle(
//                                         color: accentColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 15),
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//                                 color: primaryColor,
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => regapp()),
//                                   );
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.person_add_outlined, color: accentColor, size: 18),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'User ',
//                                       style: TextStyle(
//                                         color: accentColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Custom Widget for the Username TextField
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.white70,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: 'Enter your $label',
//             hintStyle: TextStyle(color: Colors.white54),
//             prefixIcon: Icon(icon, color: accentColor),
//             filled: true,
//             fillColor: primaryColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: accentColor, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Custom Widget for Password TextField
//   Widget _buildPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Password',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.white70,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextField(
//           controller: _passwordController,
//           obscureText: _obscurePassword,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: 'Enter your password',
//             hintStyle: TextStyle(color: Colors.white54),
//             prefixIcon: Icon(Icons.lock_outline, color: accentColor),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                 color: Colors.white70,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscurePassword = !_obscurePassword;
//                 });
//               },
//             ),
//             filled: true,
//             fillColor: primaryColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: accentColor, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // The senddata function remains exactly the same
//   void senddata() async {
//     String username = _usernameController.text;
//     String password = _passwordController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     final urls = Uri.parse(url + "/myapp/android_login/");
//
//     final response = await http.post(urls, body: {
//       'username': username,
//       'password': password,
//     });
//
//     if (response.statusCode == 200) {
//       String status = jsonDecode(response.body)['status'];
//       print(status + "oooooooooooooooooooooo");
//       if (status == 'ok') {
//         Fluttertoast.showToast(msg: 'Login Success', backgroundColor: accentColor, textColor: primaryColor);
//
//         String type = jsonDecode(response.body)['type'];
//         String lid = jsonDecode(response.body)['lid'].toString();
//
//         sh.setString("lid", lid);
//         sh.setString("name", jsonDecode(response.body)['name']);
//         sh.setString("email", jsonDecode(response.body)['email']);
//         sh.setString("photo", jsonDecode(response.body)['photo']);
//
//         if (type == 'Worker') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//           );
//         }
//
//         if (type == 'Customer') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => UserHomepage()),
//           );
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Invalid Credentials', backgroundColor: Colors.redAccent, textColor: Colors.white);
//       }
//     } else {
//       Fluttertoast.showToast(msg: 'Network Error', backgroundColor: Colors.redAccent, textColor: Colors.white);
//     }
//   }
// }




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fp/register.dart';
import 'package:fp/user/home.dart';
import 'package:fp/user/user_register.dart';
import 'package:fp/worker_forgot_pswd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'ip.dart';

// --- (MyApp and main remain the same) ---
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixPro Login',
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white.withOpacity(0.3),
        ),
      ),
      home: LoginPage(),
    );
  }
}
// ----------------------------------------

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Purple to Blue Gradient Background
  final LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ContractEaseIp()));
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: _backgroundGradient),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo & Brand Identity
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.build_outlined,
                          color: Color(0xFF6A11CB),
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'FIXPRO',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Professional Repair Solutions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),

                  // Input Fields Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        // Username Field
                        _buildUnderlineTextField(
                          controller: _usernameController,
                          label: 'USERNAME',
                          hint: 'Enter username',
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 30),

                        // Password Field
                        _buildUnderlinePasswordField(),
                        SizedBox(height: 40),
                        //
                        // // Login Button
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 50,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       senddata();
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.white,
                        //       foregroundColor: Color(0xFF6A11CB),
                        //       padding: EdgeInsets.symmetric(vertical: 16),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(25),
                        //       ),
                        //       textStyle: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //       elevation: 0,
                        //     ),
                        //     child: Text('LOGIN'),
                        //   ),
                        // ),


                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              senddata();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF6A11CB),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                            ),
                            child: Text('LOGIN'),
                          ),
                        ),
                        SizedBox(height: 15),

                        // Forgot Password Button
                        TextButton(
                          onPressed: () {
                            // Add your forgot password logic here
                            // GestureDetector(
                                // onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => wForgotPasswordPage()),
                              );
                            // },
                          },

                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),



                        // Registration Options
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkerRegistration()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.work_outline,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 6),
                                    Text(
                                      'Worker',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => regapp()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_add_outlined,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 6),
                                    Text(
                                      'User',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom Underline TextField
  Widget _buildUnderlineTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
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

  // Custom Underline Password Field
  Widget _buildUnderlinePasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PASSWORD',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.lock_outline,
                color: Colors.white.withOpacity(0.8), size: 20),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // The senddata function remains exactly the same
  void senddata() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    final urls = Uri.parse(url + "/myapp/android_login/");

    final response = await http.post(urls, body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      String status = jsonDecode(response.body)['status'];
      print(status + "oooooooooooooooooooooo");
      if (status == 'ok') {
        Fluttertoast.showToast(msg: 'Login Success', backgroundColor: Colors.white, textColor: Color(0xFF6A11CB));

        String type = jsonDecode(response.body)['type'];
        String lid = jsonDecode(response.body)['lid'].toString();

        sh.setString("lid", lid);
        sh.setString("name", jsonDecode(response.body)['name']);
        sh.setString("email", jsonDecode(response.body)['email']);
        sh.setString("photo", jsonDecode(response.body)['photo']);

        if (type == 'Worker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }

        if (type == 'Customer') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHomepage()),
          );
        }
      } else {
        Fluttertoast.showToast(msg: 'Invalid Credentials', backgroundColor: Colors.redAccent, textColor: Colors.white);
      }
    } else {
      Fluttertoast.showToast(msg: 'Network Error', backgroundColor: Colors.redAccent, textColor: Colors.white);
    }
  }
}