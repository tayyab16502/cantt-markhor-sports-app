import 'package:flutter/material.dart';

// --- Theme Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

const Color kWhiteTextColor = Colors.white;
const Color kLighterBlueText = Color(0xFFA0B5E8); // For less prominent text like timestamps, member counts
const Color kMyMessageBubbleColor = kGradientMediumBlue; // Or a slightly lighter/darker shade
const Color kOtherMessageBubbleColor = Color(0xFF2A2D5E); // A darker, desaturated blue for contrast
const Color kChatInputBackgroundColor = Color(0xFF00002A); // Very dark blue for input field area
const Color kIconColor = kWhiteTextColor;
const Color kSenderNameColor = kLighterBlueText; // Color for sender's name in group chat

// --- Data Models (Keep these simple for now) ---
class Message {
  final String id;
  final String text;
  final String senderId; // To identify if it's "my" message or "others'"
  final DateTime timestamp;
  final String? senderName; // Optional: for group chats to show sender name

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.senderName,
  });
}

class User {
  final String id;
  final String name;
  final String? avatarUrl; // Placeholder for profile image

  User({required this.id, required this.name, this.avatarUrl});
}

// --- Group Chat Screen ---
class GroupChatScreen extends StatefulWidget {
  final String groupId; // To fetch group details and messages
  final String currentUserId; // To determine "my" messages

  const GroupChatScreen({
    super.key,
    required this.groupId,
    required this.currentUserId,
  });

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];
  String _groupName = "Weekend Warriors"; // Fetch dynamically
  List<User> _groupMembers = []; // Fetch dynamically
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = User(id: widget.currentUserId, name: "Me");
    _loadMockMessages();
  }

  void _loadMockMessages() {
    setState(() {
      _messages = [
        Message(id: '1', text: 'Hey everyone!', senderId: 'user2', senderName: 'Alice', timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
        Message(id: '2', text: 'How are you all doing?', senderId: 'user3', senderName: 'Bob', timestamp: DateTime.now().subtract(const Duration(minutes: 9))),
        Message(id: '3', text: 'Let’s plan for the weekend.', senderId: 'user3', senderName: 'Bob', timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
        Message(id: '4', text: 'I can bring snacks!', senderId: widget.currentUserId, timestamp: DateTime.now().subtract(const Duration(minutes: 7))),
        Message(id: '5', text: 'Sounds good to me!', senderId: 'user4', senderName: 'Charlie', timestamp: DateTime.now().subtract(const Duration(minutes: 6))),
        Message(id: '6', text: 'Count me in!', senderId: 'user2', senderName: 'Alice', timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
        Message(id: '7', text: 'I’ll organize the games.', senderId: widget.currentUserId, timestamp: DateTime.now().subtract(const Duration(minutes: 4))),
        Message(id: '8', text: 'Can’t wait to see you all!', senderId: 'user3', senderName: 'Bob', timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
      ];
      _groupMembers = [
        User(id: 'user2', name: 'Alice', avatarUrl: 'assets/images/alice.png'),
        User(id: 'user3', name: 'Bob', avatarUrl: 'assets/images/bob.png'),
        User(id: 'user4', name: 'Charlie', avatarUrl: 'assets/images/charlie.png'),
      ];
    });
    _scrollToBottom();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _messageController.text.trim(),
      senderId: widget.currentUserId,
      timestamp: DateTime.now(),
    );
    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows gradient to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: kIconColor), // Back button color
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _groupName,
              style: const TextStyle(
                color: kWhiteTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_groupMembers.isNotEmpty)
              Text(
                '${_groupMembers.length} members',
                style: const TextStyle(
                  color: kLighterBlueText, // Lighter color for member count
                  fontSize: 12,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, color: kIconColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Call button tapped (not implemented)')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: kIconColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video call button tapped (not implemented)')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: kIconColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options tapped (not implemented)')),
              );
            },
          ),
        ],
      ),
      body: Container( // Wrap body with Container for gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _messages.isEmpty
                  ? const Center(child: Text('No messages yet. Say something!', style: TextStyle(color: kLighterBlueText)))
                  : ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: kToolbarHeight + MediaQuery.of(context).padding.top + 16.0, // Adjust for AppBar and status bar
                  bottom: 16.0,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMyMessage = message.senderId == widget.currentUserId;
                  final sender = _groupMembers.firstWhere(
                          (member) => member.id == message.senderId,
                      orElse: () => User(id: message.senderId, name: 'Unknown User'));

                  return _MessageBubble(
                    message: message,
                    isMyMessage: isMyMessage,
                    sender: isMyMessage ? null : sender,
                  );
                },
              ),
            ),
            _MessageInputField(
              controller: _messageController,
              onSendPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Message Bubble Widget ---
class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMyMessage;
  final User? sender;

  const _MessageBubble({
    required this.message,
    required this.isMyMessage,
    this.sender,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Not needed if defining colors directly
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
        isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (!isMyMessage && sender != null) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: kOtherMessageBubbleColor.withOpacity(0.5), // Themed avatar background
              child: Text(
                sender!.name.isNotEmpty ? sender!.name[0].toUpperCase() : '?',
                style: const TextStyle(color: kWhiteTextColor),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMyMessage && sender != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 2.0),
                    child: Text(
                      sender!.name,
                      style: const TextStyle(fontSize: 12, color: kSenderNameColor),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMyMessage
                        ? kMyMessageBubbleColor
                        : kOtherMessageBubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isMyMessage ? const Radius.circular(18) : const Radius.circular(4),
                      bottomRight: isMyMessage ? const Radius.circular(4) : const Radius.circular(18),
                    ),
                  ),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      color: kWhiteTextColor, // All text in bubbles is white
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
                  child: Text(
                    '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 10, color: kLighterBlueText), // Lighter color for timestamp
                  ),
                ),
              ],
            ),
          ),
          // if (isMyMessage) ...[ // Removed as there's no specific element for "my message" side yet
          //   const SizedBox(width: 8),
          // ],
        ],
      ),
    );
  }
}

// --- Message Input Field Widget ---
class _MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;

  const _MessageInputField({
    required this.controller,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: kChatInputBackgroundColor, // Dark background for input area
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 5, // Slightly more blur
            color: Colors.black.withOpacity(0.3), // Darker shadow for depth
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined, color: kIconColor),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attach media tapped (not implemented)')),
                );
              },
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: kWhiteTextColor), // Input text color
                  cursorColor: kGradientTopBlue, // Cursor color
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: const TextStyle(color: kLighterBlueText), // Hint text color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: kGradientBottomBlue.withOpacity(0.5), // Darker, semi-transparent fill
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send, color: kIconColor), // Send icon color
              onPressed: onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}