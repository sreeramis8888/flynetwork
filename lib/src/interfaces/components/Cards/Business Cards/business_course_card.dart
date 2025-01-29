import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:shimmer/shimmer.dart';

class BusinessCourseCard extends StatefulWidget {
  const BusinessCourseCard({super.key});

  @override
  _BusinessCourseCardState createState() => _BusinessCourseCardState();
}

class _BusinessCourseCardState extends State<BusinessCourseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Define the sliding animation from the left using Tween
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.2, 0.0), // Start off-screen to the left
      end: Offset.zero, // End at the original position
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Define opacity animation for fade-in effect
    _opacityAnimation = Tween<double>(
      begin: 0.0, // Start completely transparent
      end: 1.0, // End fully visible
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Start the animation when the widget is inserted into the tree
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(color: kGreyLight),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('John Kappa', style: kSmallerTitleB),
                subtitle: Text(
                  'Company name',
                  style: kSmallerTitleR.copyWith(color: kGreyDark),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                height: 200,
                child: Image.network(
                  '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text(
                            'Image not available',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Quis enim nisl ullamcorper tristique integer orci nunc in eget. Amet hac bibendum dignissim eget pretium turpis in non cum.',
                      style: kSmallTitleR,
                    ),
                    SizedBox(height: 8),
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
}
