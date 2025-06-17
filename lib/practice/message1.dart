import 'package:flutter/material.dart';

// --- Enums ---
enum ChatType { player, group }

// --- Mock Data (Replace with your actual data source) ---
class ChatUser {
  final String id;
  final String name;
  final String? profileImageUrl; // Can be null if no image
  final String lastMessage;
  final String time;
  final bool isOnline; // Relevant for player chats
  final int unreadCount;
  final bool isGroup; // To differentiate

  ChatUser({
    required this.id,
    required this.name,
    this.profileImageUrl,
    required this.lastMessage,
    required this.time,
    this.isOnline = false,
    this.unreadCount = 0,
    this.isGroup = false,
  });
}

// --- Placeholder for your Message2Screen (Player Chat Screen) ---
class Message2Screen extends StatelessWidget {
  final String userId;
  final String userName;

  const Message2Screen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    print("Opened Message2Screen for player: $userName (ID: $userId)");
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $userName'),
        backgroundColor: Colors.transparent, // Transparent for gradient
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: Colors.white), // White icons
        titleTextStyle: const TextStyle(
          color: Colors.white, // White text
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar for full gradient
      body: Container( // Apply gradient to the body
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
        child: Center(
          child: Text(
            'This is the player chat screen for $userName!\n(Implement your 1-on-1 messages here)',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.white70), // Light text for content
          ),
        ),
      ),
    );
  }
}

// --- Placeholder for your Message3Screen (Group Chat Screen) ---
class Message3Screen extends StatelessWidget {
  final String groupId;
  final String groupName;

  const Message3Screen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    print("Opened Message3Screen for group: $groupName (ID: $groupId)");
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        backgroundColor: Colors.transparent, // Transparent for gradient
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: Colors.white), // White icons
        titleTextStyle: const TextStyle(
          color: Colors.white, // White text
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar for full gradient
      body: Container( // Apply gradient to the body
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
        child: Center(
          child: Text(
            'This is the group chat screen for $groupName (ID: $groupId)!\n(Implement your group messages here)',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.white70), // Light text for content
          ),
        ),
      ),
    );
  }
}

// --- Reusable Text Styles ---
const TextStyle kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1.25,
);

const TextStyle kEventTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

const TextStyle kEventSubtitleTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);

const TextStyle kCardTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.2,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.375,
);

// --- Color Constants ---
const Color kPrimaryColor = Color(0xFF0033FF); // Top gradient color
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);
const Color kLightGrayColor = Color.fromRGBO(50, 50, 100, 1); // Darker gray for contrast
const Color kWhiteColor = Colors.transparent; // Scaffold background
const Color kIconColor = Colors.white;
const Color kBorderColor = Color.fromRGBO(60, 60, 100, 1);
const Color kSubtleGrayColor = Color.fromRGBO(190, 190, 220, 1); // For unselected/hints
const Color kDarkSubtleBlue = Color.fromRGBO(30, 30, 80, 1); // For inputs/buttons

const TextStyle kAppBarTitleTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

// --- Main Chat List Screen Widget ---
class MessengerDashboardScreen extends StatefulWidget {
  const MessengerDashboardScreen({super.key});

  @override
  _MessengerDashboardScreenState createState() =>
      _MessengerDashboardScreenState();
}

class _MessengerDashboardScreenState extends State<MessengerDashboardScreen> {
  int _currentBottomNavIndex = 2; // Default to Messages tab
  String _searchQuery = '';
  ChatType _selectedChatType = ChatType.player;

  // Mock data (same as before)
  final List<ChatUser> _playerChatUsers = [
    ChatUser(id: 'p1', name: 'Alice Johnson', profileImageUrl: 'assets/images/alice.png', lastMessage: 'Hey! Are we still on for tonight?', time: '10:30 AM', isOnline: true, unreadCount: 2),
    ChatUser(id: 'p2', name: 'Bob Smith', lastMessage: "Don't forget the meeting at 3 PM", time: '9:15 AM'),
    ChatUser(id: 'p3', name: 'Catherine Lee', profileImageUrl: 'assets/images/catherine.png', lastMessage: 'Sent you the report. Please check.', time: 'Yesterday'),
  ];
  final List<ChatUser> _groupChatUsers = [
    ChatUser(id: 'g1', name: 'Weekend Warriors', profileImageUrl: 'assets/images/group_ww.png', lastMessage: 'David: Game on Saturday at 2?', time: '11:05 AM', unreadCount: 5, isGroup: true),
    ChatUser(id: 'g2', name: 'Project Alpha Team', lastMessage: 'You: Updated the Trello board.', time: 'Mon', isGroup: true),
    ChatUser(id: 'g3', name: 'Book Club', profileImageUrl: 'assets/images/group_bc.png', lastMessage: 'Sarah: Next meeting is on "The Midnight Library"', time: 'Sun', unreadCount: 1, isGroup: true),
  ];

