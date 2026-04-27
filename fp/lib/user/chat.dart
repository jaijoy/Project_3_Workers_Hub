import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserWorkerChat extends StatefulWidget {
  const UserWorkerChat({super.key});

  @override
  State<UserWorkerChat> createState() => _UserWorkerChatState();
}

class ChatMessage {
  String messageContent;
  String messageType; // sender / receiver

  ChatMessage({required this.messageContent, required this.messageType});
}

class _UserWorkerChatState extends State<UserWorkerChat> {
  List<ChatMessage> messages = [];
  TextEditingController teMessage = TextEditingController();

  String name = "";
  String url = "";
  String myId = "";
  String otherId = "";

  Timer? timer;

  @override
  void initState() {
    super.initState();
    loadInitialData();

    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      viewMessages();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> loadInitialData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("aname") ?? "";
      url = pref.getString("url") ?? "";
      myId = pref.getString("lid") ?? "";
      otherId = pref.getString("aid") ?? "";

      print('=================');
    });

    viewMessages();
  }

  // 🔹 VIEW CHAT
  Future<void> viewMessages() async {
    try {
      var res = await http.post(
        Uri.parse("$url/myapp/worker_viewchat"),
        body: {
          "from_id": myId,
          "to_id": otherId,
        },
      );

      var jsonData = jsonDecode(res.body);

      if (jsonData['status'] == 'ok') {
        List temp = jsonData['data'];

        List<ChatMessage> tempMessages = [];

        for (var i in temp) {
          if (i['from'].toString() == myId) {
            tempMessages.add(ChatMessage(
              messageContent: i['msg'],
              messageType: "sender",
            ));
          } else {
            tempMessages.add(ChatMessage(
              messageContent: i['msg'],
              messageType: "receiver",
            ));
          }
        }

        setState(() {
          messages = tempMessages;
        });
      }
    } catch (e) {
      debugPrint("Chat load error: $e");
    }
  }

  // 🔹 SEND MESSAGE
  Future<void> sendMessage() async {
    if (teMessage.text.trim().isEmpty) return;

    try {
      await http.post(
        Uri.parse("$url/myapp/worker_sendchat"),
        body: {
          "from_id": myId,
          "to_id": otherId,
          "message": teMessage.text,
        },
      );

      teMessage.clear();
      viewMessages();
    } catch (e) {
      debugPrint("Send error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              name,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),

      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 70, top: 10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                child: Align(
                  alignment: messages[index].messageType == "receiver"
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      messages[index].messageContent,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),

          // 🔹 INPUT BAR
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.add,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: teMessage,
                      decoration: const InputDecoration(
                        hintText: "Write message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: sendMessage,
                    backgroundColor: Colors.cyan,
                    elevation: 0,
                    child: const Icon(Icons.send, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
