import 'package:flutter/material.dart';
import 'dart:math'; // For generating random content

// --- Reusable Text Styles (for consistency) ---
// Adjusted for better visibility on a dark background
const TextStyle _kButtonTextStyle = TextStyle(
  color: Colors.white, // Keep white for buttons
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.375,
);

const TextStyle _kTitleTextStyle = TextStyle(
  color: Colors.white, // Changed for dark background
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kPageTitleTextStyle = TextStyle( // For the main page title
  color: Colors.white, // Changed for dark background
  fontFamily: 'Inter',
  fontSize: 24,
  fontWeight: FontWeight.bold,
  height: 1.25,
);

const TextStyle _kSectionTitleTextStyle = TextStyle(
  color: Colors.white70, // Slightly subdued white for sections
  fontFamily: 'Inter',
  fontSize: 20,
  fontWeight: FontWeight.normal,
  height: 1.6,
);

const TextStyle _kItemTitleTextStyle = TextStyle(
  color: Colors.white, // Changed for dark background
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle _kItemSubtitleTextStyle = TextStyle(
  color: Colors.white60, // Subdued white for subtitles
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4285714285714286,
);

const TextStyle _kPostContentTextStyle = TextStyle(
  color: Colors.white, // Changed for dark background
  fontFamily: 'Inter',
  fontSize: 15,
  height: 1.4,
);

const TextStyle _kPostMetaTextStyle = TextStyle(
  color: Colors.white54, // Very subdued white for meta info
  fontFamily: 'Inter',
  fontSize: 12,
);


// --- Color Constants (for consistency) ---
// These will be less used as the gradient will dominate, but kept for clarity where needed.
const Color kPrimaryColor = Color(0xFF0033FF); // Top gradient color as a primary action color
const Color kLightGrayColor = Color.fromRGBO(30, 30, 60, 1); // Darkened for placeholders/avatars
const Color kSubtleGrayColor = Color.fromRGBO(100, 100, 150, 1); // Darkened for icons/dividers
const Color kDividerColor = Color.fromRGBO(50, 50, 100, 1); // Darkened divider

class Group2 extends StatefulWidget {
  const Group2({Key? key}) : super(key: key);

  @override
  _Group2State createState() => _Group2State();
}

class _Group2State extends State<Group2> {
  // --- Placeholder Data ---
  final String _groupName = 'Nature Lovers Club';
  final String _groupDescription =
      'Join us for monthly hikes and outdoor adventures! We explore local trails, share nature photography, and promote conservation. All skill levels welcome.';
  final String _groupCoverImageUrl = ''; // Replace with actual URL or use placeholder
  final String _adminName = 'John Doe';
  final String _adminRole = 'Hiking Enthusiast (Admin)';
  final String _member1Name = 'Jane Smith';
  final String _member1Role = 'Outdoor Explorer';
  final String _member2Name = 'Mike Green';
  final String _member2Role = 'Bird Watcher';

  // Example state for the button
  bool _isJoined = false;

  // Random posts data
  final List<Map<String, String>> _posts = [
    {
      'author': 'John Doe',
      'time': '2 hours ago',
      'content': 'Had an amazing hike on the Skyline Trail today! The views were breathtaking. Don\'t forget to stay hydrated!',
      'image': 'https://picsum.photos/seed/hike1/400/300', // Example random image
    },
    {
      'author': 'Jane Smith',
      'time': 'Yesterday',
      'content': 'Spotted a rare blue jay during my morning walk. Nature always has surprises in store! 🐦',
      'image': 'https://picsum.photos/seed/bird2/400/300',
    },
    {
      'author': 'Mike Green',
      'time': '3 days ago',
      'content': 'Planning a campfire and stargazing night next month. Who\'s in? ✨',
      'image': '', // No image for this post
    },
    {
      'author': 'John Doe',
      'time': '1 week ago',
      'content': 'Just a reminder about our upcoming meetup on October 15th at City Park. See you all there!',
      'image': '',
    },
  ];

  void _onJoinGroupPressed() {
    setState(() {
      _isJoined = !_isJoined;
    });
    // In a real app, you'd send a request to your backend or update global state
    print(_isJoined ? 'Joined $_groupName' : 'Left $_groupName');

    // Example: Navigate to a "My Groups" screen after joining
    if (_isJoined) {
      Navigator.pushReplacementNamed(context, '/groups'); // Example: Go to the main groups list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Use Container to apply gradient to the whole screen
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0033FF), // Top color
            Color(0xFF0600AB), // Middle color
            Color(0xFF00003D), // Bottom color
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make Scaffold background transparent
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make AppBar background transparent
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white), // Changed icon color
            onPressed: () {
              // Navigate to '/search' when the back arrow is pressed
              Navigator.pushNamed(context, '/search');
            },
          ),
          title: Text(
            'Group Details',
            style: _kPageTitleTextStyle, // Using page title style for app bar title
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // --- Group Cover Image / Placeholder ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _groupCoverImageUrl.isNotEmpty
                      ? Image.network(
                    _groupCoverImageUrl,
                    height: 219,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 219,
                      color: kLightGrayColor, // Adjusted placeholder color
                      child: const Center(
                        child: Icon(Icons.photo_library, size: 80, color: kSubtleGrayColor), // Adjusted icon color
                      ),
                    ),
                  )
                      : Container(
                    height: 219,
                    width: double.infinity,
                    color: kLightGrayColor, // Adjusted placeholder color
                    child: const Center(
                      child: Icon(Icons.photo_library, size: 80, color: kSubtleGrayColor), // Adjusted icon color
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // --- Group Name & Description ---
                Text(
                  _groupName,
                  style: _kPageTitleTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  _groupDescription,
                  style: _kItemSubtitleTextStyle.copyWith(height: 1.4),
                ),
                const SizedBox(height: 20),

                // --- Location Info ---
                _buildInfoRow(Icons.location_on_outlined, 'Location', 'City Park, Main Entrance'),
                const SizedBox(height: 12),
                // --- Next Meetup Info ---
                _buildInfoRow(Icons.calendar_today_outlined, 'Next Meetup', 'October 15, 2023'),
                const SizedBox(height: 20),

                // --- Divider ---
                const Divider(color: kDividerColor, thickness: 1), // Adjusted divider color
                const SizedBox(height: 16),

                // --- Members Section ---
                Text('Members', style: _kSectionTitleTextStyle),
                const SizedBox(height: 8),
                _buildUserChip(_adminName, _adminRole),
                const SizedBox(height: 8),
                _buildUserChip(_member1Name, _member1Role),
                const SizedBox(height: 8),
                _buildUserChip(_member2Name, _member2Role),
                const SizedBox(height: 32),

                // --- Join Group Button ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isJoined ? kSubtleGrayColor : kPrimaryColor, // Adjusted button colors
                      foregroundColor: Colors.white, // Ensure text is white
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _onJoinGroupPressed,
                    child: Text(
                      _isJoined ? 'Joined' : 'Join Group',
                      style: _kButtonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 32), // Spacing after the button

                // --- Divider before posts ---
                const Divider(color: kDividerColor, thickness: 1), // Adjusted divider color
                const SizedBox(height: 16),

                // --- Posts Section ---
                Text('Recent Posts', style: _kSectionTitleTextStyle),
                const SizedBox(height: 12),
                // Iterate through posts and build them
                ListView.builder(
                  shrinkWrap: true, // Important for nested scrollables
                  physics: const NeverScrollableScrollPhysics(), // Posts list view should not scroll independently
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return _buildPostCard(
                      post['author']!,
                      post['time']!,
                      post['content']!,
                      post['image']!,
                    );
                  },
                ),
                const SizedBox(height: 20), // Spacing at the bottom of the scroll view
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for info rows
  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 20, color: Colors.white70), // Changed icon color
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kItemTitleTextStyle.copyWith(fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle, style: _kItemSubtitleTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for member chips
  Widget _buildUserChip(String name, String role, {String? avatarUrl}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: kSubtleGrayColor, // Adjusted avatar background color
          backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty) ? NetworkImage(avatarUrl) : null,
          child: (avatarUrl == null || avatarUrl.isEmpty)
              ? Text(name.isNotEmpty ? name[0].toUpperCase() : 'U', style: const TextStyle(color: Colors.white))
              : null,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: _kItemTitleTextStyle),
            Text(role, style: _kItemSubtitleTextStyle),
          ],
        ),
      ],
    );
  }

  // Helper widget for building a post card
  Widget _buildPostCard(String author, String time, String content, String imageUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white10, // Darkened card background for professional look
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: kSubtleGrayColor, // Adjusted avatar background
                  child: Text(author[0].toUpperCase(), style: const TextStyle(color: Colors.white)), // White text on avatar
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author, style: _kItemTitleTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(time, style: _kPostMetaTextStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: _kPostContentTextStyle,
            ),
            if (imageUrl.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: kLightGrayColor, // Adjusted placeholder color
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50, color: kSubtleGrayColor), // Adjusted icon color
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            // Example of post actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPostAction(Icons.thumb_up_alt_outlined, 'Like'),
                _buildPostAction(Icons.comment_outlined, 'Comment'),
                _buildPostAction(Icons.share_outlined, 'Share'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70), // Changed icon color
        const SizedBox(width: 4),
        Text(text, style: _kPostMetaTextStyle),
      ],
    );
  }
}