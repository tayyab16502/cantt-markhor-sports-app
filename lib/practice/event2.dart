import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For date formatting // REMOVED

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
const Color kErrorColor = Color(0xFFFF5252); // Standard Material error color

// --- Reusable Text Styles (Adjusted for the new theme) ---
const TextStyle kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor, // AppBar title is white on gradient
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const TextStyle kScreenTitleTextStyle = TextStyle(
  color: kDarkTextColor, // Titles on white background
  fontFamily: 'Inter',
  fontSize: 28, // Slightly larger for screen title
  fontWeight: FontWeight.bold, // Often bold for screen titles
);

const TextStyle kInputTextStyle = TextStyle(
  color: kDarkTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
);

const TextStyle kInputHintTextStyle = TextStyle(
  color: kMediumGrayTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
);

const TextStyle kSectionHeaderTextStyle = TextStyle(
  color: kDarkTextColor,
  fontFamily: 'Inter',
  fontSize: 18, // Slightly larger section header
  fontWeight: FontWeight.w600,
);

const TextStyle kDateTimeFieldLabelStyle = TextStyle(
  color: kMediumGrayTextColor,
  fontFamily: 'Inter',
  fontSize: 14,
);

const TextStyle kDateTimeFieldValueStyle = TextStyle(
  color: kDarkTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w500, // Make value slightly bolder
);

const TextStyle kToggleOptionTextStyle = TextStyle(
  color: kDarkTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: kWhiteTextColor, // Text on primary blue buttons
  fontFamily: 'Inter',
  fontSize: 18, // Slightly larger for main action button
  fontWeight: FontWeight.bold,
);


class EventCreationScreen extends StatefulWidget {
  const EventCreationScreen({super.key}); // Added Key for best practice

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  // State variables
  final TextEditingController _matchTitleController = TextEditingController();
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;
  bool _showOnPublicCalendar = false;
  bool _allowGuestsToBringFriends = false;

  @override
  void dispose() {
    _matchTitleController.dispose();
    super.dispose();
  }

  // --- Helper methods to build UI sections ---

