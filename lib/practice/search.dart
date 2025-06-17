import 'package:flutter/material.dart';

// --- Theme Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

const Color kWhiteTextColor = Colors.white;
const Color kLighterBlueText = Color(0xFFA0B5E8); // For subtitles, hints
const Color kIconColorWhite = Colors.white;
const Color kIconColorBlue = Color(0xFF6C9DFF);   // Brighter blue for selected/active icons

const Color kSurfaceDarkBlue = Color(0xCC000A3D); // Semi-transparent dark blue for surfaces
const Color kCardBackgroundColorDark = Color(0xDD000830); // Slightly more opaque for cards
const Color kInputFillDark = Color(0x660A1A5E);       // Darker, semi-transparent for input fields
const Color kPrimaryButtonBlue = kGradientMediumBlue;   // Main button color
// --- End Theme Color Constants ---


// --- Reusable Text Styles (Updated for Dark Theme) ---
final TextStyle _kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Inter',
);
final TextStyle _kSectionLabelTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontSize: 18,
  fontWeight: FontWeight.w600,
  fontFamily: 'Inter',
);
final TextStyle _kHintTextStyle = TextStyle(
  color: kLighterBlueText,
  fontSize: 16,
  fontFamily: 'Inter',
);

// ADDED _kBodyTextStyle
final TextStyle _kBodyTextStyle = TextStyle(
  color: kWhiteTextColor, // Default to white for dark theme
  fontSize: 16,
  fontFamily: 'Inter',
  fontWeight: FontWeight.normal,
);

final TextStyle _kBottomNavLabelStyle = TextStyle(
  fontSize: 10,
  fontFamily: 'Inter',
);

final TextStyle _kResultItemTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kWhiteTextColor,
  fontFamily: 'Inter',
);
final TextStyle _kResultItemSubtitleStyle = TextStyle(
  fontSize: 14,
  color: kLighterBlueText,
  fontFamily: 'Inter',
);

final TextStyle _kButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: kWhiteTextColor,
    fontFamily: 'Inter');
// --- End Reusable Text Styles ---


// --- Data Models ---
enum SearchResultType { group, person }

class SearchResultItem {
  final String id;
  final String name;
  final String? sportType;
  final String? location;
  final String? skillLevel;
  final SearchResultType type;
  final String? avatarUrl;
  final String? details;

  SearchResultItem({
    required this.id,
    required this.name,
    this.sportType,
    this.location,
    this.skillLevel,
    required this.type,
    this.avatarUrl,
    this.details,
  });
}

class Search2Widget extends StatefulWidget {
  const Search2Widget({super.key});

  @override
  _Search2WidgetState createState() => _Search2WidgetState();
}

