import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/models/safari.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:mickeytours/widgets/safariWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Safaries extends StatelessWidget {
  const Safaries({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const SafariesMobile(),
      tablet: (BuildContext context) => const SafariesTablet(),
      desktop: (BuildContext context) => const SafariesDesktop(),
      watch: (BuildContext context) => Container(color: Colors.white),
    );
  }
}

class SafariesMobile extends StatelessWidget {
  const SafariesMobile({Key? key}) : super(key: key);

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
                "Safaries",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/safaries",
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
                .collection("safaries")
                .orderBy("timestamp", descending: true)
                .limit(3)
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

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(safaries.length, (index) {
                    Safari safari = safaries[index];

                    return SafariWidget(
                      safari: safari,
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

class SafariesTablet extends StatelessWidget {
  const SafariesTablet({Key? key}) : super(key: key);

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
                "Safaries",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/safaries",
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
                .collection("safaries")
                .orderBy("timestamp", descending: true)
                .limit(4)
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

                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2 / 3,
                  children: List.generate(safaries.length, (index) {
                    Safari safari = safaries[index];

                    return SafariWidget(
                      safari: safari,
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

class SafariesDesktop extends StatelessWidget {
  const SafariesDesktop({Key? key}) : super(key: key);

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
                "Safaries",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton.icon(
                onPressed: () {
                  CustomRoutes.router.navigateTo(
                    context,
                    "/safaries",
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
                .collection("safaries")
                .orderBy("timestamp", descending: true)
                .limit(3)
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

                return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2 / 3,
                  children: List.generate(safaries.length, (index) {
                    Safari safari = safaries[index];

                    return SafariWidget(
                      safari: safari,
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
