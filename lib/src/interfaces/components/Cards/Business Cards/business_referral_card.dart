import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';

class BusinessReferralCard extends StatefulWidget {
  const BusinessReferralCard({Key? key}) : super(key: key);

  @override
  _BusinessReferralCardState createState() => _BusinessReferralCardState();
}

class _BusinessReferralCardState extends State<BusinessReferralCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Slide animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(.3, 0.0), // Start from the right
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
    const userName = "John Kappa";
    const companyName = "Company name";
    const title = "Lorem ipsum dolor sit amet consectetur.";
    const description =
        "Lorem ipsum dolor sit amet consectetur. Quis enim nisl ullamcorper tristique integer orci nunc in eget. Amet hac bibendum dignissim eget pretium turpis in non cum.";
    const referralText = "Referral:";
    const date = "02 Jan 2023";
    const time = "09:00 PM";

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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // Replace with actual image URL
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: kSmallerTitleB),
                        Text(
                          companyName,
                          style: kSmallerTitleR.copyWith(color: kGreyDark),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(title, style: kSmallTitleB),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      referralText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150'), // Replace with actual image URL
                          radius: 12,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
