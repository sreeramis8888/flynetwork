import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:flynetwork/src/data/globals.dart';
import 'package:flynetwork/src/data/models/chat_model.dart';
import 'package:flynetwork/src/data/models/review_model.dart';
import 'package:flynetwork/src/data/models/user_model.dart';
import 'package:flynetwork/src/data/services/launch_url.dart';
import 'package:flynetwork/src/data/services/navigation_service.dart';
import 'package:flynetwork/src/interfaces/components/Buttons/primary_button.dart';
import 'package:flynetwork/src/interfaces/components/Cards/award_card.dart';
import 'package:flynetwork/src/interfaces/components/Cards/certificate_card.dart';
import 'package:flynetwork/src/interfaces/components/Custom%20Widgets/review_barchart.dart';
import 'package:flynetwork/src/interfaces/components/Modal%20Sheets/write_review.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ReviewsState extends StateNotifier<int> {
  ReviewsState() : super(1);

  void showMoreReviews(int totalReviews) {
    state = (state + 2).clamp(0, totalReviews);
  }
}

final reviewsProvider = StateNotifierProvider<ReviewsState, int>((ref) {
  return ReviewsState();
});

class ProfilePreview extends ConsumerWidget {
  final UserModel user;
  ProfilePreview({super.key, required this.user});

  final List<String> svgIcons = [
    'assets/svg/icons/instagram.svg',
    'assets/svg/icons/linkedin.svg',
    'assets/svg/icons/twitter.svg',
    'assets/svg/icons/facebook.svg'
  ];

  final ValueNotifier<int> _currentVideo = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsToShow = ref.watch(reviewsProvider);
    PageController _videoCountController = PageController();

