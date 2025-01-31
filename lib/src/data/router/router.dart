import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/models/user_model.dart';
import 'package:flynetwork/src/interfaces/activity/activity_page.dart';
import 'package:flynetwork/src/interfaces/main_page.dart';
import 'package:flynetwork/src/interfaces/main_pages/login_pages.dart';
import 'package:flynetwork/src/interfaces/main_pages/profilePage.dart';
import 'package:flynetwork/src/interfaces/profile/profile_preview.dart';
import 'package:flynetwork/src/interfaces/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings?.name) {
    case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case 'PhoneNumber':
      return MaterialPageRoute(builder: (context) => PhoneNumberScreen());
    // case 'MainPage':
    //   return MaterialPageRoute(builder: (context) => const MainPage());
    case 'ProfileCompletion':
      return MaterialPageRoute(
          builder: (context) => const ProfileCompletionScreen());
    case 'MainPage':
      return MaterialPageRoute(builder: (context) => const MainPage());
    case 'ProfilePage':
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case 'ActivityPage':
      return MaterialPageRoute(builder: (context) =>  ActivityPage());
 case 'ProfilePreview':
      UserModel user = settings?.arguments as UserModel;
      return MaterialPageRoute(
          builder: (context) => ProfilePreview(
                user: user,
              ));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings?.name}'),
          ),
        ),
      );
  }
}