  void _navigateToChatScreen(ChatUser user) {
    final routeName = user.isGroup ? '/message3' : '/message2';
    final arguments = user.isGroup
        ? {'groupId': user.id, 'groupName': user.name}
        : {'userId': user.id, 'userName': user.name};
    print("Navigating to ${user.isGroup ? "group" : "player"} chat with ${user.name} (ID: ${user.id})");
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      extendBodyBehindAppBar: true, // Crucial for gradient under AppBar
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor,         // Top color: #0033FF
              kGradientMediumBlue,   // Middle color: #0600AB
              kGradientBottomBlue,   // Bottom color: #00003D
            ],
          ),
        ),
        child: SafeArea( // Ensures content is not obscured by status bar
          bottom: false, // We handle bottom padding with BottomAppBar potentially
          child: _buildBodyContent(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    String title = "Messages";
    Widget? leadingWidget;
    List<Widget> actions = [];

    // Common actions
    actions.addAll([
      IconButton(icon: const Icon(Icons.search, color: kIconColor, size: 28), onPressed: () => print("Search pressed (global)")),
      IconButton(icon: const Icon(Icons.notifications_none_outlined, color: kIconColor, size: 28), onPressed: () => print("Notifications pressed (global)")),
    ]);

    if (_currentBottomNavIndex == 0) { // Home/Dashboard
      title = "Dashboard";
      leadingWidget = Padding(padding: const EdgeInsets.all(8.0), child: CircleAvatar(backgroundColor: kLightGrayColor, child: const Icon(Icons.account_circle, size: 24, color: kIconColor)));
    } else if (_currentBottomNavIndex == 1) { // Events
      title = "Events Calendar";
      leadingWidget = Padding(padding: const EdgeInsets.only(left: 8.0), child: IconButton(icon: const Icon(Icons.arrow_back_ios, color: kIconColor), onPressed: () {
        if (Navigator.canPop(context)) Navigator.pop(context);
        print("Back arrow pressed on Events Tab AppBar.");
      }));
      actions.add(IconButton(icon: const Icon(Icons.more_vert, color: kIconColor), onPressed: () => print('More options pressed on Events tab')));
    } else if (_currentBottomNavIndex == 2) { // Messages
      title = "Chats";
      leadingWidget = Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
        child: GestureDetector(
          onTap: () {
            print("User profile avatar tapped in Messages AppBar");
            Navigator.pushNamed(context, '/profile');
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage('assets/images/my_profile.png'),
            onBackgroundImageError: (exception, stackTrace) => print('Error loading my_profile.png: $exception'),
            backgroundColor: kLightGrayColor,
          ),
        ),
      );
      // Specific actions for Messages tab
      actions.clear(); // Remove global actions for messages tab
      actions.addAll([
        IconButton(icon: const Icon(Icons.camera_alt_outlined, color: kIconColor, size: 26), onPressed: () => print("Camera button tapped")),
        IconButton(icon: const Icon(Icons.edit_outlined, color: kIconColor, size: 26), onPressed: () => print("Edit/New message button tapped")),
      ]);
    } else if (_currentBottomNavIndex == 3) { // Groups
      title = "Groups";
    } else if (_currentBottomNavIndex == 4) { // Profile
      title = "Profile";
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title, style: kAppBarTitleTextStyle),
      leading: leadingWidget,
      actions: actions,
    );
  }

  Widget _buildBodyContent() {
    // Calculate top padding needed to be below the AppBar
    // kToolbarHeight is the default AppBar height. Add status bar height.
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double topPaddingForContent = appBarHeight + statusBarHeight;

    switch (_currentBottomNavIndex) {
      case 0: // Home
        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent),
          child: const Center(child: Text("Home Screen Content", style: kEventTextStyle)),
        );
      case 1: // Events
        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent),
          child: const Center(child: Text("Events Screen Content", style: kEventTextStyle)),
        );
      case 2: // Messages - This is where the main change happens
        final List<ChatUser> currentChatList = _selectedChatType == ChatType.player ? _playerChatUsers : _groupChatUsers;
        final List<ChatUser> filteredUsers = _searchQuery.isEmpty
            ? currentChatList
            : currentChatList.where((user) => user.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent), // Apply padding here
          child: Column(
            children: [
              _buildChatTypeSelector(), // This is now directly below the AppBar
              _buildSearchBar(),
              Expanded(
                child: _buildChatList(filteredUsers),
              ),
            ],
          ),
        );
      case 3: // Groups
        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent),
          child: const Center(child: Text("Groups Screen Content Placeholder", style: kEventTextStyle)),
        );
      case 4: // Profile
        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent),
          child: const Center(child: Text("Profile Screen Content", style: kEventTextStyle)),
        );
      default: // Fallback
        return Padding(
          padding: EdgeInsets.only(top: topPaddingForContent),
          child: Column(
            children: [
              _buildChatTypeSelector(),
              _buildSearchBar(),
              Expanded(child: _buildChatList(_playerChatUsers)),
            ],
          ),
        );
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0,
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildBottomNavItem(icon: Icons.home_filled, label: 'Home', index: 0),
            _buildBottomNavItem(icon: Icons.event_note_outlined, label: 'Events', index: 1),
            _buildBottomNavItem(icon: Icons.maps_ugc_outlined, label: 'Messages', index: 2),
            _buildBottomNavItem(icon: Icons.group_outlined, label: 'Groups', index: 3),
            _buildBottomNavItem(icon: Icons.person_outline, label: 'Profile', index: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentBottomNavIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          if (_currentBottomNavIndex != index) {
            setState(() {
              _currentBottomNavIndex = index;
              _searchQuery = '';
              _selectedChatType = ChatType.player; // Reset to default
            });
          }
          // Navigation logic
          switch (index) {
            case 0: Navigator.pushReplacementNamed(context, '/dashboard'); break;
            case 1: Navigator.pushReplacementNamed(context, '/event1'); break;
            case 2: /* Stay on this screen, content already updates */ break;
            case 3: Navigator.pushReplacementNamed(context, '/group1'); break;
            case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
          }
          print("Tapped tab: $label (index $index)");
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: isSelected ? kSubtleGrayColor : Colors.white54, size: isSelected ? 26 : 24),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(fontSize: 10, color: isSelected ? kSubtleGrayColor : Colors.white54, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTypeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(child: _buildChatTypeButton(ChatType.player, 'Player Chat')),
          const SizedBox(width: 10),
          Expanded(child: _buildChatTypeButton(ChatType.group, 'Group Chat')),
        ],
      ),
    );
  }

  Widget _buildChatTypeButton(ChatType type, String label) {
    bool isSelected = _selectedChatType == type;
    return ElevatedButton(
      onPressed: () {
        if (_selectedChatType != type) {
          setState(() {
            _selectedChatType = type;
            _searchQuery = ''; // Clear search when type changes
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? kPrimaryColor : kDarkSubtleBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: isSelected ? 2 : 0,
      ),
      child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search in ${_selectedChatType == ChatType.player ? "Player Chats" : "Group Chats"}...',
          hintStyle: const TextStyle(color: kSubtleGrayColor),
          prefixIcon: const Icon(Icons.search, color: kSubtleGrayColor),
          filled: true,
          fillColor: kDarkSubtleBlue,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: kPrimaryColor, width: 1.5)),
        ),
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
      ),
    );
  }

  Widget _buildChatList(List<ChatUser> users) {
    if (users.isEmpty) {
      return Center(child: Text(_searchQuery.isNotEmpty ? 'No results found.' : 'No ${_selectedChatType == ChatType.player ? "player" : "group"} chats yet.', style: kEventTextStyle));
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16), // Added bottom padding for FAB visibility
      itemCount: users.length,
      separatorBuilder: (context, index) => Divider(height: 0.5, indent: 88, color: kBorderColor),
      itemBuilder: (context, index) => _buildChatListItem(users[index]),
    );
  }

  Widget _buildChatListItem(ChatUser user) {
    return InkWell(
      onTap: () => _navigateToChatScreen(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: user.profileImageUrl != null ? AssetImage(user.profileImageUrl!) : null,
                  onBackgroundImageError: user.profileImageUrl != null ? (exception, stackTrace) => print('Error loading image for ${user.name}: $exception') : null,
                  backgroundColor: const Color.fromRGBO(70, 70, 120, 1),
                  child: user.profileImageUrl == null ? Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?', style: const TextStyle(fontSize: 22, color: Colors.white70, fontWeight: FontWeight.bold)) : null,
                ),
                if (user.isOnline && !user.isGroup)
                  Positioned(
                    right: 0, bottom: 0,
                    child: Container(
                      width: 14, height: 14,
                      decoration: BoxDecoration(color: Colors.greenAccent[400], shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name, style: TextStyle(fontSize: 17, fontWeight: user.unreadCount > 0 ? FontWeight.bold : FontWeight.w500, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(user.lastMessage, style: TextStyle(fontSize: 14, color: user.unreadCount > 0 ? Colors.white : Colors.white70, fontWeight: user.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.time, style: TextStyle(fontSize: 12, color: user.unreadCount > 0 ? kPrimaryColor : Colors.white54, fontWeight: user.unreadCount > 0 ? FontWeight.bold : FontWeight.normal)),
                if (user.unreadCount > 0) ...[
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    constraints: const BoxConstraints(minWidth: 21),
                    decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(12)),
                    child: Text('${user.unreadCount > 99 ? "99+" : user.unreadCount}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ] else const SizedBox(height: 24), // Keep space consistent
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (_currentBottomNavIndex == 2) { // Only for Messages tab
      return FloatingActionButton(
        onPressed: () {
          print('FAB pressed - New Message');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compose New Message Tapped')));
        },
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_comment_outlined),
        tooltip: 'New Message',
      );
    }
    return const SizedBox.shrink(); // Hide for other tabs
  }
}