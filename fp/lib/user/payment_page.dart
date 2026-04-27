import 'package:flutter/material.dart';
import 'package:fp/user/payment_two%20.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PaymentPage extends StatefulWidget {
  final String bookingId;
  final String workerName;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.workerName,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController amountController = TextEditingController();

  Future<void> proceedToPayment() async {
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter amount")),
      );
      return;
    }

    // 🔹 Store data in SharedPreferences
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setString('booking_id', widget.bookingId);
    await sh.setString('amd', amountController.text);

    // 🔹 Go to payment screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pay to ${widget.workerName}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: proceedToPayment,
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