  // Helper function to format DateTime (basic)
  String _formatDateTimeBasic(DateTime? date, TimeOfDay? time, BuildContext context) {
    if (date == null || time == null) {
      return 'Select Date & Time';
    }
    // Basic formatting without intl package
    final String dateStr = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final String timeStr = time.format(context); // TimeOfDay.format() is part of Flutter
    return '$dateStr at $timeStr';
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // Apply the gradient here
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
      leading: IconButton(
        icon: const Icon(Icons.close, color: kWhiteTextColor), // White close icon
        onPressed: () {
          Navigator.pop(context); // Handle close action
          debugPrint('Close button pressed');
        },
      ),
      title: const Text('Create Invitation', style: kAppBarTitleTextStyle), // Title for clarity
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: kWhiteTextColor), // White help icon
          onPressed: () {
            debugPrint('Help button pressed');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Help functionality (TODO)', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kAccentBlue,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: kWhiteTextColor), // White settings icon
          onPressed: () {
            debugPrint('Settings button pressed');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Settings functionality (TODO)', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kAccentBlue,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(width: 8), // Adjust spacing
      ],
    );
  }

  Widget _buildScreenTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Text(
        'Match Invite',
        style: kScreenTitleTextStyle,
      ),
    );
  }

  Widget _buildMatchTitleInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _matchTitleController,
        onChanged: (value) {
          setState(() {
            // No direct state update needed here as controller holds value
          });
        },
        decoration: InputDecoration(
          hintText: 'Match Title',
          hintStyle: kInputHintTextStyle,
          filled: true,
          fillColor: kLightGrayBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kAccentBlue, width: 2), // Accent border on focus
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Adjusted padding
        ),
        style: kInputTextStyle,
        cursorColor: kAccentBlue, // Themed cursor color
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0), // More top padding
      child: Text(
        title,
        style: kSectionHeaderTextStyle,
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildDateTimeField(
              label: 'Start Date & Time',
              value: _formatDateTimeBasic(_startDate, _startTime, context), // UPDATED
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: kPrimaryButtonBlue, // Header background color
                          onPrimary: kWhiteTextColor, // Header text color
                          onSurface: kDarkTextColor, // Body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: kPrimaryButtonBlue, // Button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _startTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kPrimaryButtonBlue, // Header background color
                            onPrimary: kWhiteTextColor, // Header text color
                            onSurface: kDarkTextColor, // Body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: kPrimaryButtonBlue, // Button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedTime != null) {
                    setState(() {
                      _startDate = pickedDate;
                      _startTime = pickedTime;
                    });
                  }
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDateTimeField(
              label: 'End Date & Time',
              value: _formatDateTimeBasic(_endDate, _endTime, context), // UPDATED
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? _startDate ?? DateTime.now(),
                  firstDate: _startDate ?? DateTime.now(), // End date cannot be before start date
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: kPrimaryButtonBlue,
                          onPrimary: kWhiteTextColor,
                          onSurface: kDarkTextColor,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: kPrimaryButtonBlue,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _endTime ?? _startTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kPrimaryButtonBlue,
                            onPrimary: kWhiteTextColor,
                            onSurface: kDarkTextColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: kPrimaryButtonBlue,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedTime != null) {
                    setState(() {
                      _endDate = pickedDate;
                      _endTime = pickedTime;
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeField(
      {required String label, required String value, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Consistent padding
        decoration: BoxDecoration(
          color: kLightGrayBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kDividerColor, width: 1), // Subtle border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: kDateTimeFieldLabelStyle,
            ),
            const SizedBox(height: 6), // Increased spacing
            Text(
              value,
              style: kDateTimeFieldValueStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildToggleOption(
          title: 'Show on public calendar',
          value: _showOnPublicCalendar,
          onChanged: (bool newValue) {
            setState(() {
              _showOnPublicCalendar = newValue;
            });
          },
        ),
        _buildToggleOption(
          title: 'Allow guests to bring friends',
          value: _allowGuestsToBringFriends,
          onChanged: (bool newValue) {
            setState(() {
              _allowGuestsToBringFriends = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildToggleOption({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: kToggleOptionTextStyle,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: kAccentBlue, // Themed active color
            inactiveThumbColor: kMediumGrayTextColor,
            inactiveTrackColor: kLightGrayBackground,
          ),
        ],
      ),
    );
  }

  Widget _buildSendInviteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryButtonBlue, // Themed button color
            padding: const EdgeInsets.symmetric(vertical: 18), // Increased padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14), // More rounded corners
            ),
            elevation: 5, // More elevation
            shadowColor: Colors.black.withOpacity(0.4),
          ),
          onPressed: () {
            // Basic validation
            if (_matchTitleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a Match Title', style: TextStyle(color: kWhiteTextColor)),
                  backgroundColor: kErrorColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }
            if (_startDate == null || _startTime == null || _endDate == null || _endTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select both Start and End Dates & Times', style: TextStyle(color: kWhiteTextColor)),
                  backgroundColor: kErrorColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            // Combine date and time
            final DateTime finalStartDate = DateTime(
              _startDate!.year,
              _startDate!.month,
              _startDate!.day,
              _startTime!.hour,
              _startTime!.minute,
            );
            final DateTime finalEndDate = DateTime(
              _endDate!.year,
              _endDate!.month,
              _endDate!.day,
              _endTime!.hour,
              _endTime!.minute,
            );

            if (finalEndDate.isBefore(finalStartDate)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('End Date & Time cannot be before Start Date & Time', style: TextStyle(color: kWhiteTextColor)),
                  backgroundColor: kErrorColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }


            Navigator.pushNamed(context, '/event1'); // Navigate after successful "send"
            debugPrint('Send Invite Tapped');
            debugPrint('Match Title: ${_matchTitleController.text}');
            debugPrint('Start DateTime: $finalStartDate');
            debugPrint('End DateTime: $finalEndDate');
            debugPrint('Show on Public Calendar: $_showOnPublicCalendar');
            debugPrint('Allow Guests to Bring Friends: $_allowGuestsToBringFriends');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Invitation Sent Successfully!', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kPrimaryButtonBlue, // Success feedback
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(15),
              ),
            );
          },
          child: const Text('Send Invite', style: kButtonTextStyle),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteTextColor, // Use white for the main background
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildScreenTitle(),
            const SizedBox(height: 15), // Spacing below title
            _buildMatchTitleInput(),
            const Divider(height: 30, thickness: 1.0, indent: 20, endIndent: 20, color: kDividerColor), // Themed divider

            _buildSectionHeader('Select Date & Time'),
            _buildDateTimeSelection(),
            const Divider(height: 30, thickness: 1.0, indent: 20, endIndent: 20, color: kDividerColor),

            _buildSectionHeader('Invite Options'),
            _buildInviteOptions(),
            const SizedBox(height: 20), // Spacing before button

            _buildSendInviteButton(),

            // Removed the bottom drag handle as it implies a modal bottom sheet,
            // which this screen is not explicitly defined as.
            // If it's a modal, this would be part of the modal's internal structure.
          ],
        ),
      ),
    );
  }
}