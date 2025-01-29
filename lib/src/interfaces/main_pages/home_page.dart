import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';
import 'package:flynetwork/src/data/models/events_model.dart';
import 'package:flynetwork/src/data/models/news_model.dart';
import 'package:flynetwork/src/data/models/promotion_model.dart';
import 'package:flynetwork/src/data/router/nav_router.dart';
import 'package:flynetwork/src/data/services/navigation_service.dart';
import 'package:flynetwork/src/data/services/snackbar_service.dart';
import 'package:flynetwork/src/interfaces/components/Custom%20Widgets/event_widget.dart';
import 'package:flynetwork/src/interfaces/components/Custom%20Widgets/home_containers.dart';
import 'package:flynetwork/src/interfaces/components/Cards/news_card.dart';
import 'package:flynetwork/src/interfaces/components/Drawer/drawer.dart';
import 'package:flynetwork/src/interfaces/components/VideoPlayer/custom_video.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  int _currentBannerIndex = 0;
  int _currentNoticeIndex = 0;
  int _currentPosterIndex = 0;
  int _currentEventIndex = 0;
  int _currentVideoIndex = 0;

  double _calculateDynamicHeight(List<Promotion> notices) {
    double maxHeight = 0.0;

    for (var notice in notices) {
      // Estimate height based on the length of title and description
      final double titleHeight =
          _estimateTextHeight(notice.title!, 18.0); // Font size 18 for title
      final double descriptionHeight = _estimateTextHeight(
          notice.description!, 14.0); // Font size 14 for description

      final double itemHeight =
          titleHeight + descriptionHeight; // Adding padding
      if (itemHeight > maxHeight) {
        maxHeight = itemHeight + MediaQuery.sizeOf(context).width * 0.05;
      }
    }
    return maxHeight;
  }

  double _estimateTextHeight(String text, double fontSize) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final int numLines = (text.length / (screenWidth / fontSize)).ceil();
    return numLines * fontSize * 1.2 + 35;
  }

  NavigationService navigationService = NavigationService();
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = NavigationService();
    return Consumer(
      builder: (context, ref, child) {
        List<Event> events = [
          Event(
              startTime: DateTime.parse('2024-12-28T11:59:46.167+00:00'),
              id: '1',
              image:
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fevent-wallpaper-16-9&psig=AOvVaw0V_m8PEWMDnCNIA4ZlZE0q&ust=1736881735181000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPiLzeiy84oDFQAAAAAdAAAAABAE',
              eventName: 'TEST EVENT',
              startDate: DateTime.parse('2024-12-28T11:59:46.167+00:00'),
              endDate: DateTime.parse('2024-12-29T11:59:46.167+00:00'),
              description: 'Test Description')
        ];
        List<Promotion> promotions = [
          Promotion(
              description:
                  'We are pleased to introduce our new program on the app, designed to bring you enhanced benefits and features. Don’t miss out—explore the program now and enjoy an improved experience!',
              type: 'notice',
              startDate: DateTime.parse('2024-12-28T11:59:46.167+00:00'),
              title: 'FLY NETWORK'),
          Promotion(
              type: 'banner',
              media:
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Ftoy-store-16-9%2F44&psig=AOvVaw2T2Fe2sr5wz_PD_JmD9yaK&ust=1736880261677000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLDI-6yt84oDFQAAAAAdAAAAABAE'),
          Promotion(
              type: 'poster',
              media:
                  'https://www.google.com/imgres?q=4%3A6%20images%20promotion&imgurl=https%3A%2F%2Fd1csarkz8obe9u.cloudfront.net%2Fposterpreviews%2Fusa-independence-day-sale-promotion-template-design-e3196704486f205e8e3e821b638d76de_screen.jpg%3Fts%3D1718827248&imgrefurl=https%3A%2F%2Fwww.postermywall.com%2Findex.php%2Fart%2Ftemplate%2Fe3196704486f205e8e3e821b638d76de%2Fusa-independence-day-sale-promotion-template-design&docid=V19cUqTu1px4fM&tbnid=JUHkXzWKeOWNcM&vet=12ahUKEwiz39b6rfOKAxViRmcHHb0jFHUQM3oECDwQAA..i&w=462&h=693&hcb=2&itg=1&ved=2ahUKEwiz39b6rfOKAxViRmcHHb0jFHUQM3oECDwQAA')
        ];
        List<News> news = [
          News(
              category: 'Entertainment',
              media:
                  'https://www.google.com/imgres?q=4%3A6%20images%20promotion&imgurl=https%3A%2F%2Fd1csarkz8obe9u.cloudfront.net%2Fposterpreviews%2Fusa-independence-day-sale-promotion-template-design-e3196704486f205e8e3e821b638d76de_screen.jpg%3Fts%3D1718827248&imgrefurl=https%3A%2F%2Fwww.postermywall.com%2Findex.php%2Fart%2Ftemplate%2Fe3196704486f205e8e3e821b638d76de%2Fusa-independence-day-sale-promotion-template-design&docid=V19cUqTu1px4fM&tbnid=JUHkXzWKeOWNcM&vet=12ahUKEwiz39b6rfOKAxViRmcHHb0jFHUQM3oECDwQAA..i&w=462&h=693&hcb=2&itg=1&ved=2ahUKEwiz39b6rfOKAxViRmcHHb0jFHUQM3oECDwQAA',
              title: 'Test News',
              content: 'Test Content'),
        ];
        final banners =
            promotions.where((promo) => promo.type == 'banner').toList();
        final notices =
            promotions.where((promo) => promo.type == 'notice').toList();
        final posters =
            promotions.where((promo) => promo.type == 'poster').toList();
        final videos =
            promotions.where((promo) => promo.type == 'video').toList();
        final filteredVideos =
            videos.where((video) => video.link!.startsWith('http')).toList();
        return RefreshIndicator(
          color: kPrimaryColor,
          onRefresh: () async {
            // ref.invalidate(fetchEventsProvider);
          },
          child: AdvancedDrawer(
            drawer: customDrawer(),
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: kWhite),
            ),
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              // NOTICE: Uncomment if you want to add shadow behind the page.
              // Keep in mind that it may cause animation jerks.
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: Colors.black12,
              //     blurRadius: 0.0,
              //   ),
              // ],
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Scaffold(
                backgroundColor: kWhite,
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/pngs/home_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 45.0,
                              child: Row(
                                children: [
                                  // Leading section
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () => _advancedDrawerController
                                          .showDrawer(),
                                      child: SizedBox(
                                        width: 60, // Match the leadingWidth
                                        child: ValueListenableBuilder<
                                            AdvancedDrawerValue>(
                                          valueListenable:
                                              _advancedDrawerController,
                                          builder: (_, value, __) {
                                            return AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              child: Image.asset(
                                                  'assets/pngs/fly_newtork_logo.png'),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  // Actions section
                                  // Consumer(
                                  //   builder: (context, ref, child) {
                                  //     final asyncNotifications = ref.watch(
                                  //         fetchNotificationsProvider);
                                  //     return asyncNotifications.when(
                                  //       data: (notifications) {
                                  //         bool userExists = notifications
                                  //             .any((notification) =>
                                  //                 notification.users?.any(
                                  //                     (user) =>
                                  //                         user.userId ==
                                  //                         id) ??
                                  //                 false);
                                  //         return IconButton(
                                  //           icon: userExists
                                  //               ? const Icon(
                                  //                   Icons
                                  //                       .notification_add_outlined,
                                  //                   color: kRed)
                                  //               : const Icon(Icons
                                  //                   .notifications_none_outlined),
                                  //           onPressed: () {
                                  //             Navigator.push(
                                  //               context,
                                  //               MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       const NotificationPage()),
                                  //             );
                                  //           },
                                  //         );
                                  //       },
                                  //       loading: () => const Center(
                                  //           child: LoadingAnimation()),
                                  //       error: (error, stackTrace) =>
                                  //           const SizedBox(),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 5,
                              ),
                              child: Text(
                                'Hey , SREERAM',
                                style: kSubHeadingB.copyWith(color: kBlack),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 5, bottom: 10),
                              child: Text('Welcome! ',
                                  style: kSubHeadingR.copyWith(color: kBlack)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  HomeContainers(
                                    icon: Symbols.modeling,
                                    title: 'Continue \nCourse',
                                  ),
                                  HomeContainers(
                                    title: 'My Events',
                                    icon: Symbols.calendar_clock,
                                    iconColor: Color(0xFFFF7A5B),
                                    backgroundColor: Color(0xFFFFF0DE),
                                  ),
                                  HomeContainers(
                                    title: 'My Requests',
                                    icon: Symbols.speaker_notes,
                                    iconColor: Color(0xFFE40985),
                                    backgroundColor: Color(0xFFFFECF8),
                                  ),
                                  HomeContainers(
                                    onTap: () => navigationService
                                        .pushNamed('ProfilePage'),
                                    title: 'ID Card',
                                    icon: Symbols.id_card,
                                    iconColor: Color(0xFF31A806),
                                    backgroundColor: Color(0xFFE5FFCE),
                                  ),
                                ],
                              ),
                            ),
                            // Banner Carousel
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Column(
                                children: [
                                  if (banners.isNotEmpty)
                                    Column(
                                      children: [
                                        CarouselSlider(
                                          items: banners.map((banner) {
                                            return _buildBanners(
                                                context: context,
                                                banner: banner);
                                          }).toList(),
                                          options: CarouselOptions(
                                            height: 175,
                                            scrollPhysics: banners.length > 1
                                                ? null
                                                : const NeverScrollableScrollPhysics(),
                                            autoPlay: banners.length > 1
                                                ? true
                                                : false,
                                            viewportFraction: 1,
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _currentBannerIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                  const SizedBox(height: 16),

                                  // Notices Carousel
                                  if (notices.isNotEmpty)
                                    Column(
                                      children: [
                                        CarouselSlider(
                                          items: notices.map((notice) {
                                            return customNotice(
                                                context: context,
                                                notice: notice);
                                          }).toList(),
                                          options: CarouselOptions(
                                            scrollPhysics: notices.length > 1
                                                ? null
                                                : const NeverScrollableScrollPhysics(),
                                            autoPlay: notices.length > 1
                                                ? true
                                                : false,
                                            viewportFraction: 1,
                                            height: _calculateDynamicHeight(
                                                notices),
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _currentNoticeIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (notices.length > 1)
                                          _buildDotIndicator(
                                              _currentNoticeIndex,
                                              notices.length,
                                              const Color.fromARGB(
                                                  255, 39, 38, 38)),
                                      ],
                                    ),

                                  if (posters.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          CarouselSlider(
                                            items: posters
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              int index = entry.key;
                                              Promotion poster = entry.value;

                                              return KeyedSubtree(
                                                key: ValueKey(index),
                                                child: customPoster(
                                                    context: context,
                                                    poster: poster),
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                              height: 420,
                                              scrollPhysics: posters.length > 1
                                                  ? null
                                                  : const NeverScrollableScrollPhysics(),
                                              autoPlay: posters.length > 1,
                                              viewportFraction: 1,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  _currentPosterIndex = index;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: Text('Latest Events',
                                                style: kSubHeadingB.copyWith(
                                                    color: kBlack)),
                                          ),
                                        ],
                                      ),
                                      CarouselSlider(
                                        items: events.map((event) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            child: GestureDetector(
                                              onTap: () {
                                                navigationService.pushNamed(
                                                    'ViewMoreEvent',
                                                    arguments: event);
                                              },
                                              child: eventWidget(
                                                withImage: true,
                                                context: context,
                                                event: event,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 268,
                                          scrollPhysics: events.length > 1
                                              ? null
                                              : const NeverScrollableScrollPhysics(),
                                          autoPlay:
                                              events.length > 1 ? true : false,
                                          viewportFraction: 1,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _currentEventIndex = index;
                                            });
                                          },
                                        ),
                                      ),
                                      // _buildDotIndicator(_currentEventIndex,
                                      //     events.length, Colors.red),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 10, right: 15),
                                        child: Row(
                                          children: [
                                            Text('Latest News',
                                                style: kSubHeadingB.copyWith(
                                                    color: kBlack)),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () => ref
                                                  .read(selectedIndexProvider
                                                      .notifier)
                                                  .updateIndex(3),
                                              child: const Text('see all',
                                                  style: kSmallTitleR),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 180,
                                        child: ListView.builder(
                                          controller: ScrollController(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: news.length,
                                          itemBuilder: (context, index) {
                                            final individualNews = news[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: newsCard(
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                            selectedIndexProvider
                                                                .notifier)
                                                        .updateIndex(3);
                                                  },
                                                  imageUrl:
                                                      individualNews.media ??
                                                          '',
                                                  title: individualNews.title ??
                                                      '',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Videos Carousel
                                  if (filteredVideos.isNotEmpty)
                                    Column(
                                      children: [
                                        CarouselSlider(
                                          items: filteredVideos.map((video) {
                                            return customVideo(
                                                context: context, video: video);
                                          }).toList(),
                                          options: CarouselOptions(
                                            height: 225,
                                            scrollPhysics: videos.length > 1
                                                ? null
                                                : const NeverScrollableScrollPhysics(),
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _currentVideoIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                        if (videos.length > 1)
                                          _buildDotIndicator(
                                              _currentVideoIndex,
                                              filteredVideos.length,
                                              Colors.black),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  // Method to build a dot indicator for carousels
  Widget _buildDotIndicator(int currentIndex, int itemCount, Color color) {
    return Center(
      child: SmoothPageIndicator(
        controller: PageController(initialPage: currentIndex),
        count: itemCount,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: color,
          dotColor: Colors.grey,
        ),
      ),
    );
  }
}

Widget _buildBanners(
    {required BuildContext context, required Promotion banner}) {
  return TweenAnimationBuilder(
    duration: const Duration(milliseconds: 1500),
    tween: Tween<double>(begin: 0.0, end: 1.0),
    curve: Curves.easeOutQuart,
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(0, 20 * (1 - value)),
        child: Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 1.15,
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.network(
                          banner.media ?? '',
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget customPoster({
  required BuildContext context,
  required Promotion poster,
}) {
  return TweenAnimationBuilder(
    duration: const Duration(milliseconds: 1000),
    tween: Tween<double>(begin: 0.0, end: 1.0),
    curve: Curves.easeOutCubic,
    builder: (context, double value, child) {
      return Transform.scale(
        scale: 0.7 + (0.3 * value),
        child: Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 19 / 20,
                child: Image.network(
                  poster.media ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget customNotice({
  required BuildContext context,
  required Promotion notice,
}) {
  return TweenAnimationBuilder(
    duration: const Duration(milliseconds: 1500),
    tween: Tween<double>(begin: 0.0, end: 1.0),
    curve: Curves.easeOutBack,
    builder: (context, double value, child) {
      // Staggered timing for different elements
      final containerValue = value.clamp(0.0, 1.0);
      final titleValue = ((value - 0.2) * 1.2).clamp(0.0, 1.0);
      final descriptionValue = ((value - 0.3) * 1.2).clamp(0.0, 1.0);

      return Opacity(
        opacity: containerValue,
        child: Transform.translate(
          offset: Offset(0, 15 * (1 - containerValue)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withOpacity((0.2 * value).clamp(0.0, 1.0)),
                    blurRadius: 10 * value.clamp(0.0, 1.0),
                    spreadRadius: 0,
                    offset: Offset(0, 5 * value.clamp(0.0, 1.0)),
                  ),
                ],
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Transform.translate(
                    offset: Offset(0, -5 * (1 - titleValue)),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: kPrimaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Opacity(
                          opacity: titleValue,
                          child: Text(
                            'Notice',
                            style: kBodyTitleB.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Transform.translate(
                    offset: Offset(20 * (1 - titleValue), 0),
                    child: Opacity(
                      opacity: titleValue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          notice.title!,
                          style: kSmallTitleB.copyWith(color: kBlack),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(20 * (1 - descriptionValue), 0),
                    child: Opacity(
                      opacity: descriptionValue,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          notice.description!,
                          style: const TextStyle(color: kGreyDark),
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
