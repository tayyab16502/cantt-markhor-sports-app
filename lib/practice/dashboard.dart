import 'package:flutter/material.dart';

// --- Gradient Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors ---
const Color kWhiteTextColor = Colors.white;
const Color kDarkTextColor = Color(0xFF1C1B1F);
const Color kLightGrayBackground = Color(0xFFEFF1F5);
const Color kMediumGrayTextColor = Color(0xFFA09CAB);
const Color kSubtleBlueHighlight = Color(0xFFE0E6FF);
const Color kSelectedChipColor = kGradientMediumBlue;
const Color kSelectedChipTextColor = kWhiteTextColor;
const Color kUnselectedChipColor = kLightGrayBackground;
const Color kUnselectedChipTextColor = kDarkTextColor;
const Color kIconColor = Colors.white;
const Color kBottomNavActiveIconColor = kWhiteTextColor;
const Color kBottomNavInactiveIconColor = Color(0xFFB3C0FF);
const Color kDividerColor = Color(0xFFE0E0E0);
const Color kErrorRedColor = Color(0xFFFF5252);

// --- Font Family Constant ---
const String _kFontFamily = 'Inter';

// --- Reusable Text Styles ---
TextStyle _kAppBarTitleTextStyle(BuildContext context) => TextStyle(
  color: kWhiteTextColor,
  fontFamily: _kFontFamily,
  fontSize: MediaQuery.of(context).size.width * 0.06, // 6% of screen width
  fontWeight: FontWeight.bold,
);

TextStyle _kCardTitleTextStyle(BuildContext context) => TextStyle(
  color: kDarkTextColor,
  fontFamily: _kFontFamily,
  fontSize:
  MediaQuery.of(context).size.width * 0.045, // 4.5% of screen width
  fontWeight: FontWeight.w600,
  height: 1.3,
);

TextStyle _kCardSubtitleTextStyle(BuildContext context) => TextStyle(
  color: kMediumGrayTextColor,
  fontFamily: _kFontFamily,
  fontSize:
  MediaQuery.of(context).size.width * 0.035, // 3.5% of screen width
  fontWeight: FontWeight.normal,
  height: 1.4,
);

TextStyle _kBodyTextStyle(BuildContext context) => TextStyle(
  color: kDarkTextColor,
  fontFamily: _kFontFamily,
  fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
  fontWeight: FontWeight.normal,
  height: 1.5,
);

TextStyle _kFilterChipTextStyle(BuildContext context) => TextStyle(
  color: kUnselectedChipTextColor,
  fontFamily: _kFontFamily,
  fontSize: MediaQuery.of(context).size.width * 0.035,
  fontWeight: FontWeight.normal,
);

TextStyle _kFilterChipSelectedTextStyle(BuildContext context) => TextStyle(
  color: kSelectedChipTextColor,
  fontFamily: _kFontFamily,
  fontSize: MediaQuery.of(context).size.width * 0.035,
  fontWeight: FontWeight.w500,
);

TextStyle _kBottomNavTextStyle(BuildContext context) => TextStyle(
  fontSize: MediaQuery.of(context).size.width * 0.03,
  fontFamily: _kFontFamily,
);

// --- Data Models ---
class StoryItem {
  final String userName;
  final String imageUrl;
  final IconData? icon;

  StoryItem({required this.userName, required this.imageUrl, this.icon});
}

class PostItem {
  final String userName;
  final String userImageUrl;
  final String timeAgo;
  final String? postText;
  final String? postImageUrl;
  final int likes;
  final int comments;
  final IconData? userIcon;

  PostItem({
    required this.userName,
    required this.userImageUrl,
    required this.timeAgo,
    this.postText,
    this.postImageUrl,
    this.likes = 0,
    this.comments = 0,
    this.userIcon,
  });
}

class EventCardItem {
  final String title;
  final String description;
  final String? imageUrl;
  final IconData? icon;

  EventCardItem({
    required this.title,
    required this.description,
    this.imageUrl,
    this.icon,
  });
}

// --- Enum for AppBar Menu Actions ---
enum AppBarMenuAction { settings, menubar, contactUs, about, help, logout }

