import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:flynetwork/src/data/router/nav_router.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text(
          "My Activities",
          style: kBodyTitleR,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: kGreyLight,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kGreyLight,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Icon(Icons.filter_list),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard(
                    seller: "Anjana Singh",
                    buyer: "Manoj Ram",
                    amount: "Rs. 2500",
                    title: "Business Title",
                  ),
                  _buildMeetingCard(),
                  _buildReferralCard(),
                  _buildRecommendationCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String seller,
    required String buyer,
    required String amount,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kGreyLight),
            color: kWhite,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildUserInfo("Seller", seller),
                  _buildUserInfo("Buyer", buyer),
                ],
              ),
              const SizedBox(height: 8),
              Text("Business Title",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Amount Paid: $amount",
                  style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String role, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(role, style: TextStyle(color: Colors.green)),
        Row(
          children: [
            CircleAvatar(radius: 16),
            const SizedBox(width: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildMeetingCard() {
    return _buildDetailedCard(
      title: "Lorem ipsum dolor sit amet consectetur.",
      description:
          "Lorem ipsum dolor sit amet consectetur. Quis enim nisl ullamcorper tristique integer orci nunc.",
      label: "1 to 1 meeting",
      meetingLink: "https://www.meetinglink.co.in/",
    );
  }

  Widget _buildReferralCard() {
    return _buildDetailedCard(
      title: "Referral",
      description: "Lorem ipsum dolor sit amet consectetur.",
      label: "Referral",
      meetingLink: "John Kappa",
    );
  }

  Widget _buildRecommendationCard() {
    return _buildDetailedCard(
      title: "Recognition",
      description: "Lorem ipsum dolor sit amet consectetur.",
      label: "Recommendation",
      meetingLink: "John Kappa",
    );
  }

  Widget _buildDetailedCard({
    required String title,
    required String description,
    required String label,
    required String meetingLink,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kGreyLight),
            color: kWhite,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("John Kappa",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Chip(label: Text(label)),
                ],
              ),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description),
              const SizedBox(height: 4),
              Text("Meeting Link: $meetingLink",
                  style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.calendar_today, size: 14),
                  SizedBox(width: 4),
                  Text("02 JAN 2023 | 09:00 PM"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
