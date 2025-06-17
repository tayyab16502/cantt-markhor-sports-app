import 'package:flutter/material.dart';

class PlayerMessage extends StatefulWidget { // Renamed class
  final String playerName; // Receives the player's name

  const PlayerMessage({
    super.key,
    required this.playerName, // Ensures playerName is passed
  });

  @override
  _PlayerMessageState createState() => _PlayerMessageState(); // Updated createState
}

class _PlayerMessageState extends State<PlayerMessage> { // Renamed state class
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // For scrolling to bottom

  // Example message list - in a real app, this would come from a state management solution
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Are we still on for the game tonight?', 'isCurrentUser': true, 'timestamp': '10:00 AM'},
    {'sender': 'other', 'texts': ['Absolutely! What time do you want to meet?', 'Let’s say 6 PM at the court.', 'Perfect, I’ll be there!'], 'timestamp': '10:01 AM'},
    {'sender': 'other', 'texts': ['I might bring a friend along.'], 'timestamp': '10:02 AM'},
    {'text': 'Sounds good!', 'isCurrentUser': true, 'timestamp': '10:03 AM'},
    {'sender': 'other', 'texts': ['Great, see you then!', 'Looking forward to it!'], 'timestamp': '10:04 AM'},
  ];

  @override
  void initState() {
    super.initState();
    // Debug print to see what playerName is received
    print('PlayerMessage received playerName: ${widget.playerName}');

    // Optional: Scroll to the bottom of the messages when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'text': text, 'isCurrentUser': true, 'timestamp': 'Now'}); // Add timestamp
        _messageController.clear();
        // Scroll to bottom after sending a new message
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      });
      // Here, you would also send the message to your backend/service
      print('Sending message: $text from current user to ${widget.playerName}');
    }
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
      backgroundColor: Colors.transparent, // Make Scaffold transparent for gradient
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove elevation for seamless gradient
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White icon
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.playerName, // Displays the dynamic player name from the constructor
          style: const TextStyle(
            color: Colors.white, // White text
            fontFamily: 'Inter',
            fontSize: 22, // Adjusted for typical name lengths
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis, // Handle long names gracefully
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white), // White icon
            onPressed: () {
              // Handle more options, e.g., view profile, block, etc.
              print('More options for chat with ${widget.playerName}');
              // Example: Show a simple menu
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width - 50, kToolbarHeight, 0, 0),
                items: [
                  PopupMenuItem<String>(
                      value: 'view_profile',
                      child: Text('View ${widget.playerName}\'s Profile',
                          style: const TextStyle(color: Color.fromRGBO(28, 27, 31, 1)))), // Black text for menu item
                  const PopupMenuItem<String>(
                      value: 'clear_chat',
                      child: Text('Clear Chat',
                          style: TextStyle(color: Color.fromRGBO(28, 27, 31, 1)))), // Black text for menu item
                  const PopupMenuItem<String>(
                      value: 'block_user',
                      child: Text('Block User',
                          style: TextStyle(color: Color.fromRGBO(28, 27, 31, 1)))), // Black text for menu item
                ],
                elevation: 8.0,
              ).then((value) {
                if (value != null) {
                  print('Selected option: $value');
                  // Implement action based on value
                }
              });
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0033FF), // Top color: #0033FF
              Color(0xFF0600AB), // Middle color: #0600AB
              Color(0xFF00003D), // Bottom color: #00003D
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final messageData = _messages[index];
                  final bool isCurrentUser = messageData['isCurrentUser'] ?? false;
                  final String? timestamp = messageData['timestamp']; // Get timestamp

                  if (isCurrentUser) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: MessageBubble(
                        text: messageData['text'],
                        isCurrentUser: true,
                        timestamp: timestamp, // Pass timestamp
                      ),
                    );
                  } else {
                    // Assuming 'sender' key exists for received messages, and 'texts' is a list
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: SenderMessageColumn(
                        senderName: widget.playerName, // Or a more specific sender name if available
                        messages: List<String>.from(messageData['texts']),
                        profileImageUrl: messageData['profileImageUrl'], // Pass if available
                        timestamp: timestamp, // Pass timestamp
                      ),
                    );
                  }
                },
              ),
            ),
            _buildMessageInput(),
            _buildBottomActionRow(),
            _buildHomeIndicator(), // Or SafeArea for bottom padding if preferred
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Make transparent to blend with gradient
        border: Border(top: BorderSide(color: Colors.white12, width: 0.5)), // Subtle white border
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color.fromRGBO(30, 30, 80, 1), // Dark subtle blue
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...', // More engaging hint text
                  hintStyle: TextStyle(
                    color: Colors.white70, // Light hint text
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Adjusted padding
                ),
                style: const TextStyle(
                  color: Colors.white, // White input text
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
                maxLines: null, // Allows for multi-line input
                textInputAction: TextInputAction.send, // Sets keyboard action to 'send'
                onSubmitted: (_) => _sendMessage(), // Allows sending via keyboard action
                cursorColor: Colors.white, // White cursor
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage, // Use the separate send message function
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF0033FF), // Primary blue for send button
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionRow() {
    return Container(
      color: Colors.transparent, // Make transparent to blend with gradient
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildActionButton(Icons.mic_none_outlined, () { /* Handle mic action */ }),
              const SizedBox(width: 16), // Increased spacing
              _buildActionButton(Icons.camera_alt_outlined, () { /* Handle camera action */ }),
              const SizedBox(width: 16),
              _buildActionButton(Icons.image_outlined, () { /* Handle image attach action */ }),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Example: Show more attachment options
              print('Attach button main pressed');
            },
            icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
            label: const Text(
              'Attach',
              style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0033FF), // Primary blue for attach button
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 44, // Slightly larger for easier tap
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent, // Transparent background
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white38, width: 1), // Subtle white border
        ),
        child: Center(
          child: Icon(icon, size: 22, color: Colors.white70), // Light icon color
        ),
      ),
    );
  }

  Widget _buildHomeIndicator() {
    return Container(
      color: Colors.transparent, // Transparent to blend with gradient
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          width: 108,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white38, // Subtle white for indicator
          ),
        ),
      ),
    );
  }
}