// --- Placeholder Screen Widgets ---
class HomeScreenWidget extends StatelessWidget {
  final List<StoryItem> stories;
  final List<EventCardItem> eventCards;
  final List<PostItem> posts;
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext, StoryItem) buildStoryItem;
  final Widget Function(BuildContext, EventCardItem) buildEventCard;
  final Widget Function(BuildContext, PostItem) buildPostCard;
  final Widget Function(BuildContext) buildFilterChips;
  final Widget Function(BuildContext, String) buildEmptyState;

  const HomeScreenWidget({
    super.key,
    required this.stories,
    required this.eventCards,
    required this.posts,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onRefresh,
    required this.buildStoryItem,
    required this.buildEventCard,
    required this.buildPostCard,
    required this.buildFilterChips,
    required this.buildEmptyState,
  });

  @override
  Widget build(BuildContext context) {
    bool hasContent = false;
    if (selectedFilter == 'All Events') {
      hasContent = eventCards.isNotEmpty || posts.isNotEmpty;
    } else if (selectedFilter == 'Upcoming') {
      hasContent = eventCards.isNotEmpty;
    } else if (selectedFilter == 'Groups') {
      hasContent = posts.isNotEmpty;
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              itemCount: stories.length,
              itemBuilder: (context, index) =>
                  buildStoryItem(context, stories[index]),
            ),
          ),
          buildFilterChips(context),
          if (selectedFilter == 'All Events') ...[
            ...eventCards
                .map((event) => buildEventCard(context, event))
                .toList(),
            ...posts.map((post) => buildPostCard(context, post)).toList(),
          ],
          if (selectedFilter == 'Upcoming')
            ...eventCards
                .map((event) => buildEventCard(context, event))
                .toList(),
          if (selectedFilter == 'Groups')
            ...posts.map((post) => buildPostCard(context, post)).toList(),
          if (!hasContent)
            buildEmptyState(
                context, "No content available for this filter yet."),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }
}

class EventsScreenWidget extends StatelessWidget {
  const EventsScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Events Screen Content",
        style: _kBodyTextStyle(context).copyWith(color: kDarkTextColor),
      ),
    );
  }
}

class MessagesScreenWidget extends StatelessWidget {
  const MessagesScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Messages Screen Content",
        style: _kBodyTextStyle(context).copyWith(color: kDarkTextColor),
      ),
    );
  }
}

