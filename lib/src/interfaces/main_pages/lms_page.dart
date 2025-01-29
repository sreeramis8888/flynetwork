import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:flynetwork/src/data/router/nav_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shimmer/shimmer.dart';

class LmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          centerTitle: true,
          leading: Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: kGrey)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: const Icon(Icons.arrow_back),
                    )),
                onPressed: () {
                  ref.read(selectedIndexProvider.notifier).updateIndex(0);
                },
              );
            },
          ),
          title: const Text(
            "LMS",
            style: kBodyTitleR,
          ),
          bottom: const TabBar(
            indicatorColor: kPrimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: kPrimaryColor,
            tabs: [
              Tab(text: "Courses"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 2,
              itemBuilder: (context, index) {
                return CourseCard();
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 2,
              itemBuilder: (context, index) {
                return HistoryCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeInOutCubic,
      builder: (context, double value, child) {
        // Create staggered timing for different elements
        final imageValue = (value * 1.3).clamp(0.0, 1.0);
        final titleValue = ((value - 0.2) * 1.3).clamp(0.0, 1.0);
        final infoValue = ((value - 0.4) * 1.3).clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with zoom effect
                Transform.scale(
                  scale: 0.95 + (0.05 * imageValue),
                  child: Opacity(
                    opacity: imageValue,
                    child: Image.network(
                      'https://placehold.co/600x400',
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
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Title with slide effect
                Transform.translate(
                  offset: Offset(20 * (1 - titleValue), 0),
                  child: Opacity(
                    opacity: titleValue,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Course Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // Info row with fade and slide effect
                Transform.translate(
                  offset: Offset(20 * (1 - infoValue), 0),
                  child: Opacity(
                    opacity: infoValue,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 13, color: Color(0xFF700F0F)),
                              SizedBox(width: 4),
                              Text(
                                '02 Jan 2025 - 10 Jan 2025',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF700F0F),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 1,
                            height: 14,
                            color: const Color.fromARGB(255, 210, 205, 205),
                          ),
                          const SizedBox(width: 6),
                          const Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 13, color: Color(0xFF0E1877)),
                              SizedBox(width: 4),
                              Text(
                                '07:00 PM - 09:00 PM',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF0E1877),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        // Clamp opacity between 0 and 1
        final opacity = value.clamp(0.0, 1.0);

        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Transform.rotate(
            angle: (1 - value) * 0.05,
            child: Opacity(
              opacity: opacity, // Using clamped value
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(-20 * (1 - value), 0),
                      child: Image.network(
                        'https://placehold.co/600x400',
                        width: 160,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 160,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 160,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(20 * (1 - value), 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Course Name",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                children: [
                                  Icon(Symbols.calendar_view_week,
                                      size: 11, color: Color(0xFF700F0F)),
                                  SizedBox(width: 4),
                                  Text(
                                    '02 Jan 2025 - 10 Jan 2025',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF700F0F),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.purple, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  const Text(
                                    "4.5",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: const Text(
                                      "Completed",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
