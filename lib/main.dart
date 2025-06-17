import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tayyabkhan/practice/apptutorial.dart';
import 'package:tayyabkhan/practice/athletes.dart';
import 'package:tayyabkhan/practice/contact.dart';
import 'package:tayyabkhan/practice/creategroup.dart';
import 'package:tayyabkhan/practice/createpost.dart';
import 'package:tayyabkhan/practice/dashboard.dart';
import 'package:tayyabkhan/practice/editprofile.dart';
import 'package:tayyabkhan/practice/event1.dart';
import 'package:tayyabkhan/practice/event2.dart';
import 'package:tayyabkhan/practice/event3.dart';
import 'package:tayyabkhan/practice/getstarted.dart';
import 'package:tayyabkhan/practice/group1.dart';
import 'package:tayyabkhan/practice/group2.dart';
import 'package:tayyabkhan/practice/groupdetail.dart';
import 'package:tayyabkhan/practice/login.dart';
import 'package:tayyabkhan/practice/menubar.dart';
import 'package:tayyabkhan/practice/message1.dart';
import 'package:tayyabkhan/practice/message2.dart';
import 'package:tayyabkhan/practice/message3.dart';
import 'package:tayyabkhan/practice/profile.dart';
import 'package:tayyabkhan/practice/profilesetup.dart';
import 'package:tayyabkhan/practice/requests.dart';
import 'package:tayyabkhan/practice/resetpassword.dart';
import 'package:tayyabkhan/practice/search.dart';
import 'package:tayyabkhan/practice/signup.dart';
import 'package:tayyabkhan/practice/splashscreen.dart';
// Import your SplashScreen

Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: '/', // This correctly sets the SplashScreen as the first screen
    routes: {
      '/': (context) => const SplashScreen(), // Your SplashScreen
      '/getstarted': (context) => const GetStartedScreen(), // Corrected route name to include '/'
      '/login': (context) => LoginScreen(),
      '/resetpassword': (context) => ResetPasswordScreen(),
      '/signup': (context) => SignupWidget(),
      '/profilesetup': (context) => ProfileSetupScreen(),
      '/tutorial': (context) => TutorialScreen(),
      '/dashboard': (context) => DashboardScreen(),
      '/profile': (context) => Profile(),
      // '/editprofile': (context) => EditProfileWidget(), // Uncomment if used
      '/createpost': (context) => CreatePostScreen(),
      '/event1': (context) => Event1Screen(),
      '/event2': (context) => EventCreationScreen(),
      '/event3': (context) => EventDetailsScreen(),
      '/message1': (context) => MessengerDashboardScreen(),
      '/message3': (context) => GroupChatScreen(groupId: 'group1', currentUserId: 'user1'),
      '/group1': (context) => GroupScreen(),
      '/group2': (context) => const Group2(), // Your Group2 screen (formerly GroupDetail)
      '/creategroup': (context) => CreateGroupScreen(),
      '/search': (context) => Search2Widget(), // Assuming Search2Widget is in search.dart
      '/menubar': (context) => NotificationWidget(),
      '/contact': (context) => ContactUsScreen(),
      '/athlete': (context) => AthleteProfileScreen(),
      '/requests': (context) => PlayerRequestWidget(),
      '/groupdetail': (context) => GroupDetail(), // If this is a distinct GroupDetail screen, keep it.

      '/message2': (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        final String playerName = args is String ? args : 'Unknown Player';
        return PlayerMessage(playerName: playerName);
      },
      // If '/group_detail' was used in GroupScreen, add it here too:
      // '/group_detail': (context) {
      //   final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      //   final String groupId = args?['groupId'] as String? ?? 'defaultGroupId';
      //   final String groupName = args?['groupName'] as String? ?? 'Default Group';
      //   // Ensure GroupDetailScreen (from group2.dart) is used here if that's the intended detail screen
      //   return GroupDetailScreen(groupId: groupId, groupName: groupName);
      // },
    },
  ));
}