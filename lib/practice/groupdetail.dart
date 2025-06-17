import 'package:flutter/material.dart';
import 'dart:math'; // For generating random content

// --- Reusable Text Styles (for consistency) ---
// Changed text colors to be visible on a dark background
const TextStyle _kTitleTextStyle = TextStyle(
  color: Colors.white, // Changed from kPrimaryColor
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kPageTitleTextStyle = TextStyle(
  color: Colors.white, // Changed from kPrimaryColor
  fontFamily: 'Inter',
  fontSize: 24,
  fontWeight: FontWeight.bold,
  height: 1.25,
);

const TextStyle _kSectionTitleTextStyle = TextStyle(
  color: Colors.white, // Changed from kPrimaryColor
  fontFamily: 'Inter',
  fontSize: 20,
  fontWeight: FontWeight.normal,
  height: 1.6,
);

const TextStyle _kItemTitleTextStyle = TextStyle(
  color: Color.fromRGBO(230, 230, 255, 1), // A light blueish white
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle _kItemSubtitleTextStyle = TextStyle(
  color: Color.fromRGBO(190, 190, 220, 1), // A slightly darker light blue
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4285714285714286,
);

const TextStyle _kPostContentTextStyle = TextStyle(
  color: Color.fromRGBO(230, 230, 255, 1), // Light color for post content
  fontFamily: 'Inter',
  fontSize: 15,
  height: 1.4,
);

const TextStyle _kPostMetaTextStyle = TextStyle(
  color: Color.fromRGBO(190, 190, 220, 1), // Light color for post meta info
  fontFamily: 'Inter',
  fontSize: 12,
);

// --- Color Constants (for consistency) ---
// These are largely replaced by the gradient, but keeping for other elements
const Color kPrimaryColor = Color.fromRGBO(28, 27, 31, 1); // Not used for text directly now
const Color kLightGrayColor = Color.fromRGBO(239, 241, 245, 1); // Adjusting usage
const Color kScaffoldBackgroundColor = Colors.transparent; // Scaffold background is now transparent
const Color kSubtleGrayColor = Color.fromRGBO(160, 156, 171, 1); // Adjusting usage
const Color kDividerColor = Color.fromRGBO(60, 60, 100, 1); // Darker divider for contrast

class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor, // Set scaffold background to transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Changed to white
          onPressed: () {
            // Navigate to '/group1' when the back arrow is pressed
            Navigator.pushNamed(context, '/group1');
          },
        ),
        title: Text(
          'Group Details',
          style: _kPageTitleTextStyle, // Using page title style for app bar title
        ),
        centerTitle: false,
      ),
      body: Container( // Wrap body in a Container for the gradient
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
        child: SingleChildScrollView(
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
                      color: const Color.fromRGBO(50, 50, 100, 1), // Darker placeholder
                      child: const Center(
                        child: Icon(Icons.photo_library, size: 80, color: Color.fromRGBO(100, 100, 150, 1)), // Lighter icon
                      ),
                    ),
                  )
                      : Container(
                    height: 219,
                    width: double.infinity,
                    color: const Color.fromRGBO(50, 50, 100, 1), // Darker placeholder
                    child: const Center(
                      child: Icon(Icons.photo_library, size: 80, color: Color.fromRGBO(100, 100, 150, 1)), // Lighter icon
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

                // --- Divider ---
                const Divider(color: kDividerColor, thickness: 1), // Adjusted divider color
                const SizedBox(height: 16),

                // --- Posts Section ---
                Text('Posts', style: _kSectionTitleTextStyle),
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
        Icon(icon, size: 20, color: const Color.fromRGBO(190, 190, 220, 1)), // Lighter icon color
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
          backgroundColor: const Color.fromRGBO(70, 70, 120, 1), // Darker, complementary color
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
      elevation: 3, // Slightly increased elevation for better pop on dark background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color.fromRGBO(20, 20, 70, 0.7), // Semi-transparent dark blue for cards
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color.fromRGBO(70, 70, 120, 1), // Darker, complementary color
                  child: Text(author[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
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
                    color: const Color.fromRGBO(50, 50, 100, 1), // Darker placeholder
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Color.fromRGBO(100, 100, 150, 1)), // Lighter icon
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
        Icon(icon, size: 18, color: const Color.fromRGBO(190, 190, 220, 1)), // Lighter icon color
        const SizedBox(width: 4),
        Text(text, style: _kPostMetaTextStyle),
      ],
    );
  }
}