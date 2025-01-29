import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/constants/style_constant.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pngs/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: kGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: const Icon(
                            Icons.arrow_back,
                            color: kPrimaryColor,
                          ),
                        )),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: const Text(
                    "ID Card",
                    style: kBodyTitleR,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 182, 181, 181)
                                      .withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: const Offset(.5, .5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      onBackgroundImageError: (_, __) =>
                                          Image.asset(
                                              'assets/dummy_person_large.png'),
                                      radius: 40,
                                      backgroundImage: NetworkImage(''),
                                    ),
                                    const SizedBox(height: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'SREERAM I S',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Dev',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 42, 41, 41),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          maxLines: 2,
                                          'Xyvin',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 35, right: 30, top: 25, bottom: 35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: const Border(
                                top: BorderSide(
                                  color: Color.fromARGB(
                                      255, 237, 231, 231), // Your border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              // border: Border.all(
                              //     color: const Color.fromARGB(255, 237, 231, 231)),
                              // color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.5),
                              //     spreadRadius: 0,
                              //     blurRadius: 1,
                              //     offset: const Offset(.5, .5),
                              //   ),
                              // ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.phone,
                                        color: kPrimaryColor),
                                    const SizedBox(width: 10),
                                    Text('+919645398555'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.email,
                                        color: kPrimaryColor),
                                    const SizedBox(width: 10),
                                    Text('sreeramis8888@gmail.com'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: kPrimaryColor),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(child: Text('Thrissur, KL')),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              border: const Border(
                                top: BorderSide(
                                  color: Color.fromARGB(
                                      255, 237, 231, 231), // Your border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: const Offset(.5, .5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'FLY NETWORK',
                                  style: kSmallTitleB.copyWith(
                                      color: kPrimaryColor),
                                ),
                                Text(
                                  'Member ID: FLY1234',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                            ),
                            shape: BoxShape.circle,
                            color: kWhite),
                        child: Center(
                            child: Icon(
                          Icons.share,
                          color: kPrimaryColor,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                            ),
                            shape: BoxShape.circle,
                            color: kWhite),
                        child: Center(
                            child: Icon(
                          Icons.qr_code_2,
                          color: kPrimaryColor,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                            ),
                            shape: BoxShape.circle,
                            color: kWhite),
                        child: Center(
                            child: Icon(
                          Icons.remove_red_eye,
                          color: kPrimaryColor,
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