class GroupsScreenWidget extends StatelessWidget {
  const GroupsScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Groups Screen Content",
        style: _kBodyTextStyle(context).copyWith(color: kDarkTextColor),
      ),
    );
  }
}

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile Screen Content",
        style: _kBodyTextStyle(context).copyWith(color: kDarkTextColor),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentBottomNavIndex = 0;
  String _selectedFilter = 'All Events';

  final List<StoryItem> _stories = [
    StoryItem(
      userName: 'Your Story',
      imageUrl: 'assets/images/profile.jpg',
      icon: Icons.add_circle_outline,
    ),
    StoryItem(
      userName: 'Community Yoga',
      imageUrl: 'assets/images/community.jpg',
      icon: Icons.spa_outlined,
    ),
    StoryItem(
      userName: 'Music Night',
      imageUrl: 'assets/images/music night.avif',
      icon: Icons.music_note_outlined,
    ),
    StoryItem(
      userName: 'Art Workshop',
      imageUrl: 'assets/images/art.jpg',
      icon: Icons.palette_outlined,
    ),
    StoryItem(
      userName: 'Food Fest',
      imageUrl: 'assets/images/food_fest.jpeg',
      icon: Icons.fastfood_outlined,
    ),
  ];

  final List<EventCardItem> _eventCards = [
    EventCardItem(
      title: 'Nature Hike',
      description: 'Join us for a refreshing hike this Sunday!',
      imageUrl: 'assets/images/naturehike.jpeg',
      icon: Icons.hiking_outlined,
    ),
    EventCardItem(
      title: 'Pottery Class',
      description: 'Learn pottery basics in a fun group!',
      imageUrl: 'assets/images/potteryclass.jpeg',
      icon: Icons.brush_outlined,
    ),
  ];

  final List<PostItem> _posts = List.generate(
    5,
        (index) => PostItem(
      userName: 'User ${index + 1}',
      userImageUrl: 'assets/images/profile.jpg',
      userIcon: Icons.account_circle,
      timeAgo: '${(index + 1) * 10}m ago',
      postText:
      'This is post number ${index + 1}. A wonderful day to connect and share thoughts with the community! #FlutterDev #Community',
      postImageUrl: (index % 2 == 0)
          ? (index == 0
          ? 'assets/images/naturehike.jpeg'
          : (index == 2
          ? 'assets/images/potteryclass.jpeg'
          : 'assets/images/placeholder_post_even.png'))
          : null,
      likes: (index + 1) * 15,
      comments: (index + 1) * 3,
    ),
  );

  void _handleMenuSelection(AppBarMenuAction action) {
    switch (action) {
      case AppBarMenuAction.settings:
        Navigator.pushNamed(context, '/settings');
        break;
      case AppBarMenuAction.menubar:
        Navigator.pushNamed(context, '/menubar');
        break;
      case AppBarMenuAction.contactUs:
        Navigator.pushNamed(context, '/contact');
        break;
      case AppBarMenuAction.about:
        showAboutDialog(
          context: context,
          applicationName: 'Community Connect',
          applicationVersion: '1.0.0',
          applicationLegalese: '©2024 Cantt Markhor. All rights reserved.',
        );
        break;
      case AppBarMenuAction.help:
        break;
      case AppBarMenuAction.logout:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:
              Text('Confirm Logout', style: TextStyle(color: kDarkTextColor)),
              content: Text('Are you sure you want to log out?',
                  style: TextStyle(color: kDarkTextColor)),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel',
                      style: TextStyle(color: kGradientMediumBlue)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child:
                  Text('Logout', style: TextStyle(color: kErrorRedColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGrayBackground,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    String title = "Dashboard";
    if (_currentBottomNavIndex == 1) {
      title = "Events";
    } else if (_currentBottomNavIndex == 2) {
      title = "Messages";
    } else if (_currentBottomNavIndex == 3) {
      title = "Groups";
    } else if (_currentBottomNavIndex == 4) {
      title = "Profile";
    }

    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
      ),
      elevation: 1.0,
      title: Text(title, style: _kAppBarTitleTextStyle(context)),
      leading: _currentBottomNavIndex == 0
          ? Padding(
        padding:
        EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: CircleAvatar(
          backgroundColor: kLightGrayBackground,
          backgroundImage:
          const AssetImage('assets/images/profile.jpg'),
          onBackgroundImageError: (exception, stackTrace) {
            debugPrint('Error loading app bar profile image: $exception');
          },
        ),
      )
          : null,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: kIconColor,
            size: MediaQuery.of(context).size.width * 0.07,
          ),
          onPressed: () => Navigator.pushNamed(context, '/search'),
        ),
        PopupMenuButton<AppBarMenuAction>(
          icon: Icon(
            Icons.more_vert,
            color: kIconColor,
            size: MediaQuery.of(context).size.width * 0.07,
          ),
          onSelected: _handleMenuSelection,
          itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<AppBarMenuAction>>[
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.settings,
              child: ListTile(
                leading: Icon(Icons.settings_outlined, color: kDarkTextColor),
                title: Text('Settings',
                    style: _kBodyTextStyle(context)
                        .copyWith(color: kDarkTextColor)),
              ),
            ),
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.menubar,
              child: ListTile(
                leading:
                Icon(Icons.menu_book_outlined, color: kDarkTextColor),
                title: Text('Menu Bar',
                    style: _kBodyTextStyle(context)
                        .copyWith(color: kDarkTextColor)),
              ),
            ),
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.contactUs,
              child: ListTile(
                leading: Icon(Icons.contact_support_outlined,
                    color: kDarkTextColor),
                title: Text('Contact Us',
                    style: _kBodyTextStyle(context)
                        .copyWith(color: kDarkTextColor)),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.about,
              child: ListTile(
                leading: Icon(Icons.info_outline, color: kDarkTextColor),
                title: Text('About',
                    style: _kBodyTextStyle(context)
                        .copyWith(color: kDarkTextColor)),
              ),
            ),
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.help,
              child: ListTile(
                leading: Icon(Icons.help_outline, color: kDarkTextColor),
                title: Text('Help',
                    style: _kBodyTextStyle(context)
                        .copyWith(color: kDarkTextColor)),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<AppBarMenuAction>(
              value: AppBarMenuAction.logout,
              child: ListTile(
                leading: Icon(Icons.logout_outlined, color: kErrorRedColor),
                title: Text('Logout', style: TextStyle(color: kErrorRedColor)),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 4.0,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (_currentBottomNavIndex) {
      case 0:
        return HomeScreenWidget(
          stories: _stories,
          eventCards: _eventCards,
          posts: _posts,
          selectedFilter: _selectedFilter,
          onFilterChanged: (newFilter) =>
              setState(() => _selectedFilter = newFilter),
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          buildStoryItem: (context, story) => _buildStoryItem(context, story),
          buildEventCard: (context, event) => _buildEventCard(context, event),
          buildPostCard: (context, post) => _buildPostCard(context, post),
          buildFilterChips: (context) => _buildFilterChips(context),
          buildEmptyState: (context, message) =>
              _buildEmptyState(context, message),
        );
      case 1:
        return const EventsScreenWidget();
      case 2:
        return const MessagesScreenWidget();
      case 3:
        return const GroupsScreenWidget();
      case 4:
        return const ProfileScreenWidget();
      default:
        return _buildEmptyState(context, "Page Not Found");
    }
  }

  Widget _buildStoryItem(BuildContext context, StoryItem story) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story.userName == 'Your Story'
                  ? null
                  : const LinearGradient(
                colors: [Colors.orange, Colors.pinkAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundColor: kLightGrayBackground,
              backgroundImage: AssetImage(story.imageUrl),
              onBackgroundImageError: (e, s) {
                debugPrint('Error loading story image: ${story.imageUrl}');
              },
              child: story.userName == 'Your Story' && story.icon != null
                  ? CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.095,
                backgroundColor: kLightGrayBackground.withOpacity(0.8),
                child: Icon(
                  story.icon,
                  size: MediaQuery.of(context).size.width * 0.08,
                  color: kDarkTextColor,
                ),
              )
                  : null,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              story.userName,
              style: _kBodyTextStyle(context).copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: kDarkTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final filters = ['All Events', 'Upcoming', 'Groups'];
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.map((filter) {
          bool isSelected = _selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedFilter = filter);
                }
              },
              backgroundColor:
              isSelected ? kSelectedChipColor : kUnselectedChipColor,
              selectedColor: kSelectedChipColor,
              labelStyle: isSelected
                  ? _kFilterChipSelectedTextStyle(context)
                  : _kFilterChipTextStyle(context),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? kSelectedChipColor
                      : kMediumGrayTextColor.withOpacity(0.5),
                  width: isSelected ? 2.0 : 1.0,
                ),
              ),
              elevation: isSelected ? 3.0 : 0.0,
              shadowColor: Colors.black.withOpacity(0.2),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventCardItem event) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => debugPrint("Event card tapped: ${event.title}"),
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: kLightGrayBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    MediaQuery.of(context).size.width * 0.04,
                  ),
                  topRight: Radius.circular(
                    MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                image: event.imageUrl != null
                    ? DecorationImage(
                  image: AssetImage(event.imageUrl!),
                  fit: BoxFit.cover,
                  onError: (e, s) {
                    debugPrint(
                        'Error loading event image: ${event.imageUrl}');
                  },
                )
                    : null,
              ),
              child: event.imageUrl == null && event.icon != null
                  ? Icon(
                event.icon,
                size: MediaQuery.of(context).size.width * 0.15,
                color: kMediumGrayTextColor.withOpacity(0.7),
              )
                  : null,
            ),
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: _kCardTitleTextStyle(context)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(event.description,
                      style: _kCardSubtitleTextStyle(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostItem post) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.015,
      ),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.03,
        ),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => debugPrint("Post card tapped from: ${post.userName}"),
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.03,
        ),
        child: Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.06,
                    backgroundColor: kLightGrayBackground,
                    backgroundImage: AssetImage(post.userImageUrl),
                    onBackgroundImageError: (e, s) {
                      debugPrint(
                          'Error loading post user image: ${post.userImageUrl}');
                    },
                    child: (post.userImageUrl.isEmpty ||
                        (post.userImageUrl == 'assets/images/profile.jpg' &&
                            post.userIcon != null)) &&
                        post.userIcon != null
                        ? Icon(
                      post.userIcon,
                      size: MediaQuery.of(context).size.width * 0.06,
                      color: kMediumGrayTextColor.withOpacity(0.7),
                    )
                        : null,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: _kBodyTextStyle(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          post.timeAgo,
                          style: _kCardSubtitleTextStyle(context).copyWith(
                            fontSize:
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: kMediumGrayTextColor,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () => debugPrint(
                        "Post options tapped for ${post.userName}"),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (post.postText != null && post.postText!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.015,
                  ),
                  child: Text(
                    post.postText!,
                    style: _kBodyTextStyle(context).copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                      height: 1.4,
                    ),
                  ),
                ),
              if (post.postImageUrl != null && post.postImageUrl!.isNotEmpty)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.015,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02,
                    ),
                    color: kLightGrayBackground,
                    image: DecorationImage(
                      image: AssetImage(post.postImageUrl!),
                      fit: BoxFit.cover,
                      onError: (e, s) {
                        debugPrint(
                            'Error loading post image: ${post.postImageUrl}');
                      },
                    ),
                  ),
                ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.03,
                thickness: 1.0,
                color: kDividerColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPostActionButton(
                    context,
                    icon: Icons.thumb_up_alt_outlined,
                    label: '${post.likes} Likes',
                    onPressed: () =>
                        debugPrint("Like tapped for ${post.userName}"),
                  ),
                  _buildPostActionButton(
                    context,
                    icon: Icons.chat_bubble_outline,
                    label: '${post.comments} Comments',
                    onPressed: () =>
                        debugPrint("Comment tapped for ${post.userName}"),
                  ),
                  _buildPostActionButton(
                    context,
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onPressed: () =>
                        debugPrint("Share tapped for ${post.userName}"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onPressed,
      }) {
    return TextButton.icon(
      icon: Icon(
        icon,
        size: MediaQuery.of(context).size.width * 0.05,
        color: kMediumGrayTextColor,
      ),
      label: Text(
        label,
        style: _kCardSubtitleTextStyle(context).copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.032,
          color: kMediumGrayTextColor,
        ),
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        splashFactory: NoSplash.splashFactory,
        foregroundColor: kSubtleBlueHighlight,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: MediaQuery.of(context).size.width * 0.2,
            color: kMediumGrayTextColor.withOpacity(0.5),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            message,
            textAlign: TextAlign.center,
            style: _kCardSubtitleTextStyle(context).copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: kMediumGrayTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(context, Icons.home_filled, "Home", 0),
            _buildBottomNavItem(context, Icons.event_available, "Events", 1),
            _buildBottomNavItem(context, Icons.message, "Messages", 2),
            _buildBottomNavItem(context, Icons.group, "Groups", 3),
            _buildBottomNavItem(context, Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, IconData icon, String label, int index) {
    bool isSelected = _currentBottomNavIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _currentBottomNavIndex = index);
          // Add navigation based on the index
          switch (index) {
            case 1: // Events
              Navigator.pushNamed(context, '/event1');
              break;
            case 2: // Messages
              Navigator.pushNamed(context, '/message1');
              break;
            case 3: // Groups
              Navigator.pushNamed(context, '/group1');
              break;
            case 4: // Profile
              Navigator.pushNamed(context, '/profile');
              break;
            default: // Home (index 0) - no navigation needed
              break;
          }
        },
        splashColor: kSubtleBlueHighlight.withOpacity(0.3),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected
                  ? kBottomNavActiveIconColor
                  : kBottomNavInactiveIconColor,
              size: MediaQuery.of(context).size.width * (isSelected ? 0.07 : 0.065),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            Text(
              label,
              style: _kBottomNavTextStyle(context).copyWith(
                color: isSelected
                    ? kBottomNavActiveIconColor
                    : kBottomNavInactiveIconColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}