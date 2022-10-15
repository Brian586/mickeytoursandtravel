import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/models/post.dart';
import 'package:mickeytours/pages/holidayHomesListing.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:mickeytours/widgets/postWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HolidayHomes extends StatefulWidget {
  const HolidayHomes({Key? key}) : super(key: key);

  @override
  State<HolidayHomes> createState() => _HolidayHomesState();
}

class _HolidayHomesState extends State<HolidayHomes> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const HolidayHomesMobile(),
      tablet: (BuildContext context) => const HolidayHomesTablet(),
      desktop: (BuildContext context) => const HolidayHomesDesktop(),
      watch: (BuildContext context) => Container(color: Colors.white),
    );
  }
}

class HolidayHomesMobile extends StatelessWidget {
  const HolidayHomesMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(),
              Text(
                "Holiday Homes",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/holiday_homes",
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
                label: const Text(
                  "See All",
                  style: TextStyle(color: Colors.pink),
                ),
              )
            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("posts")
                .where("ownerId", isEqualTo: "DUxn3LLKj4e0QF9aijMOwpf9Qlr1")
                .orderBy("timestamp", descending: true)
                .limit(6)
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

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(posts.length, (index) {
                    Post post = posts[index];

                    return PostWidget(
                      post: post,
                    );
                  }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class HolidayHomesTablet extends StatelessWidget {
  const HolidayHomesTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(),
              Text(
                "Holiday Homes",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/holiday_homes",
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
                label: const Text(
                  "See All",
                  style: TextStyle(color: Colors.pink),
                ),
              )
            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("posts")
                .where("ownerId", isEqualTo: "DUxn3LLKj4e0QF9aijMOwpf9Qlr1")
                .orderBy("timestamp", descending: true)
                .limit(8)
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

                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2 / 3,
                  children: List.generate(posts.length, (index) {
                    Post post = posts[index];

                    return PostWidget(
                      post: post,
                    );
                  }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class HolidayHomesDesktop extends StatelessWidget {
  const HolidayHomesDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 1000.0,
        minWidth: 450.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(),
              Text(
                "Holiday Homes",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/holiday_homes",
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
                label: const Text(
                  "See All",
                  style: TextStyle(color: Colors.pink),
                ),
              )
            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("posts")
                .where("ownerId", isEqualTo: "DUxn3LLKj4e0QF9aijMOwpf9Qlr1")
                .orderBy("timestamp", descending: true)
                .limit(9)
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

                return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2 / 3,
                  children: List.generate(posts.length, (index) {
                    Post post = posts[index];

                    return PostWidget(
                      post: post,
                    );
                  }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
