import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/router/nav_router.dart';
import 'package:flynetwork/src/interfaces/main_pages/Business%20Pages/business.dart';
import 'package:flynetwork/src/interfaces/main_pages/chat.dart';
import 'package:flynetwork/src/interfaces/main_pages/feed_page.dart';
import 'package:flynetwork/src/interfaces/main_pages/home_page.dart';
import 'package:flynetwork/src/interfaces/main_pages/lms_page.dart';

class IconResolver extends StatelessWidget {
  final String iconPath;
  final Color color;
  final double height;
  final double width;

  const IconResolver({
    Key? key,
    required this.iconPath,
    required this.color,
    this.height = 24,
    this.width = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconPath.startsWith('http') || iconPath.startsWith('https')) {
      return Image.network(
        iconPath,
        // color: color,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
      );
    } else {
      return SvgPicture.asset(
        iconPath,
        // color: color,
        height: height,
        width: width,
      );
    }
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late final webSocketClient;

  // @override
  // void initState() {
  //   super.initState();
  //   webSocketClient = ref.read(socketIoClientProvider);
  //   webSocketClient.connect(id, ref);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  static List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      // ref.read(currentNewsIndexProvider.notifier).state = 0;
      // _selectedIndex = index;
      ref.read(selectedIndexProvider.notifier).updateIndex(index);
    });
  }

  List<String> _inactiveIcons = [];
  List<String> _activeIcons = [];
  Future<void> _initialize() async {
    _widgetOptions = <Widget>[
      HomePage(),
      BusinessPage(),
      LmsPage(),
      FeedPage(),
      ChatDash(),
    ];
    _activeIcons = [
      'assets/svg/icons/home_active.svg',
      'assets/svg/icons/business_active.svg',
      'assets/svg/icons/lms_active.svg',
      'assets/svg/icons/feed_active.svg',
      'assets/svg/icons/chat_active.svg',
    ];
    _inactiveIcons = [
      'assets/svg/icons/home_inactive.svg',
      'assets/svg/icons/business_inactive.svg',
      'assets/svg/icons/lms_inactive.svg',
      'assets/svg/icons/feed_inactive.svg',
      'assets/svg/icons/chat_inactive.svg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedIndex = ref.watch(selectedIndexProvider);
      _initialize();
      // final asyncUser = ref.watch(userProvider);

      return PopScope(
          canPop: selectedIndex != 0 ? false : true,
          onPopInvokedWithResult: (didPop, result) {
            log('im inside mainpage popscope');
            if (selectedIndex != 0) {
              ref.read(selectedIndexProvider.notifier).updateIndex(0);
            }
          },
          child: Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: List.generate(5, (index) {
                return BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: IconResolver(
                    iconPath: _inactiveIcons[index],
                    color: selectedIndex == index ? kPrimaryColor : Colors.grey,
                  ),
                  activeIcon: IconResolver(
                      iconPath: _activeIcons[index], color: kPrimaryColor),
                  label: ['Home', 'Business', 'LMS', 'FEED', 'Chat'][index],
                );
              }),
              currentIndex: selectedIndex,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                HapticFeedback.selectionClick();
                _onItemTapped(index);
              },
              showUnselectedLabels: true,
            ),
          )
          // : Scaffold(
          //     body: Center(
          //       child: Container(
          //         padding: EdgeInsets.all(20.0),
          //         margin: EdgeInsets.symmetric(horizontal: 20.0),
          //         decoration: BoxDecoration(
          //           color: Colors.red[50],
          //           borderRadius: BorderRadius.circular(15.0),
          //           border: Border.all(
          //             color: kRed,
          //             width: 1.5,
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.3),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: Offset(0, 3),
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Icon(
          //               Icons.warning_amber_rounded,
          //               color: Colors.redAccent,
          //               size: 48,
          //             ),
          //             SizedBox(height: 10),
          //             Text(
          //               "Your account is Suspended/Inactive",
          //               style: TextStyle(
          //                 color: Colors.redAccent,
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //             SizedBox(height: 8),
          //             Text(
          //               "Please contact Admin to know more",
          //               style: TextStyle(
          //                 color: Colors.black54,
          //                 fontSize: 16,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //             SizedBox(height: 20),
          //             // customButton(
          //             //     labelColor: Colors.redAccent,
          //             //     sideColor:
          //             //         const Color.fromARGB(255, 239, 236, 236),
          //             //     buttonColor:
          //             //         const Color.fromARGB(255, 239, 236, 236),
          //             //     label: 'Logout',
          //             //     onPressed: () async {
          //             //       final SharedPreferences preferences =
          //             //           await SharedPreferences.getInstance();
          //             //       preferences.remove('token');
          //             //       preferences.remove('id');
          //             //       Navigator.pushReplacement(
          //             //           context,
          //             //           MaterialPageRoute(
          //             //             builder: (context) =>
          //             //                 PhoneNumberScreen(),
          //             //           ));
          //             //     })
          //           ],
          //         ),
          //       ),
          //     ),
          //   )
          );
    });
  }
}
