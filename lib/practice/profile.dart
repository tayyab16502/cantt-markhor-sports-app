import 'package:flutter/material.dart';

// --- Theme Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

const Color kWhiteTextColor = Colors.white;
const Color kLighterBlueText = Color(0xFFA0B5E8); // For subtitles, hints, disabled elements
const Color kIconColorWhite = Colors.white;
const Color kIconColorBlue = Color(0xFF6C9DFF); // A lighter blue for prominent icons if needed

const Color kSurfaceDarkBlue = Color(0x99000A3D); // Semi-transparent dark blue for surfaces on gradient
const Color kCardBackgroundColorDark = Color(0xAA000830); // Slightly more opaque for cards
const Color kInputFillDark = Color(0x4D0A1A5E);       // Darker, semi-transparent for input fields
const Color kPrimaryButtonBlue = kGradientMediumBlue;   // Main button color
const Color kDividerColorDark = Color(0x55A0B5E8);   // Semi-transparent light blue for dividers

// --- Reusable Text Styles (Updated for Dark Theme) ---
final TextStyle _kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

final TextStyle _kProfileNameTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

final TextStyle _kCardTitleTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

final TextStyle _kCardSubtitleTextStyle = TextStyle(
  color: kLighterBlueText,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);

final TextStyle _kBodyTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

final TextStyle _kStatsCountTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

final TextStyle _kStatsLabelTextStyle = TextStyle(
  color: kLighterBlueText,
  fontFamily: 'Inter',
  fontSize: 14,
);

final TextStyle _kButtonTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final TextStyle _kTabBarLabelStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

final TextStyle _kTabBarUnselectedLabelStyle = TextStyle(
  color: kLighterBlueText,
  fontFamily: 'Inter',
  fontSize: 15,
  fontWeight: FontWeight.normal,
);


