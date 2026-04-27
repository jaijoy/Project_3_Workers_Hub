import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductRatingPage extends StatefulWidget {
  const ProductRatingPage({super.key});

  @override
  State<ProductRatingPage> createState() => _ProductRatingPageState();
}

class _ProductRatingPageState extends State<ProductRatingPage> {
  double rating = 0;
  TextEditingController reviewController = TextEditingController();
  bool isLoading = false;
  late String urls;

  Future<void> submitRating() async {

    // ⭐ Rating validation
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please give a rating')),
      );
      return;
    }

    // ✍️ Review validation
    if (reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a review')),
      );
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? lid = sh.getString('lid');
    String? item_id = sh.getString('booking_id');
    urls = sh.getString('url') ?? '';

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('$urls/myapp/user_rating/'),
      body: {
        'book_id': item_id ?? '',
        'lid': lid ?? '',
        'rating': rating.toString(),
        'review': reviewController.text.trim(),
      },
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rating submitted successfully')),
        );
        Navigator.pop(context);
      }
      else if (jsonData['status'] == 'updated') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review updated successfully')),
        );
        Navigator.pop(context);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit rating')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error, please try again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Rating"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Rate the Product",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write your review here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: submitRating,
                icon: const Icon(Icons.send),
                label: const Text(
                  "Submit Rating",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
