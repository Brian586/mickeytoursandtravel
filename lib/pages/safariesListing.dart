import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/models/safari.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:mickeytours/widgets/customAppBar.dart';
import 'package:mickeytours/widgets/footer.dart';
import 'package:mickeytours/widgets/whatsappBtn.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/customButton.dart';

class SafariesListing extends StatefulWidget {
  const SafariesListing({Key? key}) : super(key: key);

  @override
  State<SafariesListing> createState() => _SafariesListingState();
}

class _SafariesListingState extends State<SafariesListing> {
  final ScrollController _controller = ScrollController();
  int limit = 15;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: const WhatsappButton(),
      appBar: PreferredSize(
          preferredSize: Size(size.width, 50.0),
          child: const CustomAppBar(
            isShrink: true,
          )),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          bool isMobile = sizingInformation.isMobile;

          return RawScrollbar(
            controller: _controller,
            isAlwaysShown: true,
            radius: const Radius.circular(6.0),
            thumbColor: Colors.pink,
            thickness: 12.0,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1000.0,
                      minWidth: 450.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isMobile
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Safaries",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => CustomRoutes.router
                                            .navigateTo(context, "/"),
                                        child: Text(
                                          "Mickey Tours & Travel ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey,
                                        size: 12.0,
                                      ),
                                      Text(
                                        " Safaries",
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Safaries",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => CustomRoutes.router
                                            .navigateTo(context, "/"),
                                        child: Text(
                                          "Mickey Tours & Travel ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey,
                                        size: 12.0,
                                      ),
                                      Text(
                                        " Safaries",
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("safaries")
                              .orderBy("timestamp", descending: true)
                              .limit(limit)
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return circularProgress();
                            } else {
                              List<Safari> safaries = [];

                              snapshot.data!.docs.forEach((element) {
                                Safari safari = Safari.fromDocument(element);

                                safaries.add(safari);
                              });

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: safaries.length,
                                    itemBuilder: (context, index) {
                                      Safari safari = safaries[index];

                                      return SafariListingItem(
                                        safari: safari,
                                      );
                                    },
                                  ),
                                  CustomButton(
                                    title: "Load More",
                                    color: Colors.pink,
                                    onTap: () {
                                      setState(() {
                                        limit = limit + 10;
                                      });
                                    },
                                  )
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Footer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SafariListingItem extends StatefulWidget {
  final Safari? safari;
  const SafariListingItem({Key? key, this.safari}) : super(key: key);

  @override
  State<SafariListingItem> createState() => _SafariListingItemState();
}

class _SafariListingItemState extends State<SafariListingItem> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isMobile;

        return InkWell(
          onTap: () {
            CustomRoutes.router.navigateTo(
              context,
              "/safaries/${widget.safari!.safariID}",
            );
          },
          hoverColor: Colors.transparent,
          onHover: (v) {
            setState(() {
              onHover = v;
            });
          },
          child: Card(
            color: Colors.white,
            shadowColor: Colors.black,
            elevation: onHover ? 10.0 : 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: isMobile ? 150.0 : 300.0,
              //padding: const EdgeInsets.all(10.0),
              width: size.width,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10.0))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/blank_image.png",
                      image: widget.safari!.imageUrl!,
                      height: size.height,
                      width: isMobile ? 150.0 : 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.safari!.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.safari!.city! +
                                    ", " +
                                    widget.safari!.country!,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          Text(
                            widget.safari!.description!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.hotel,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    widget.safari!.currency! +
                                        " " +
                                        widget.safari!.cost!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
