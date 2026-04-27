// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'loginn.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TrawlDoor',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ContractEaseIp(),
//     );
//   }
// }
//
// class ContractEaseIp extends StatefulWidget {
//   @override
//   _ContractEaseIpState createState() => _ContractEaseIpState();
// }
//
// class _ContractEaseIpState extends State<ContractEaseIp> {
//   final _usernameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ContractEaseIp()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.teal[200]!, Colors.teal[400]!],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.all(30.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 15,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Colors.teal[100],
//                           child: Icon(
//                             Icons.work,
//                             color: Colors.teal,
//                             size: 60,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           'TrawlDoor',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.teal[800],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextField(
//                           controller: _usernameController,
//                           decoration: InputDecoration(
//                             labelText: 'TrawlDoor Ip',
//                             prefixIcon: Icon(Icons.vpn_key, color: Colors.teal),
//                             filled: true,
//                             fillColor: Colors.teal[50],
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide(color: Colors.teal[200]!),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide(color: Colors.teal[400]!),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 24),
//                         ElevatedButton(
//                           onPressed: () {
//                             senddata();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.teal[600], // Button color
//                             padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             textStyle: TextStyle(fontSize: 18),
//                           ),
//                           child: Text('Connect'),
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void _saveData() async {
//   //   String restaurantCode = _usernameController.text;
//   //
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //
//   //   prefs.setString('restaurant', restaurantCode);
//   //   prefs.setString('url', 'http://$restaurantCode:3000');
//   //   prefs.setString('imgurl', 'http://$restaurantCode:3000/');
//   //   prefs.setString('imgurl2', 'http://$restaurantCode:3000/');
//   //
//   //   print(restaurantCode);
//   //
//   //
//   //   // Show a success message
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Connected to $restaurantCode')),
//   //   );
//   // }
//
//   void senddata()async{
//     String ip= _usernameController.text.toString();
//
//     //stable ip address settings second
//
//     print(ip);
//     SharedPreferences sh = await SharedPreferences.getInstance();
//
//     //stable ip address settings first
//     sh.setString('ip', ip);
//     sh.setString('url', 'http://$ip:8000');
//     sh.setString('imgurl', 'http://$ip:8000');
//     sh.setString('imgurl2', 'http://$ip:8000/');
//     // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage()
//     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()
//     )
//     );
//
//
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixPro',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContractEaseIp(),
    );
  }
}

class ContractEaseIp extends StatefulWidget {
  @override
  _ContractEaseIpState createState() => _ContractEaseIpState();
}

class _ContractEaseIpState extends State<ContractEaseIp> {
  final _ipController = TextEditingController();

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
        return false; // Prevent going back
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: _backgroundGradient),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo & Brand
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.settings_ethernet_outlined,
                      color: Color(0xFF6A11CB),
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'FIXPRO',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Server Configuration',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 50),

                  // Configuration Card
                  Container(
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Connect to Server',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6A11CB),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enter your server IP address to connect',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),

                        // IP Input Field with Underline Style
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'SERVER IP ADDRESS',
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     color: Colors.black54,
                            //     fontWeight: FontWeight.w500,
                            //     letterSpacing: 1.0,
                            //   ),
                            // ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.vpn_key_outlined,
                                    color: Color(0xFF6A11CB),
                                    size: 22),
                                SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: _ipController,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'e.g., 192.168.1.100',
                                      hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
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
                        ),

                        // SizedBox(height: 20),
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFF6A11CB).withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(12),
                        //     border: Border.all(
                        //       color: Color(0xFF6A11CB).withOpacity(0.3),
                        //     ),
                        //   ),
                        //   // child: Row(
                        //   //   children: [
                        //   //     Icon(Icons.info_outline,
                        //   //         color: Color(0xFF6A11CB),
                        //   //         size: 18),
                        //   //     SizedBox(width: 10),
                        //   //     // Expanded(
                        //   //     //   child: Text(
                        //   //     //     'Make sure your device is connected to the same network as the server',
                        //   //     //     style: TextStyle(
                        //   //     //       fontSize: 12,
                        //   //     //       color: Colors.black54,
                        //   //     //     ),
                        //   //     //   ),
                        //   //     // ),
                        //   //   ],
                        //   // ),
                        // ),

                        SizedBox(height: 40),

                        // Connect Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              senddata();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6A11CB),
                              foregroundColor: Colors.white,
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
                            child: Text('CONNECT TO SERVER'),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Example IPs
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Common examples:',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.black54,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     SizedBox(height: 8),
                        //     Wrap(
                        //       spacing: 10,
                        //       runSpacing: 5,
                        //       children: [
                        //         _buildIpChip('192.168.1.100'),
                        //         _buildIpChip('10.0.0.2'),
                        //         _buildIpChip('localhost'),
                        //       ],
                        //     ),
                        //   ],
                        // ),
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

  // IP Chip Widget
  Widget _buildIpChip(String ip) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _ipController.text = ip;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Color(0xFF6A11CB).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFF6A11CB).withOpacity(0.3),
          ),
        ),
        child: Text(
          ip,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6A11CB),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void senddata() async {
    String ip = _ipController.text.trim();

    if (ip.isEmpty) {
      _showError('Please enter server IP address');
      return;
    }

    // Remove http:// or https:// if entered
    if (ip.startsWith('http://')) {
      ip = ip.replaceFirst('http://', '');
    }
    if (ip.startsWith('https://')) {
      ip = ip.replaceFirst('https://', '');
    }

    print('Connecting to IP: $ip');

    SharedPreferences sh = await SharedPreferences.getInstance();

    // Save IP configurations
    sh.setString('ip', ip);
    sh.setString('url', 'http://$ip:8000');
    sh.setString('imgurl', 'http://$ip:8000');
    sh.setString('imgurl2', 'http://$ip:8000/');

    // Show success message
    _showSuccess('Connected to $ip');

    // Navigate to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6A11CB),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}