class _Search2WidgetState extends State<Search2Widget> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedSportType;
  String? _selectedLocation;
  String? _selectedSkillLevel;

  int _currentBottomNavIndex = 2; // Assuming Search is the 3rd item (index 2)

  final List<String> _sportTypes = ['Soccer', 'Basketball', 'Tennis', 'Running', 'Pétanque', 'Any'];
  final List<String> _locations = ['New York', 'London', 'Paris', 'Tokyo', 'Any'];
  final List<String> _skillLevels = ['Beginner', 'Intermediate', 'Advanced', 'Professional', 'Any'];

  final List<SearchResultItem> _allSearchableItems = [
    SearchResultItem(
        id: 'g1', name: 'NYC Soccer Ballers', sportType: 'Soccer', location: 'New York', skillLevel: 'Intermediate', type: SearchResultType.group, details: "Weekend soccer games in Central Park.", avatarUrl: "https://placehold.co/150/0033FF/FFFFFF?text=SG&fontsize=40"),
    SearchResultItem(
        id: 'p1', name: 'Alice Smith', sportType: 'Tennis', location: 'London', skillLevel: 'Beginner', type: SearchResultType.person, details: "Looking for tennis partners.", avatarUrl: "https://placehold.co/150/0600AB/FFFFFF?text=AS&fontsize=40"),
    SearchResultItem(
        id: 'g2', name: 'London Runners Club', sportType: 'Running', location: 'London', skillLevel: 'Any', type: SearchResultType.group, details: "Morning runs and marathon training.", avatarUrl: "https://placehold.co/150/00003D/FFFFFF?text=LR&fontsize=40"),
    SearchResultItem(
        id: 'p2', name: 'Bob Johnson', sportType: 'Basketball', location: 'New York', skillLevel: 'Advanced', type: SearchResultType.person, details: "Competitive basketball player.", avatarUrl: "https://placehold.co/150/6C9DFF/000000?text=BJ&fontsize=40"),
  ];

  List<SearchResultItem> _searchResults = [];

  @override
  void initState() {
    super.initState();
    // Attempt to set the bottom nav index based on current route if this page can be deep-linked
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final currentRouteName = ModalRoute.of(context)?.settings.name;
    //   if (currentRouteName == '/search') { // Assuming your route for this page is '/search'
    //     setState(() {
    //       _currentBottomNavIndex = 2; // Your search tab index
    //     });
    //   }
    // });
    _performSearch(isInitialLoad: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? currentValue,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _kSectionLabelTextStyle.copyWith(fontSize: 17)), // Using themed section label
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: kInputFillDark,
            hintText: hint,
            hintStyle: _kHintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kIconColorBlue, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          value: currentValue,
          icon: const Icon(Icons.arrow_drop_down, color: kLighterBlueText),
          isExpanded: true,
          // Corrected Line 181 (approx.) usage:
          style: _kBodyTextStyle.copyWith(color: kWhiteTextColor), // Ensure _kBodyTextStyle is defined
          dropdownColor: kSurfaceDarkBlue,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value), // Text style for items in dropdown is inherited from 'style' above
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _performSearch({bool isInitialLoad = false}) {
    final String query = _searchController.text.toLowerCase().trim();
    bool sportFilterActive = _selectedSportType != null;
    bool locationFilterActive = _selectedLocation != null;
    bool skillFilterActive = _selectedSkillLevel != null;
    bool anyFilterActive = sportFilterActive || locationFilterActive || skillFilterActive;

    if (!isInitialLoad && query.isEmpty && !anyFilterActive) {
      setState(() => _searchResults = List.from(_allSearchableItems));
      return;
    }

    _searchResults = _allSearchableItems.where((item) {
      bool matchesQuery = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          (item.details?.toLowerCase().contains(query) ?? false) ||
          (item.sportType?.toLowerCase().contains(query) ?? false) ||
          (item.location?.toLowerCase().contains(query) ?? false);
      bool matchesSport = _selectedSportType == null || item.sportType == _selectedSportType || item.sportType == 'Any';
      bool matchesLocation = _selectedLocation == null || item.location == _selectedLocation || item.location == 'Any';
      bool matchesSkill = _selectedSkillLevel == null || item.skillLevel == _selectedSkillLevel || item.skillLevel == 'Any';
      return matchesQuery && matchesSport && matchesLocation && matchesSkill;
    }).toList();
    setState(() {});
  }

  Widget _buildSearchResultsList() {
    bool filtersOrQueryActive = _searchController.text.isNotEmpty ||
        _selectedSportType != null ||
        _selectedLocation != null ||
        _selectedSkillLevel != null;

    if (_searchResults.isEmpty) {
      if (filtersOrQueryActive) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Text(
              'No results found matching your criteria.\nTry adjusting your search or filters.',
              style: _kHintTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (_allSearchableItems.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Text(
              'No items available to search at the moment.',
              style: _kHintTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        return Card(
          color: kCardBackgroundColorDark,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: kInputFillDark,
              backgroundImage: item.avatarUrl != null && item.avatarUrl!.startsWith('http')
                  ? NetworkImage(item.avatarUrl!)
                  : null,
              child: item.avatarUrl == null || !item.avatarUrl!.startsWith('http')
                  ? Icon(
                item.type == SearchResultType.group ? Icons.group_work_outlined : Icons.person_search_outlined,
                color: kIconColorWhite,
                size: 28,
              )
                  : null,
            ),
            title: Text(item.name, style: _kResultItemTitleStyle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.details != null && item.details!.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    item.details!,
                    style: _kResultItemSubtitleStyle.copyWith(fontSize: 13.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 5),
                Text(
                  '${item.sportType ?? "Any Sport"} • ${item.location ?? "Any Location"} • ${item.skillLevel ?? "Any Skill"}',
                  style: _kResultItemSubtitleStyle.copyWith(
                      fontSize: 12.5, color: kLighterBlueText.withOpacity(0.85)),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: kLighterBlueText),
            onTap: () {
              print('Tapped on: ${item.name} (Type: ${item.type}, ID: ${item.id})');
              if (item.type == SearchResultType.person) {
                Navigator.pushNamed(context, '/athlete', arguments: item);
              } else if (item.type == SearchResultType.group) {
                Navigator.pushNamed(context, '/group2', arguments: item);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kIconColorWhite),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
        ),
        title: Text('Search Sports', style: _kAppBarTitleTextStyle),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 12.0, // Adjusted top padding
              left: 16.0,
              right: 16.0,
              bottom: 16.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _searchController,
                // Corrected Line 369 (approx.) usage:
                style: _kBodyTextStyle.copyWith(fontSize: 16.5), // Using defined _kBodyTextStyle
                cursorColor: kIconColorBlue,
                decoration: InputDecoration(
                  hintText: 'Find groups, people, sports...',
                  hintStyle: _kHintTextStyle,
                  prefixIcon: const Icon(Icons.search, color: kIconColorWhite, size: 22),
                  filled: true,
                  fillColor: kInputFillDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: const BorderSide(color: kIconColorBlue, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: (_) => _performSearch(),
                onChanged: (text) { // Optional: Perform search as user types
                  // You might want to debounce this if you enable it
                  // _performSearch();
                },
              ),
              const SizedBox(height: 24),
              _buildDropdownField(
                label: 'Sport Type',
                hint: 'Any Sport',
                currentValue: _selectedSportType,
                items: _sportTypes,
                onChanged: (String? newValue) {
                  setState(() => _selectedSportType = (newValue == 'Any' || newValue == null) ? null : newValue);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                label: 'Location',
                hint: 'Any Location',
                currentValue: _selectedLocation,
                items: _locations,
                onChanged: (String? newValue) {
                  setState(() => _selectedLocation = (newValue == 'Any' || newValue == null) ? null : newValue);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                label: 'Skill Level',
                hint: 'Any Skill Level',
                currentValue: _selectedSkillLevel,
                items: _skillLevels,
                onChanged: (String? newValue) {
                  setState(() => _selectedSkillLevel = (newValue == 'Any' || newValue == null) ? null : newValue);
                },
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                icon: const Icon(Icons.search_rounded, color: kIconColorWhite, size: 22),
                label: Text('FIND MATCHES', style: _kButtonTextStyle.copyWith(fontSize: 17)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryButtonBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  minimumSize: const Size(double.infinity, 52),
                  elevation: 3,
                ),
                onPressed: () => _performSearch(isInitialLoad: false),
              ),
              const SizedBox(height: 28),
              if (_searchResults.isNotEmpty || _searchController.text.isNotEmpty || _selectedSportType != null || _selectedLocation != null || _selectedSkillLevel != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                      _searchResults.isNotEmpty ? 'Results (${_searchResults.length})' : 'Results',
                      style: _kSectionLabelTextStyle.copyWith(fontSize: 19)
                  ),
                ),
              _buildSearchResultsList(),
              const SizedBox(height: 20), // For scroll padding at the bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          // If already on the search tab (assuming index 2 is search) and tapping it again, do nothing or refresh.
          if (_currentBottomNavIndex == index && index == 2) {
            // Optionally, you could re-run search or scroll to top
            _performSearch(isInitialLoad: false); // Example: re-run search
            return;
          }
          // If tapping a different tab, or re-tapping a non-search tab (if that had special behavior)
          if (_currentBottomNavIndex == index) return;


          setState(() {
            _currentBottomNavIndex = index;
            switch (index) {
              case 0: Navigator.pushReplacementNamed(context, '/dashboard'); break;
              case 1: Navigator.pushReplacementNamed(context, '/event1'); break;
              case 2:
              // This is the search screen. If user taps search icon while here,
              // we might not navigate, or we might refresh the search.
              // If this screen itself is '/search', then no Navigator call is needed
              // unless you want to specifically reload it with Navigator.pushReplacementNamed(context, '/search');
                print("Search tab tapped - already on search screen or should navigate to main search route.");
                final currentRouteName = ModalRoute.of(context)?.settings.name;
                if (currentRouteName != '/search') { // Replace '/search' with your actual route name for this page
                  Navigator.pushReplacementNamed(context, '/search'); // Or your main search page route
                }

                break;
              case 3: Navigator.pushReplacementNamed(context, '/group1'); break;
              case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: kSurfaceDarkBlue,
        selectedItemColor: kIconColorBlue,
        unselectedItemColor: kLighterBlueText.withOpacity(0.8),
        selectedLabelStyle: _kBottomNavLabelStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 11.5, color: kIconColorBlue),
        unselectedLabelStyle: _kBottomNavLabelStyle.copyWith(fontSize: 11, color: kLighterBlueText.withOpacity(0.8)),
        showUnselectedLabels: true,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'), // Changed icon to search
          BottomNavigationBarItem(icon: Icon(Icons.groups_2_outlined), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
      ),
    );
  }
}