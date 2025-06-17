import 'package:flutter/material.dart';

// A simple model for a player request
class PlayerRequest {
  final String id;
  final String playerName;
  final String requestedDate;

  PlayerRequest({
    required this.id,
    required this.playerName,
    required this.requestedDate,
  });
}

class PlayerRequestWidget extends StatefulWidget {
  @override
  _PlayerRequestWidgetState createState() => _PlayerRequestWidgetState();
}

class _PlayerRequestWidgetState extends State<PlayerRequestWidget> {
  // Initial list of player requests
  List<PlayerRequest> _playerRequests = [
    PlayerRequest(id: '1', playerName: 'John Doe', requestedDate: 'October 5, 2023'),
    PlayerRequest(id: '2', playerName: 'Jane Smith', requestedDate: 'October 6, 2023'),
    PlayerRequest(id: '3', playerName: 'Alex Brown', requestedDate: 'October 7, 2023'),
    PlayerRequest(id: '4', playerName: 'Emily White', requestedDate: 'October 8, 2023'),
    PlayerRequest(id: '5', playerName: 'David Green', requestedDate: 'October 9, 2023'),
  ];

  // --- Theme Colors and Text Styles (consistent with previous theme) ---
  final Color _kPrimaryButtonColor = const Color(0xFF0033FF); // Top gradient color for primary actions
  final Color _kRejectButtonBorderColor = const Color.fromRGBO(50, 50, 100, 1); // Darkened for theme
  final Color _kCardBackgroundColor = Colors.white10; // Darkened card background
  final Color _kShadowColor = Colors.black.withOpacity(0.3); // Darker shadow for dark theme

  final TextStyle _kAppBarTitleTextStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _kEmptyListTextStyle = const TextStyle(
    color: Colors.white60, // Subdued white
    fontFamily: 'Inter',
    fontSize: 18,
  );

  final TextStyle _kCardPlayerNameTextStyle = const TextStyle(
    color: Colors.white, // White for prominence
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _kCardRequestedDateTextStyle = const TextStyle(
    color: Colors.white60, // Subdued white for less important info
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  final TextStyle _kButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Function to handle approval of a request
  void _handleApprove(String requestId) {
    setState(() {
      _playerRequests.removeWhere((request) => request.id == requestId);
    });
    // In a real application, you would also send this approval to a backend service
    print('Approved request ID: $requestId');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request for $requestId approved!'),
        backgroundColor: _kPrimaryButtonColor, // Themed snackbar
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Function to handle rejection of a request
  void _handleReject(String requestId) {
    setState(() {
      _playerRequests.removeWhere((request) => request.id == requestId);
    });
    // In a real application, you would also send this rejection to a backend service
    print('Rejected request ID: $requestId');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request for $requestId rejected!'),
        backgroundColor: const Color(0xFF00003D), // A darker theme color for rejection
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Apply gradient to the whole screen
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
            icon: const Icon(Icons.arrow_back, color: Colors.white), // White back icon
            onPressed: () {
              // Handle back button press
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Player Join Requests',
            style: _kAppBarTitleTextStyle,
          ),
          centerTitle: false,
        ),
        body: _playerRequests.isEmpty
            ? Center(
          child: Text(
            'No new player requests.',
            style: _kEmptyListTextStyle,
          ),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                ..._playerRequests.map((request) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Add spacing between cards
                    child: PlayerRequestCard(
                      playerName: request.playerName,
                      requestedDate: request.requestedDate,
                      onApprove: () => _handleApprove(request.id),
                      onReject: () => _handleReject(request.id),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 30, // Adjust height as needed
          color: Colors.transparent, // Make bottom navigation bar transparent
          child: Center(
            child: Container(
              width: 108,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white30, // A subtle white for the indicator
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerRequestCard extends StatelessWidget {
  final String playerName;
  final String requestedDate;
  final VoidCallback onApprove;
  final VoidCallback onReject;

   PlayerRequestCard({
    super.key,
    required this.playerName,
    required this.requestedDate,
    required this.onApprove,
    required this.onReject,
  });

  // --- Theme Colors and Text Styles (consistent with previous theme) ---
  final Color _kPrimaryButtonColor = const Color(0xFF0033FF); // Top gradient color for primary actions
  final Color _kRejectButtonBorderColor = const Color.fromRGBO(50, 50, 100, 1); // Darkened for theme
  final Color _kCardBackgroundColor = Colors.white10; // Darkened card background
  final Color _kShadowColor = Colors.black.withOpacity(0.3); // Darker shadow for dark theme

  final TextStyle _kCardPlayerNameTextStyle = const TextStyle(
    color: Colors.white, // White for prominence
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _kCardRequestedDateTextStyle = const TextStyle(
    color: Colors.white60, // Subdued white for less important info
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  final TextStyle _kButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBackgroundColor, // Themed card background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _kShadowColor, // Themed shadow color
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Player: $playerName',
            style: _kCardPlayerNameTextStyle,
          ),
          const SizedBox(height: 4),
          Text(
            'Requested on: $requestedDate',
            style: _kCardRequestedDateTextStyle,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                onPressed: onApprove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimaryButtonColor, // Themed approve button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Text(
                  'Approve',
                  style: _kButtonTextStyle,
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onReject,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _kRejectButtonBorderColor), // Themed reject button border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Text(
                  'Reject',
                  style: _kButtonTextStyle.copyWith(color: Colors.white), // Ensure reject text is white
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}