    _videoCountController.addListener(() {
      _currentVideo.value = _videoCountController.page!.round();
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          if (id == user.uid)
            IconButton(
              icon: const Icon(
                size: 20,
                Icons.edit,
                color: kPrimaryColor,
              ),
              onPressed: () {
                NavigationService navigationService = NavigationService();
                navigationService.pushNamed('EditUser');
              },
            )
        ],
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 0),
          child: Container(width: double.infinity, height: 1, color: kTertiary),
        ),
        backgroundColor: kWhite,
        title: const Text(
          'Preview',
          style: kSubHeadingL,
        ),
      ),
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/pngs/home_background.png'), // Texture image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              child: Opacity(
                  opacity: .2,
                  child:
                      SvgPicture.asset('assets/svg/images/previewFlower.svg'))),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 170,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        user.image != null && user.image != ''
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: kPrimaryColor,
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    user.image ?? '',
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : Image.asset(
                                'assets/icons/dummy_person_large.png'),
                        const SizedBox(height: 10),
                        Text('${user.name ?? ''}', style: kHeadTitleSB),
                        const SizedBox(height: 5),
                        if (user.company != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Column(
                              //   children: [
                              //     if (user.company?.designation != null ||
                              //         user.company?.name != null)
                              //       ClipRRect(
                              //           borderRadius: BorderRadius.circular(9),
                              //           child: user.company?.logo != null &&
                              //                   user.company?.logo != ''
                              //               ? Image.network(
                              //                   errorBuilder: (context, error,
                              //                       stackTrace) {
                              //                     return Image.asset(
                              //                         'assets/icons/dummy_company.png');
                              //                   },
                              //                   user.company!.logo!,
                              //                   height: 33,
                              //                   width: 40,
                              //                   fit: BoxFit.contain,
                              //                 )
                              //               : Image.asset(
                              //                   'assets/icons/dummy_company.png'))
                              //   ],
                              // ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (Company i in user.company ?? [])
                                    if ((i?.name != null && i?.name != '') ||
                                        (i?.designation != null &&
                                            i?.designation != ''))
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            if (i.name != null && i.name != '')
                                              TextSpan(
                                                text: i.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 42, 41, 41),
                                                ),
                                              ),
                                            if (i.name != null &&
                                                i.name != '' &&
                                                i.designation != null &&
                                                i.designation != '')
                                              const TextSpan(
                                                text: ' - ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            if (i.designation != null &&
                                                i.designation != '')
                                              TextSpan(
                                                text: i.designation,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 234, 226, 226),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              'assets/pngs/fly_newtork_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            // Added Expanded widget to make the text expandable
                            child: Text(
                              'Member ID: ${user.memberId}',
                              overflow: TextOverflow
                                  .ellipsis, // Optional: handles overflow
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 10, right: 10),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(
                    //           color: const Color.fromARGB(255, 234, 226, 226))),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Flexible(
                    //             child: Text(
                    //                 'College: ${user.college?.collegeName ?? ''}'))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 10),
                    //       child: Text(
                    //         'Personal',
                    //         style: TextStyle(
                    //             fontSize: 17, fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.phone, color: kPrimaryColor),
                              const SizedBox(width: 10),
                              Text(user.phone.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (user.email != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.email, color: kPrimaryColor),
                                const SizedBox(width: 10),
                                Text(user.email ?? ''),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (user.address != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: kPrimaryColor),
                                const SizedBox(width: 10),
                                if (user.address != null)
                                  Expanded(
                                    child: Text(
                                      user.address!,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 60),
                    if (user.bio != null &&
                        user.bio != '' &&
                        user.bio != 'null')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/pngs/“.png',
                            
                            ),
                          ),
                        ],
                      ),
                    if (user.bio != null &&
                        user.bio != '' &&
                        user.bio != 'null')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(child: Text('''${user.bio}''')),
                          ],
                        ),
                      ),

                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          List<ReviewModel> reviews = [
                            ReviewModel(
                              id: '1',
                              toUser: 'user_123',
                              reviewer: Reviewer(
                                id: 'reviewer_1',
                                name: 'John Doe',
                                image:
                                    'https://example.com/images/john_doe.jpg',
                              ),
                              rating: 5,
                              comment: 'Excellent service! Highly recommended.',
                              createdAt:
                                  DateTime.now().subtract(Duration(days: 2)),
                              updatedAt:
                                  DateTime.now().subtract(Duration(days: 1)),
                              version: 1,
                            ),
                            ReviewModel(
                              id: '2',
                              toUser: 'user_456',
                              reviewer: Reviewer(
                                id: 'reviewer_2',
                                name: 'Jane Smith',
                                image:
                                    'https://example.com/images/jane_smith.jpg',
                              ),
                              rating: 4,
                              comment:
                                  'Great experience, but there is room for improvement.',
                              createdAt:
                                  DateTime.now().subtract(Duration(days: 5)),
                              updatedAt:
                                  DateTime.now().subtract(Duration(days: 3)),
                              version: 1,
                            ),
                            ReviewModel(
                              id: '3',
                              toUser: 'user_789',
                              reviewer: Reviewer(
                                id: 'reviewer_3',
                                name: 'Alice Johnson',
                                image:
                                    'https://example.com/images/alice_johnson.jpg',
                              ),
                              rating: 3,
                              comment:
                                  'It was okay, but I expected better service.',
                              createdAt:
                                  DateTime.now().subtract(Duration(days: 10)),
                              updatedAt:
                                  DateTime.now().subtract(Duration(days: 8)),
                              version: 1,
                            ),
                            ReviewModel(
                              id: '4',
                              toUser: 'user_101',
                              reviewer: Reviewer(
                                id: 'reviewer_4',
                                name: 'Michael Brown',
                                image:
                                    'https://example.com/images/michael_brown.jpg',
                              ),
                              rating: 2,
                              comment: 'Not satisfied with the experience.',
                              createdAt:
                                  DateTime.now().subtract(Duration(days: 15)),
                              updatedAt:
                                  DateTime.now().subtract(Duration(days: 14)),
                              version: 1,
                            ),
                            ReviewModel(
                              id: '5',
                              toUser: 'user_202',
                              reviewer: Reviewer(
                                id: 'reviewer_5',
                                name: 'Emily Davis',
                                image:
                                    'https://example.com/images/emily_davis.jpg',
                              ),
                              rating: 1,
                              comment:
                                  'Very disappointing experience. Not recommended.',
                              createdAt:
                                  DateTime.now().subtract(Duration(days: 20)),
                              updatedAt:
                                  DateTime.now().subtract(Duration(days: 18)),
                              version: 1,
                            ),
                          ];
                          return Column(
                            children: [
                              ReviewBarChart(
                                reviews: reviews ?? [],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (user.uid != id)
                                primaryButton(
                                    buttonColor: Colors.transparent,
                                    sideColor: kPrimaryColor,
                                    labelColor: kPrimaryColor,
                                    label: 'Write a Review',
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        builder: (context) =>
                                            ShowWriteReviewSheet(
                                          userId: user.uid ?? '',
                                        ),
                                      );
                                    },
                                    fontSize: 15),
                              if (reviews.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: reviewsToShow,
                                  itemBuilder: (context, index) {
                                    final ratingDistribution =
                                        getRatingDistribution(reviews);
                                    final averageRating =
                                        getAverageRating(reviews);
                                    final totalReviews = reviews.length;
                                    return ReviewsCard(
                                      review: reviews[index],
                                      ratingDistribution: ratingDistribution,
                                      averageRating: averageRating,
                                      totalReviews: totalReviews,
                                    );
                                  },
                                ),
                              if (reviewsToShow < reviews.length)
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(reviewsProvider.notifier)
                                        .showMoreReviews(reviews.length);
                                  },
                                  child: Text('View More'),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    // if (user.id != id)
                    //   Row(
                    //     children: [
                    //       SizedBox(
                    //           width: 100,
                    //           child: customButton(
                    //               label: 'Write a Review',
                    //               onPressed: () {
                    //                 showModalBottomSheet(
                    //                   context: context,
                    //                   isScrollControlled: true,
                    //                   shape: const RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.vertical(
                    //                             top: Radius.circular(20)),
                    //                   ),
                    //                   builder: (context) =>
                    //                       ShowWriteReviewSheet(
                    //                     userId: user.id!,
                    //                   ),
                    //                 );
                    //               },
                    //               fontSize: 15)),
                    //     ],
                    //   ),

                    // if (user.company?.designation != null ||
                    //     user.company?.email != null ||
                    //     user.company?.websites != null ||
                    //     user.company?.phone != null ||
                    //     user.company?.designation != '' ||
                    //     user.company?.email != '' ||
                    //     user.company?.websites != '' ||
                    //     user.company?.phone != '' ||
                    //     user.company != null)
                    //   const Row(
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 10),
                    //         child: Text(
                    //           'Company',
                    //           style: TextStyle(
                    //               fontSize: 17, fontWeight: FontWeight.w600),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Column(
                    //   children: [
                    //     if (user.company?.phone != null)
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             const Icon(Icons.phone, color: kPrimaryColor),
                    //             const SizedBox(width: 10),
                    //             Text(user.company?.phone ?? ''),
                    //           ],
                    //         ),
                    //       ),
                    //     // const SizedBox(height: 10),
                    //     // if (user.company?.address != null)
                    //     //   Padding(
                    //     //     padding: const EdgeInsets.only(left: 10),
                    //     //     child: Row(
                    //     //       children: [
                    //     //         const Icon(Icons.location_on,
                    //     //             color: kPrimaryColor),
                    //     //         const SizedBox(width: 10),
                    //     //         if (user.company?.address != null)
                    //     //           Expanded(
                    //     //             child: Text(user.company?.address ?? ''),
                    //     //           )
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     const SizedBox(height: 30),
                    //   ],
                    // ),
                    if (user.social?.isNotEmpty == true)
                      const Row(
                        children: [
                          Text(
                            'Social Media',
                            style: TextStyle(
                              color: Color(0xFF2C2829),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    if (user.social?.isNotEmpty == true)
                      for (int index = 0; index < user.social!.length; index++)
                        customSocialPreview(index, social: user.social![index]),
                    if (user.websites?.isNotEmpty == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            Text(
                              'Websites & Links',
                              style: TextStyle(
                                  color: Color(0xFF2C2829),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    if (user.websites?.isNotEmpty == true)
                      for (int index = 0;
                          index < user.websites!.length;
                          index++)
                        customWebsitePreview(index,
                            website: user.websites![index]),
                    const SizedBox(
                      height: 30,
                    ),
                    if (user.videos?.isNotEmpty == true)
                      Column(
                        children: [
                          SizedBox(
                            width: 500,
                            height: 260,
                            child: PageView.builder(
                              controller: _videoCountController,
                              itemCount: user.videos!.length,
                              physics: const PageScrollPhysics(),
                              itemBuilder: (context, index) {
                                return profileVideo(
                                    context: context,
                                    video: user.videos![index]);
                              },
                            ),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: _currentVideo,
                            builder: (context, value, child) {
                              return SmoothPageIndicator(
                                controller: _videoCountController,
                                count: user.videos!.length,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 6,
                                  activeDotColor: Colors.black,
                                  dotColor: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (user.certificates?.isNotEmpty == true)
                      const Row(
                        children: [
                          Text(
                            'Certificates',
                            style: TextStyle(
                                color: Color(0xFF2C2829),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    if (user.certificates?.isNotEmpty == true)
                      ListView.builder(
                        shrinkWrap:
                            true, // Let ListView take up only as much space as it needs
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable ListView's internal scrolling
                        itemCount: user.certificates!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0), // Space between items
                            child: CertificateCard(
                              certificate: user.certificates![index],
                              onRemove: null,
                            ),
                          );
                        },
                      ),
                    if (user.awards?.isNotEmpty == true)
                      const Row(
                        children: [
                          Text(
                            'Awards',
                            style: TextStyle(
                                color: Color(0xFF2C2829),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    if (user.awards?.isNotEmpty == true)
                      GridView.builder(
                        shrinkWrap:
                            true, // Let GridView take up only as much space as it needs
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable GridView's internal scrolling
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 8.0, // Space between columns
                          mainAxisSpacing: 20.0, // Space between rows
                        ),
                        itemCount: user.awards!.length,
                        itemBuilder: (context, index) {
                          return AwardCard(
                            award: user.awards![index],
                            onRemove: null,
                          );
                        },
                      ),
                  ]),
                ),
              ],
            ),
          ),
          // if (user.uid != id)
          //   Positioned(
          //       bottom: 40,
          //       left: 15,
          //       right: 15,
          //       child: SizedBox(
          //           height: 50,
          //           child: Row(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Flexible(
          //                 child: primaryButton(
          //                     buttonHeight: 60,
          //                     fontSize: 16,
          //                     label: 'SAY HI',
          //                     onPressed: () {
          //                       final Participant receiver = Participant(
          //                         id: user.uid,
          //                         image: user.image ?? '',
          //                         name: user.name,
          //                       );
          //                       final Participant sender = Participant(id: id);
          //                       Navigator.of(context).push(MaterialPageRoute(
          //                           builder: (context) => IndividualPage(
          //                                 receiver: receiver,
          //                                 sender: sender,
          //                               )));
          //                     }),
          //               ),
          //               const SizedBox(
          //                 width: 10,
          //               ),
          //               Flexible(
          //                 child: customButton(
          //                     sideColor:
          //                         const Color.fromARGB(255, 219, 217, 217),
          //                     labelColor: const Color(0xFF2C2829),
          //                     buttonColor:
          //                         const Color.fromARGB(255, 222, 218, 218),
          //                     buttonHeight: 60,
          //                     fontSize: 13,
          //                     label: 'SAVE CONTACT',
          //                     onPressed: () {
          //                       if (user.phone != null) {
          //                         saveContact(
          //                             firstName: '${user.name ?? ''}',
          //                             number: user.phone ?? '',
          //                             email: user.email ?? '',
          //                             context: context);
          //                       }
          //                     }),
          //               ),
          //             ],
          //           ))),
        ],
      ),
    );
  }

  Widget profileVideo({required BuildContext context, required Link video}) {
    final videoUrl = video.link;

    final ytController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(videoUrl ?? '') ?? '',
      autoPlay: false,
      params: const YoutubePlayerParams(
        enableJavaScript: true,
        loop: true,
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(video.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width:
                  MediaQuery.of(context).size.width - 32, // Full-screen width
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.circular(8.0),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: YoutubePlayer(
                  controller: ytController,
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding customSocialPreview(int index, {Link? social}) {
    log('Icons: ${svgIcons[index]}');
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          if (social != null) {
            launchURL(social.link ?? '');
          }
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF2F2F2),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Align(
                      alignment: Alignment.topCenter,
                      widthFactor: 1.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          width: 42,
                          height: 42,
                          child: SvgPicture.asset(svgIcons[index],
                              color: kPrimaryColor))),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Text('${social?.name}')),
              ],
            )),
      ),
    );
  }

  Padding customWebsitePreview(int index, {Link? website}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          if (website != null) {
            launchURL(website.link ?? '');
          }
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF2F2F2),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Align(
                    alignment: Alignment.topCenter,
                    widthFactor: 1.0,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        width: 42,
                        height: 42,
                        child: const Icon(
                          Icons.language,
                          color: kPrimaryColor,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Text('${website!.name}')),
              ],
            )),
      ),
    );
  }
}
