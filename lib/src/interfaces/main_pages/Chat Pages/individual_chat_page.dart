import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/interfaces/components/Cards/message%20Cards/own_message_card.dart';

import 'package:intl/intl.dart';

class IndividualPage extends ConsumerStatefulWidget {
  IndividualPage({super.key});

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends ConsumerState<IndividualPage> {
  bool isBlocked = false;
  bool show = false;
  FocusNode focusNode = FocusNode();

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kPrimaryLightColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                elevation: 1,
                shadowColor: Colors.white,
                backgroundColor: Colors.white,
                leadingWidth: 90,
                titleSpacing: 0,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Image.network(
                          '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                'assets/svg/icons/dummy_person_small.svg');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                title: Consumer(
                  builder: (context, ref, child) {
                    return GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Tijo',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
                // actions: [
                //   IconButton(
                //       icon: const Icon(Icons.report_gmailerrorred),
                //       onPressed: () {
                //         showReportPersonDialog(
                //             context: context,
                //             onReportStatusChanged: () {},
                //             reportType: 'user',
                //             reportedItemId: widget.receiver.id ?? '');
                //       }),
                //   IconButton(
                //       icon: const Icon(Icons.block),
                //       onPressed: () {
                //         showBlockPersonDialog(
                //             context: context,
                //             userId: widget.receiver.id ?? '',
                //             onBlockStatusChanged: () {
                //               Future.delayed(Duration(seconds: 1));
                //               setState(() {
                //                 if (isBlocked) {
                //                   isBlocked = false;
                //                 } else {
                //                   isBlocked = true;
                //                 }
                //               });
                //             });
                //       }),
                // ],
              )),
          body: PopScope(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return OwnMessageCard(
                      status: 'sent',
                      message: 'Hello How are you',
                      time: DateFormat('h:mm a').format(
                        DateTime.parse('2025-01-10T10:07:50.378+00:00')
                            .toLocal(),
                      ),
                    );
                  },
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    color: kWhite,
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 220, 215, 215),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5.0),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 150, // Limit the height
                                ),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true, // Start from bottom
                                    child: TextField(
                                      controller: _controller,
                                      focusNode: focusNode,
                                      keyboardType: TextInputType.multiline,
                                      maxLines:
                                          null, // Allows for unlimited lines
                                      minLines: 1, // Starts with a single line
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 2,
                            left: 2,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // sendMessage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            onPopInvoked: (didPop) {
              if (didPop) {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  focusNode.unfocus();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  });
                }
                // ref.invalidate(fetchChatThreadProvider);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
