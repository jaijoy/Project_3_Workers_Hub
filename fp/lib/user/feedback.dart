import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  // Controller for feedback text
  TextEditingController feedbackController = TextEditingController();

  void submitFeedback()  async{
    String feedback = feedbackController.text;
    SharedPreferences sh = await SharedPreferences.getInstance();
    String urls = sh.getString("url") ?? " ";
    String lid= sh.getString("lid") ?? "";

    var url = Uri.parse("$urls/myapp/user_feedback/");

    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter feedback")),
      );
      return;
    }

    var response = await http.post(url, body: {
      "lid": lid,
      "feedback":feedback,

    });
    print("Response: ${response.body}");

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Feedback Added Successfully")),
      );

      // Navigator.pop(context); // back to order list
    }


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Feedback submitted")),
    );

    feedbackController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order Status"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Feedback Text ---
            Text(
              "Write your feedback:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // --- Feedback TextField ---
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// def user_feedback(request):
// lid = request.POST["lid"]
// user = user_Tbl.objects.get(LOGIN=lid)
// fk = request.POST["feedback"]
//
// old_fb = feedback.objects.filter(USER=user).first()
//
// if old_fb:
// old_fb.feedback = fk
// old_fb.date = datetime.datetime.now().today()
// old_fb.save()
// else:
// obj = feedback()
// obj.feedback = fk
// obj.date = datetime.datetime.now().today()
// obj.USER = user
// obj.save()
// return JsonResponse({'status': 'ok'})