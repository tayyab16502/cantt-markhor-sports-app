import 'package:flutter/material.dart';

// --- Gradient Color Constants (from previous updates) ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors (from previous updates) ---
const Color kWhiteTextColor = Colors.white; // For text on gradients and dark backgrounds
const Color kDarkTextColor = Color(0xFF1C1B1F); // For text on white/light backgrounds
const Color kLightGrayBackground = Color(0xFFEFF1F5); // General scaffold and card background
const Color kMediumGrayTextColor = Color(0xFFA09CAB); // For secondary text, disabled icons
const Color kPrimaryButtonBlue = kGradientMediumBlue; // Main button color
const Color kAccentBlue = kGradientTopBlue; // For accents like active borders, primary icons
const Color kDividerColor = Color(0xFFE0E0E0); // Lighter divider color
const Color kSuccessColor = Color(0xFF4CAF50); // Green for success
const Color kWarningColor = Color(0xFFFFC107); // Orange for warning/maybe
const Color kInfoColor = Color(0xFF2196F3); // Blue for info/pending
const Color kErrorColor = Color(0xFFFF5252); // Red for errors

// --- Reusable Text Styles (Adjusted for the new theme) ---
const TextStyle kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor, // AppBar title is white on gradient
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const TextStyle kCardTitleTextStyle = TextStyle(
  color: kDarkTextColor, // Titles on white background
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w700, // Slightly bolder for cards
  height: 1.3,
);

const TextStyle kCardSubtitleTextStyle = TextStyle(
  color: kMediumGrayTextColor, // Subtitles on white background
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);

const TextStyle kBodyTextStyle = TextStyle(
  color: kDarkTextColor, // General body text
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle kSearchHintStyle = TextStyle(
  color: kMediumGrayTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
);

const TextStyle kChipLabelStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 13,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const TextStyle kViewButtonTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
  fontSize: 13,
);

const TextStyle kBottomNavLabelStyle = TextStyle(
  fontSize: 10,
  fontFamily: 'Inter',
);


// --- Mock Data Structures ---
class Group {
  final String id;
  final String name;
  final String imageUrl;
  final String memberCount;
  final String category;
  final bool isMyGroup; // Added to identify user's created groups

  Group({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.memberCount,
    required this.category,
    this.isMyGroup = false, // Default to false
  });
}

class CategoryChip {
  final String label;
  final IconData icon;

  CategoryChip({required this.label, required this.icon});
}