// --- Reusable Message Widgets ---

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isCurrentUser;
  final String? timestamp; // Added timestamp

  const MessageBubble({
    super.key,
    required this.text,
    required this.isCurrentUser,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Add vertical spacing between bubbles
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? const Color(0xFF0600AB) // Darker blue for current user's bubbles
                  : const Color.fromRGBO(30, 30, 80, 1), // Dark subtle blue for other user's bubbles
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: isCurrentUser ? const Radius.circular(18) : const Radius.circular(4), // More distinct bubble shapes
                bottomRight: isCurrentUser ? const Radius.circular(4) : const Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.white70, // White for current, lighter white for other
                fontFamily: 'Inter',
                fontSize: 15, // Slightly smaller for more text fit
                fontWeight: FontWeight.w400, // Normal weight
                height: 1.4,
              ),
            ),
          ),
          if (timestamp != null) // Display timestamp if available
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: Text(
                timestamp!,
                style: const TextStyle(
                  color: Colors.white54, // Lighter timestamp for dark background
                  fontSize: 11,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SenderMessageColumn extends StatelessWidget {
  final String senderName; // To show who the message is from
  final List<String> messages;
  final String? profileImageUrl;
  final String? timestamp; // To show timestamp for the group of messages

  const SenderMessageColumn({
    super.key,
    required this.senderName,
    required this.messages,
    this.profileImageUrl,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Vertical spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 18, // Slightly larger avatar
            backgroundColor: const Color.fromRGBO(70, 70, 120, 1), // Darker blue for avatar placeholder
            backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
            onBackgroundImageError: profileImageUrl != null ? (exception, stackTrace) {
              print("Error loading image: $exception");
              // Optionally display a placeholder or initials on error
            } : null,
            child: profileImageUrl == null
                ? Text(
              senderName.isNotEmpty ? senderName[0].toUpperCase() : '?', // Display first initial
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // White text
            )
                : null,
          ),
          const SizedBox(width: 10), // Increased spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Removed individual message bubble padding for tighter grouping
                ...messages.map(
                      (message) => MessageBubble(
                    text: message,
                    isCurrentUser: false,
                    // Timestamp will be shown below the column for grouped messages
                  ),
                ),
                if (timestamp != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                    child: Text(
                      timestamp!,
                      style: const TextStyle(
                        color: Colors.white54, // Lighter timestamp for dark background
                        fontSize: 11,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}