// --- Profile Screen (Main Screen) ---
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> posts = [
    {
      'user': 'Tayyab Khan',
      'avatar': 'assets/images/profile.jpg',
      'time': '5m ago',
      'content':
      'Just had an amazing workout! Feeling strong and ready for anything. 💪 #fitness #gymlife',
      'image': 'assets/images/gym.jpg'
    },
    {
      'user': 'Tayyab Khan',
      'avatar': 'assets/images/profile.jpg',
      'time': '1h ago',
      'content':
      'Ready for the weekend match! My team is fired up and ready to dominate the field. ⚽️ #soccer #matchday',
      'image': 'assets/images/soccer.jpg'
    },
    {
      'user': 'Tayyab Khan',
      'avatar': 'assets/images/profile.jpg',
      'time': '3h ago',
      'content':
      'Enjoying a healthy meal after a long run. Fueling up for the next challenge! 🥗 #healthylifestyle #running',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar( // This AppBar will remain fixed at the top
        backgroundColor: Colors.transparent, // Or a slightly visible color if preferred when scrolling
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kIconColorWhite),
          onPressed: () {
            // Consider if Navigator.pop(context) is more appropriate
            // if this screen is always pushed onto a stack.
            Navigator.pushNamed(context, '/dashboard');
            print("Back arrow pressed, navigating to /dashboard");
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: kIconColorWhite),
            onPressed: () {
              print("Share button pressed");
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: kIconColorWhite),
            onPressed: () {
              print("Edit Profile button pressed on AppBar");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileWidget()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity, // Ensure the container takes full width
        height: double.infinity, // Ensure the container takes full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kGradientTopBlue,
              kGradientMediumBlue,
              kGradientBottomBlue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView( // Makes all content scrollable together
          padding: EdgeInsets.only(
            // Adjust top padding to be below the AppBar.
            // kToolbarHeight is the standard AppBar height.
            // MediaQuery.of(context).padding.top is the status bar height.
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0, // Padding at the bottom
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Profile Header Section ---
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: kSurfaceDarkBlue,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: kLighterBlueText,
                    backgroundImage:
                    AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tayyab Khan',
                          style: _kProfileNameTextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Loves sports, traveling, and exploring new recipes. Passionate about community and making a difference.',
                          style: _kBodyTextStyle.copyWith(
                              color: kLighterBlueText, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatItem('250', 'Followers'),
                  const SizedBox(width: 24),
                  _buildStatItem('10', 'Following'),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("Create Post button pressed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreatePostWidget()),
                        );
                      },
                      icon: const Icon(Icons.add_box_outlined,
                          color: kIconColorWhite),
                      label: Text('Create Post', style: _kButtonTextStyle),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryButtonBlue,
                        foregroundColor: kWhiteTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        print("Edit Profile button pressed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileWidget()),
                        );
                      },
                      icon: const Icon(Icons.edit_note_outlined,
                          color: kLighterBlueText),
                      label: Text('Edit Profile',
                          style: _kButtonTextStyle.copyWith(
                              color: kLighterBlueText)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kLighterBlueText,
                        side: const BorderSide(
                            color: kLighterBlueText, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Space before TabBar

              // --- TabBar Section ---
              Container( // Optional: Add a background to the TabBar container if needed
                decoration: BoxDecoration(
                  color: kSurfaceDarkBlue.withOpacity(0.5), // Example background
                  borderRadius: BorderRadius.circular(8), // Optional: if you want rounded corners for the tab bar background
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: kIconColorBlue,
                  labelColor: kWhiteTextColor,
                  unselectedLabelColor: kLighterBlueText,
                  labelStyle: _kTabBarLabelStyle,
                  unselectedLabelStyle: _kTabBarUnselectedLabelStyle,
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'Groups'),
                    Tab(text: 'Stats'),
                  ],
                ),
              ),

              // --- TabBarView Section ---
              // The TabBarView needs a constrained height when inside a SingleChildScrollView
              // or its children (like ListView) need to be shrinkWrapped and have their own scrolling disabled.
              // For simplicity, let's wrap it in a SizedBox for now.
              // You might need to adjust this height based on your content.
              SizedBox(
                // You'll likely want to calculate a more dynamic height
                // or ensure the content within TabBarView is appropriately sized.
                // For ListView.builder, it will try to take infinite height
                // if not constrained or if `shrinkWrap` is not true and `physics` is not NeverScrollableScrollPhysics.
                height: MediaQuery.of(context).size.height * 0.7, // Example: 70% of screen height, adjust as needed
                // This is a common challenge with nested scrollables.
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPostsList(), // This ListView will scroll internally
                    Center(
                        child: Text('Groups Content Will Appear Here',
                            style: _kBodyTextStyle.copyWith(
                                color: kLighterBlueText))),
                    Center(
                        child: Text('Stats Content Will Appear Here',
                            style: _kBodyTextStyle.copyWith(
                                color: kLighterBlueText))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(count, style: _kStatsCountTextStyle),
        Text(label, style: _kStatsLabelTextStyle),
      ],
    );
  }

  Widget _buildPostsList() {
    if (posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No posts yet. Create your first post!',
            style: _kBodyTextStyle.copyWith(color: kLighterBlueText),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    // This ListView will scroll independently if its content is larger than the SizedBox height for TabBarView
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16.0), // Adjust padding as needed
      // To make the SingleChildScrollView handle ALL scrolling for the posts list:
      // 1. Remove the SizedBox wrapper around TabBarView OR make its height very large/dynamic.
      // 2. Uncomment the next two lines:
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final bool isLocalImage =
            post['image'] != null && post['image']!.startsWith('assets/');

        return Card(
          color: kCardBackgroundColorDark,
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: kLighterBlueText,
                      backgroundImage: AssetImage(post['avatar']!),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['user']!,
                            style: _kBodyTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: kWhiteTextColor),
                          ),
                          Text(
                            post['time']!,
                            style: _kCardSubtitleTextStyle.copyWith(
                                fontSize: 12, color: kLighterBlueText),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz,
                          color: kLighterBlueText),
                      onPressed: () {
                        print('More options for post ${index + 1}');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (post['image'] != null && post['image']!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: isLocalImage
                          ? Image.asset(
                        post['image']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              height: 200,
                              color: kInputFillDark,
                              child: const Center(
                                  child: Icon(Icons.broken_image,
                                      color: kLighterBlueText)),
                            ),
                      )
                          : Image.network(
                        post['image']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              height: 200,
                              color: kInputFillDark,
                              child: const Center(
                                  child: Icon(Icons.broken_image,
                                      color: kLighterBlueText)),
                            ),
                      ),
                    ),
                  ),
                Text(
                  post['content']!,
                  style: _kBodyTextStyle.copyWith(color: kWhiteTextColor),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.thumb_up_alt_outlined,
                          size: 20, color: kLighterBlueText),
                      label: Text('Like',
                          style: TextStyle(
                              color: kLighterBlueText, fontFamily: 'Inter')),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    TextButton.icon(
                      icon: const Icon(Icons.chat_bubble_outline,
                          size: 20, color: kLighterBlueText),
                      label: Text('Comment',
                          style: TextStyle(
                              color: kLighterBlueText, fontFamily: 'Inter')),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Create Post Widget ---
class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({super.key});

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController _postTextController = TextEditingController();

  @override
  void dispose() {
    _postTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kIconColorWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Post', style: _kAppBarTitleTextStyle),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: kLighterBlueText,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tayyab Khan', // In a real app, get the current user's name
                      style: _kBodyTextStyle.copyWith(fontWeight: FontWeight.bold, color: kWhiteTextColor),
                    ),
                    Text(
                      'Public',
                      style: _kCardSubtitleTextStyle.copyWith(fontSize: 12, color: kLighterBlueText),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _postTextController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                style: _kBodyTextStyle.copyWith(color: kWhiteTextColor),
                cursorColor: kIconColorBlue,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: _kCardSubtitleTextStyle.copyWith(fontSize: 16, color: kLighterBlueText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                print('Upload Photos tapped');
                // You would typically open an image picker here
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: kInputFillDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.photo_library_outlined,
                      color: kIconColorWhite,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Upload Photos',
                      style: _kBodyTextStyle.copyWith(color: kWhiteTextColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Post button pressed with text: ${_postTextController.text}');
                      // Add logic to actually create the post
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryButtonBlue,
                      foregroundColor: kWhiteTextColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Post',
                      style: _kButtonTextStyle.copyWith(color: kWhiteTextColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      print('Cancel button pressed');
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kLighterBlueText,
                      side: const BorderSide(color: kLighterBlueText, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: _kButtonTextStyle.copyWith(color: kLighterBlueText),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Added for some padding at the very bottom if keyboard is dismissed
          ],
        ),
      ),
    );
  }
}

// --- Edit Profile Widget ---
class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  bool _obscurePassword = true;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Tayyab Khan');
    _emailController = TextEditingController(text: 'tayyabkhan190247@gmail.com');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kIconColorWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile', style: _kAppBarTitleTextStyle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryButtonBlue,
              radius: 20,
              child: const Icon(
                Icons.people_alt_outlined,
                color: kIconColorWhite,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView( // Added SingleChildScrollView here for EditProfileWidget
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 16.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Picture', style: _kCardTitleTextStyle.copyWith(color: kWhiteTextColor)),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: kInputFillDark,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: kPrimaryButtonBlue,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: kIconColorWhite, size: 20),
                          onPressed: () {
                            print('Change profile picture tapped');
                            // You would typically open an image picker here
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('Name', style: _kCardTitleTextStyle.copyWith(color: kWhiteTextColor)),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _nameController,
                hintText: 'Enter your name',
              ),
              const SizedBox(height: 24),
              Text('Email', style: _kCardTitleTextStyle.copyWith(color: kWhiteTextColor)),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Text('Password', style: _kCardTitleTextStyle.copyWith(color: kWhiteTextColor)),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _passwordController,
                hintText: 'Enter new password (optional)',
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Save Changes button pressed');
                    print('Name: ${_nameController.text}');
                    print('Email: ${_emailController.text}');
                    if (_passwordController.text.isNotEmpty) {
                      print('New Password: ${_passwordController.text}');
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryButtonBlue,
                    foregroundColor: kWhiteTextColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Save Changes',
                    style: _kButtonTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Added for some padding at the very bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: _kBodyTextStyle.copyWith(color: kWhiteTextColor),
      cursorColor: kIconColorBlue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _kCardSubtitleTextStyle.copyWith(color: kLighterBlueText),
        fillColor: kInputFillDark,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kIconColorBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      obscureText: _obscurePassword,
      style: _kBodyTextStyle.copyWith(color: kWhiteTextColor),
      cursorColor: kIconColorBlue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _kCardSubtitleTextStyle.copyWith(color: kLighterBlueText),
        fillColor: kInputFillDark,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kIconColorBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: kLighterBlueText,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }
}