// --- GroupScreen ---
class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int _currentBottomNavIndex = 3; // Groups tab is index 3
  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _showMyGroups = false; // New state variable to toggle between all groups and my groups

  final List<CategoryChip> _categories = [
    CategoryChip(label: 'All', icon: Icons.list_alt_outlined),
    CategoryChip(label: 'Soccer', icon: Icons.sports_soccer_outlined),
    CategoryChip(label: 'Basketball', icon: Icons.sports_basketball_outlined),
    CategoryChip(label: 'Yoga', icon: Icons.self_improvement_outlined),
    CategoryChip(label: 'Cycling', icon: Icons.directions_bike_outlined),
    CategoryChip(label: 'Running', icon: Icons.directions_run_outlined),
  ];

  final List<Group> _allGroups = [
    Group(id: '1', name: 'Soccer Fanatics', imageUrl: 'assets/images/soccer_group.png', memberCount: '30 members', category: 'Soccer', isMyGroup: true), // Marked as my group
    Group(id: '2', name: 'Basketball Besties', imageUrl: 'assets/images/basketball_group.png', memberCount: '20 members', category: 'Basketball'),
    Group(id: '3', name: 'Yoga Lovers', imageUrl: 'assets/images/yoga_group.png', memberCount: '15 members', category: 'Yoga'),
    Group(id: '4', name: 'Cycling Crew', imageUrl: 'assets/images/cycling_group.png', memberCount: '25 members', category: 'Cycling'),
    Group(id: '5', name: 'Running Rascals', imageUrl: 'assets/images/running_group.png', memberCount: '40 members', category: 'Running', isMyGroup: true), // Marked as my group
    Group(id: '6', name: 'Weekend Kickabout', imageUrl: 'assets/images/soccer_group_2.png', memberCount: '18 members', category: 'Soccer'),
    Group(id: '7', name: 'Hoops Nation', imageUrl: 'assets/images/basketball_group_2.png', memberCount: '22 members', category: 'Basketball'),
  ];

  List<Group> get _filteredGroups {
    List<Group> groups = _allGroups;

    if (_showMyGroups) {
      groups = groups.where((group) => group.isMyGroup).toList();
    } else {
      if (_selectedCategory != 'All') {
        groups = groups.where((group) => group.category == _selectedCategory).toList();
      }
    }

    if (_searchQuery.isNotEmpty) {
      groups = groups.where((group) => group.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGrayBackground, // Consistent light gray background
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
      elevation: 1.0, // Slight elevation
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteTextColor), // Modern back icon, white
        onPressed: () {
          // Navigate to the dashboard and remove all routes until then
          Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
          debugPrint("Back arrow pressed, navigating to Dashboard.");
        },
      ),
      title: const Text("Groups", style: kAppBarTitleTextStyle),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: kWhiteTextColor, size: 28), // White bell icon
          onPressed: () {
            debugPrint("Notifications pressed");
            // Handle notifications action
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: kWhiteTextColor, size: 28), // White more icon
          onPressed: () {
            debugPrint("More options pressed");
            // Handle more options action (e.g., PopupMenuButton)
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildSearchBar(),
        _buildCategoryChips(),
        _buildMyGroupsButton(), // New button for "View My Created Groups"
        Expanded(
          child: _filteredGroups.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _searchQuery.isNotEmpty || _selectedCategory != 'All' || _showMyGroups
                    ? 'No groups match your criteria.\nTry adjusting your filters.'
                    : 'No groups available right now.\nStart by creating one!',
                style: kBodyTextStyle.copyWith(color: kMediumGrayTextColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: _filteredGroups.length,
            itemBuilder: (context, index) {
              return _buildGroupCard(_filteredGroups[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0), // Adjusted bottom padding
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        style: kBodyTextStyle.copyWith(fontSize: 15), // Text entered
        decoration: InputDecoration(
          hintText: 'Search for groups or sports...',
          hintStyle: kSearchHintStyle,
          prefixIcon: Icon(Icons.search, color: kMediumGrayTextColor.withOpacity(0.8), size: 24), // Themed icon
          filled: true,
          fillColor: kWhiteTextColor, // Search bar background white
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), // Adjusted padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: kDividerColor, width: 1.0), // Subtle border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: kAccentBlue, width: 2.0), // Accent border on focus
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    // Only show category chips if not viewing "My Groups"
    if (_showMyGroups) {
      return const SizedBox.shrink(); // Hide chips if showing my groups
    }
    return Container(
      height: 55, // Adjusted height for better fit
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduced vertical padding
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemBuilder: (context, index) {
          final category = _categories[index];
          bool isSelected = _selectedCategory == category.label;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0), // Adjusted padding
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 18,
                      color: isSelected ? kWhiteTextColor : kDarkTextColor.withOpacity(0.8), // Themed colors
                    ),
                    const SizedBox(width: 8), // Increased spacing
                    Text(category.label, style: kChipLabelStyle),
                  ],
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  _selectedCategory = selected ? category.label : 'All';
                });
              },
              backgroundColor: kWhiteTextColor, // Chip background white
              selectedColor: kPrimaryButtonBlue, // Selected chip color
              labelStyle: kChipLabelStyle.copyWith(
                color: isSelected ? kWhiteTextColor : kDarkTextColor, // Themed colors
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0), // More rounded
                side: BorderSide(
                  color: isSelected ? kPrimaryButtonBlue : kDividerColor, // Themed border
                  width: 1,
                ),
              ),
              elevation: isSelected ? 3 : 0, // Slight elevation for selected
              pressElevation: 5,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMyGroupsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjusted vertical padding
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _showMyGroups = !_showMyGroups; // Toggle the state
            _selectedCategory = 'All'; // Reset category filter when toggling "My Groups"
            _searchQuery = ''; // Clear search when toggling
          });
          debugPrint('Toggled "View My Created Groups" to: $_showMyGroups');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _showMyGroups ? kPrimaryButtonBlue : kWhiteTextColor, // Themed colors
          foregroundColor: _showMyGroups ? kWhiteTextColor : kPrimaryButtonBlue, // Themed colors
          minimumSize: const Size.fromHeight(55), // Make button full width, slightly taller
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14), // More rounded
            side: BorderSide(
              color: _showMyGroups ? Colors.transparent : kPrimaryButtonBlue, // Border for unselected state
              width: 1,
            ),
          ),
          elevation: _showMyGroups ? 5 : 2, // More elevation for selected
          shadowColor: _showMyGroups ? Colors.black.withOpacity(0.3) : Colors.transparent,
        ),
        child: Text(
          _showMyGroups ? 'Show All Groups' : 'View My Created Groups',
          style: kButtonTextStyle,
        ),
      ),
    );
  }

  Widget _buildGroupCard(Group group) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Added horizontal margin
      elevation: 4.0, // Increased elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)), // More rounded
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          debugPrint('Card tapped for group: ${group.name}, ID: ${group.id}');
          Navigator.pushNamed(
            context,
            '/groupdetail',
            arguments: {
              'groupId': group.id,
              'groupName': group.name,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Increased padding
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align image and text
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // More rounded image corners
                child: Image.asset(
                  group.imageUrl,
                  width: 80, // Larger image
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: kLightGrayBackground,
                      child: const Icon(Icons.group_work_outlined, color: kMediumGrayTextColor, size: 40), // Larger placeholder
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(group.name, style: kCardTitleTextStyle),
                    const SizedBox(height: 6), // Increased spacing
                    Text(group.memberCount, style: kCardSubtitleTextStyle),
                    const SizedBox(height: 12), // Spacing before buttons
                    Align(
                      alignment: Alignment.bottomRight, // Align buttons to the right
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Wrap content
                        children: [
                          if (group.isMyGroup && _showMyGroups)
                            TextButton(
                              onPressed: () {
                                debugPrint('View Requests button pressed for ${group.name}');
                                Navigator.pushNamed(context, '/requests', arguments: {'groupId': group.id});
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                backgroundColor: kAccentBlue.withOpacity(0.1), // Subtle accent background
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                foregroundColor: kAccentBlue, // Accent text color
                              ),
                              child: const Text('Requests', style: kViewButtonTextStyle),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                debugPrint('View button pressed for ${group.name}');
                                Navigator.pushNamed(
                                  context,
                                  '/groupdetail',
                                  arguments: {
                                    'groupId': group.id,
                                    'groupName': group.name,
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryButtonBlue, // Themed button
                                foregroundColor: kWhiteTextColor,
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10), // Larger padding
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), // More rounded
                                elevation: 3, // Slight elevation
                              ),
                              child: const Text('View', style: kViewButtonTextStyle),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        debugPrint('Create New Group FAB pressed');
        Navigator.pushNamed(context, '/creategroup'); // Ensure '/creategroup' route is defined
      },
      backgroundColor: kPrimaryButtonBlue, // Themed FAB color
      foregroundColor: kWhiteTextColor, // White icon
      child: const Icon(Icons.add_circle_outline_rounded, size: 30), // Larger, rounded icon
      tooltip: 'Create Group',
      elevation: 6, // More pronounced elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // More rounded FAB
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      // Apply the gradient here
      child: Container(
        height: 65, // Consistent height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildBottomNavItem(icon: Icons.home_filled, label: 'Home', index: 0, routeName: '/dashboard'),
            _buildBottomNavItem(icon: Icons.event_note_outlined, label: 'Events', index: 1, routeName: '/event1'), // Assuming event1 is the main events screen
            _buildBottomNavItem(icon: Icons.maps_ugc_outlined, label: 'Messages', index: 2, routeName: '/message1'),
            _buildBottomNavItem(icon: Icons.group_outlined, label: 'Groups', index: 3, routeName: '/group1'), // This screen itself, or a parent for bottom nav logic
            _buildBottomNavItem(icon: Icons.person_outline, label: 'Profile', index: 4, routeName: '/profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
    required String routeName,
  }) {
    bool isSelected = _currentBottomNavIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          // If the current route is already the target route, no navigation needed.
          // This prevents unnecessary rebuilds if the user taps the current tab.
          if (ModalRoute.of(context)?.settings.name == routeName) {
            debugPrint("Already on $routeName, not navigating again.");
          } else {
            // Navigate to the new route and remove all previous routes
            Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
          }

          // Always update the state if the index changes, even if on the same route.
          // This ensures the visual active state is correct if, for example, the route
          // was reached by a non-bottom-nav tap initially.
          if (_currentBottomNavIndex != index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          }
          debugPrint("Bottom nav tapped: $label (index $index), Target Route: $routeName, New Index: $_currentBottomNavIndex");
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Themed colors
              size: isSelected ? 28 : 24, // Larger active icon
            ),
            const SizedBox(height: 4), // Consistent spacing
            Text(
              label,
              style: kBottomNavLabelStyle.copyWith(
                color: isSelected ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Themed colors
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}