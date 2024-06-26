import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/message_tile.dart';
import 'package:flutterchatapp/components/user_tile.dart';
import 'package:flutterchatapp/models/message_model.dart';
import 'package:flutterchatapp/services/chat/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.receiverId,
      required this.receiversName,
      required this.receiverEmail,
      required this.senderName});
  final String senderName;
  final String receiversName;
  final String receiverEmail;
  final String receiverId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (_msgController.text.isEmpty) {
      return;
    }
    await _chatService.sendMessage(
      widget.receiverId,
      _msgController.text,
      widget.senderName,
      widget.receiversName,
    );
    _msgController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: UserTile(
          username: widget.receiversName,
          userEmail: widget.receiverEmail,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatService.receiveMsges(widget.receiverId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'An Erorr Occured :( ',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (ctx, index) {
                        final message = messages[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: InkWell(
                            onLongPress: () {},
                            child: MessageTile(message: message),
                          ),
                        );
                      });
                }
              },
            ),
          ),

          // message input
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  autocorrect: true,
                  controller: _msgController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.deepPurple,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.deepPurple,
                        )),
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(59, 182, 155, 182),
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
