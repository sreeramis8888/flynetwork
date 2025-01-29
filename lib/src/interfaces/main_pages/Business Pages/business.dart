import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:flynetwork/src/data/router/nav_router.dart';
import 'package:flynetwork/src/interfaces/components/Cards/Business%20Cards/business_course_card.dart';
import 'package:flynetwork/src/interfaces/components/Cards/Business%20Cards/business_meeting_card.dart';
import 'package:flynetwork/src/interfaces/components/Cards/Business%20Cards/business_referral_card.dart';
import 'package:flynetwork/src/interfaces/components/Cards/Business%20Cards/product_card.dart';
import 'package:flynetwork/src/interfaces/main_pages/Business%20Pages/business_request.dart';

class BusinessPage extends StatefulWidget {
  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _buildProductsTab() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          mainAxisExtent: 200),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ProductCard();
      },
    );
  }

  Widget _buildCourseTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return BusinessCourseCard();
      },
    );
  }

  Widget _buildReferralsTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return BusinessReferralCard();
      },
    );
  }

  Widget _buildMeetingTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return BusinessMeetingCard();
      },
    );
  }

  Widget _getSelectedTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildProductsTab();
      case 1:
        return _buildCourseTab();
      case 2:
        return _buildReferralsTab();
      case 3:
        return _buildMeetingTab();
      default:
        return _buildProductsTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  border: Border.all(color: kGrey),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              onPressed: () {
                ref.read(selectedIndexProvider.notifier).updateIndex(0);
              },
            );
          },
        ),
        title: const Text("Business", style: kBodyTitleR),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: kPrimaryColor,
                labelColor: kPrimaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Business'),
                  Tab(text: 'Requests'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildTabOption(context, 'Products', 0),
                                _buildTabOption(context, 'Course', 1),
                                _buildTabOption(context, 'Referrals', 2),
                                _buildTabOption(context, '1 on 1 Meeting', 3),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Colors
                                      .grey), // Set hint text color to grey
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.grey), // Default border color
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color:
                                        kGreyLight), // Border when not focused
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: kGreyLight), // Border when focused
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color:
                                        kGreyLight), // Border when there is an error
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color:
                                        kGreyLight), // Border when focused and error
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12), // Reduce height
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: _getSelectedTabContent(),
                        ),
                      ],
                    ),
                  ),
                  BusinessRequestsPage()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTabOption(BuildContext context, String title, int index) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _selectedTabIndex == index ? Colors.white : kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
