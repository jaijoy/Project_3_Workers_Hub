// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class workerComplaintForm extends StatefulWidget {
//   const workerComplaintForm({Key? key}) : super(key: key);
//
//   @override
//   State<workerComplaintForm> createState() => _ComplaintFormState();
// }
//
// class _ComplaintFormState extends State<workerComplaintForm> {
//   final TextEditingController complaintController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//   Future<void> _submitComplaint() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String url = prefs.getString("url") ?? '';
//       String lid = prefs.getString("lid") ?? '';
//
//       final response = await http.post(
//         Uri.parse('$url/myapp/worker_complaint/'),
//         body: {
//           'complaint': complaintController.text,
//           'lid': lid,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Complaint submitted successfully")),
//         );
//         complaintController.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to submit complaint")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//
//     setState(() => _isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Complaint"),
//         backgroundColor: Colors.blue[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: complaintController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   labelText: "Enter your complaint",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   prefixIcon: Icon(Icons.report_problem, color: Colors.blue[700]),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Please enter your complaint";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _submitComplaint,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[700],
//                   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                   "Submit",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//
// def user_complaint(request):
// complaint = request.POST["complaint"]
// login_id=request.POST["lid"]
// user=user_Tbl.objects.get(LOGIN=login_id)
// obj=complaint_Tbll()
// obj.LOGIN=user.LOGIN
// obj.type="Customer"
// obj.complaint=complaint
// obj.date = datetime.datetime.now().today().date()
// obj.reply="pending"
//
// obj.save()
// return JsonResponse({'status': 'ok'})
//
















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class workerComplaintForm extends StatefulWidget {
  const workerComplaintForm({Key? key}) : super(key: key);

  @override
  State<workerComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<workerComplaintForm> {
  final TextEditingController complaintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Purple to Blue Gradient
  final LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      String url = prefs.getString("url") ?? '';
      String lid = prefs.getString("lid") ?? '';

      final response = await http.post(
        Uri.parse('$url/myapp/worker_complaint/'),
        body: {
          'complaint': complaintController.text,
          'lid': lid,
        },
      );

      if (response.statusCode == 200) {
        _showSnackBar("Complaint submitted successfully");
        complaintController.clear();
      } else {
        _showSnackBar("Failed to submit complaint", isError: true);
      }
    } catch (e) {
      _showSnackBar("Error: $e", isError: true);
    }

    setState(() => _isLoading = false);
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
        action: SnackBarAction(
          label: 'OK',
          textColor: isError ? Colors.white : Color(0xFF6A11CB),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Complaint"),
        backgroundColor: Color(0xFF6A11CB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(30),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF6A11CB).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.report_problem_outlined,
                        color: Color(0xFF6A11CB),
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Submit Complaint",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6A11CB),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please describe your complaint in detail",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Complaint Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "COMPLAINT DETAILS",
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
                            Icon(Icons.report_problem_outlined, color: Color(0xFF6A11CB), size: 22),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: complaintController,
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Describe your issue or concern...",
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
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your complaint";
                                  }
                                  if (value.trim().length < 10) {
                                    return "Please provide more details (min 10 characters)";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Be specific about dates, times, and people involved if applicable",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitComplaint,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6A11CB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          "SUBMIT COMPLAINT",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}