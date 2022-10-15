import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/models/post.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:mickeytours/widgets/customAppBar.dart';
import 'package:mickeytours/widgets/footer.dart';
import 'package:mickeytours/widgets/whatsappBtn.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'holidayHomesListing.dart';

class CategoriesListing extends StatefulWidget {
  final String? category;
  const CategoriesListing({Key? key, this.category}) : super(key: key);

  @override
  State<CategoriesListing> createState() => _CategoriesListingState();
}

class _CategoriesListingState extends State<CategoriesListing> {
  final ScrollController _controller = ScrollController();
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
                                    widget.category!,
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
                                        " " + widget.category!,
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
                                    widget.category!,
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
                                        " " + widget.category!,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("posts")
                              .where("ownerId",
                                  isEqualTo: "DUxn3LLKj4e0QF9aijMOwpf9Qlr1")
                              .where("type", isEqualTo: widget.category)
                              .orderBy("timestamp", descending: true)
                              .limit(15)
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return circularProgress();
                            } else {
                              List<Post> posts = [];

                              snapshot.data!.docs.forEach((element) {
                                Post post = Post.fromDocument(element);

                                posts.add(post);
                              });

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  Post post = posts[index];

                                  return ListingItem(
                                    post: post,
                                  );
                                },
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
