import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/models/user_model.dart';
import 'package:flynetwork/src/data/services/navigation_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

Widget customDrawer() {
  NavigationService navigationService = NavigationService();
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/pngs/fly_newtork_logo.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(color: Color(0xFFF7F7FC)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(''),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SREERAM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '9645398555',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        navigationService.pushNamed('EditUser');
                      },
                      icon: SvgPicture.asset('assets/svg/icons/edit_icon.svg')),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Drawer Items

          _buildDrawerItem(
            icon: 'assets/svg/icons/activity.svg',
            label: 'My Activities',
            onTap: () {
              navigationService.pushNamed('ActivityPage');
            },
          ),

          _buildDrawerItem(
            icon: 'assets/svg/icons/my_products.svg',
            label: 'My Products',
            onTap: () {
              navigationService.pushNamed('MyProducts');
            },
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/my_requests.svg',
            label: 'My Requests',
            onTap: () {
              navigationService.pushNamed('MyBusinesses');
            },
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/my_reviews.svg',
            label: 'My Reveiws',
            onTap: () {
              navigationService.pushNamed('RequestNFC');
            },
          ),

          _buildDrawerItem(
            icon: 'assets/svg/icons/my_events.svg',
            label: 'My Events',
            onTap: () {
              navigationService.pushNamed('MyReviews');
            },
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/my_subscription.svg',
            label: 'My Subscription',
            onTap: () {
              navigationService.pushNamed('MySubscriptionPage');
            },
          ),

          SizedBox(
            height: 40,
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/about_us.svg',
            label: 'About Us',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/terms.svg',
            label: 'Terms & Conditions',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/privacy.svg',
            label: 'Privacy Policy',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/logout.svg',
            label: 'Logout',
            onTap: () async {
              final SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove('token');
              preferences.remove('id');
              navigationService.pushNamedAndRemoveUntil('PhoneNumber');
            },
          ),
          _buildDrawerItem(
            icon: 'assets/svg/icons/trash.svg',
            label: 'Delete Account',
            textColor: kRed,
            onTap: () {},
          ),
          // Footer
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Powered by',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Image.asset(
                    'assets/pngs/xyvin.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem({
  required String icon,
  required String label,
  VoidCallback? onTap,
  Color textColor = Colors.black,
}) {
  return ListTile(
    leading: SvgPicture.asset(
      icon,
      height: 24,
    ),
    title: Text(
      label,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
    onTap: onTap,
  );
}
