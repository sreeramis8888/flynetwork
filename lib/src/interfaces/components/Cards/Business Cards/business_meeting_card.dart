import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:intl/intl.dart';

class BusinessMeetingCard extends StatefulWidget {
  const BusinessMeetingCard({super.key});

  @override
  _BusinessMeetingCardState createState() => _BusinessMeetingCardState();
}

class _BusinessMeetingCardState extends State<BusinessMeetingCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Slide animation controller (top to bottom)
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -.2), // Start from the top
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Start with invisible
      end: 1.0, // End with fully visible
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start both animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hardcoded data
    final String username = 'John Doe';
    final String companyName = 'Tech Innovations';
    final String content = 'Excited to announce our new product launch!';
    final String mainText = 'Product Launch Announcement';
    final String meetingLink = 'https://www.meetinglink.com';
    final DateTime postDate = DateTime.now();
    final String? userAvatar = 'https://www.example.com/avatar.jpg';

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(color: kGreyLight),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Avatar and User Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          userAvatar != null ? NetworkImage(userAvatar) : null,
                      child:
                          userAvatar == null ? const Icon(Icons.person) : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username, style: kSmallerTitleB),
                          Text(
                            companyName,
                            style: kSmallerTitleR.copyWith(color: kGreyDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Main Content
                const SizedBox(height: 16),
                Text(mainText, style: kSmallTitleB),
                const SizedBox(height: 8),
                Text(content, style: kSmallTitleR),

                // Meeting Link
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Meeting Link: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        meetingLink,
                        style: TextStyle(
                          color: Colors.blue[700],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                // Date and Time
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '02 JAN 2023',
                      style: kSmallerTitleR.copyWith(
                          fontSize: 10, color: kGreyDark),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 14,
                      color: const Color.fromARGB(255, 210, 205, 205),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '09:00 PM',
                      style: kSmallerTitleR.copyWith(
                          fontSize: 10, color: kGreyDark),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
