import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:mickeytours/models/carouselImage.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../models/coverPhoto.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const IntroMobile(),
      tablet: (BuildContext context) => const IntroMobile(),
      desktop: (BuildContext context) => const IntroDesktop(),
      watch: (BuildContext context) => Container(color: Colors.white),
    );
  }
}

class IntroMobile extends StatefulWidget {
  const IntroMobile({Key? key}) : super(key: key);

  @override
  State<IntroMobile> createState() => _IntroMobileState();
}

class _IntroMobileState extends State<IntroMobile> {
  CarouselController carouselController = CarouselController();
  int selectedIndex = 0;

  changeImage(List<CoverPhoto> coverPhotos) {
    if (selectedIndex < (coverPhotos.length - 1)) {
      setState(() {
        selectedIndex += 1;
      });
    } else {
      setState(() {
        selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("coverPhotos")
          .orderBy("timestamp", descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: circularProgress(),
          );
        } else {
          List<CoverPhoto> coverPhotos = [];

          snapshot.data!.docs.forEach((element) {
            CoverPhoto photo = CoverPhoto.fromDocument(element);

            coverPhotos.add(photo);
          });

          return Stack(
            children: [
              ImageFade(
                image: NetworkImage(coverPhotos[selectedIndex].imageUrl!),
                duration: const Duration(seconds: 2),
                syncDuration: const Duration(seconds: 1),
                height: size.height * 0.9,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(color: Colors.black26),
              ),
              Positioned.fill(
                child: Image.asset(
                  "assets/intro/clouds_bottom.png",
                  height: size.height * 0.7,
                  width: size.width,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 40.0, bottom: size.height * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 2.0,
                        width: size.width * 0.03,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        coverPhotos[selectedIndex].city!.toUpperCase() +
                            ", " +
                            coverPhotos[selectedIndex].country!.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .apply(color: Colors.white),
                      ),
                      Text(
                        coverPhotos[selectedIndex].name!.toUpperCase(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .apply(color: Colors.white),
                      ),
                      Text(
                        coverPhotos[selectedIndex].description!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        coverPhotos[selectedIndex].currency! +
                            " " +
                            coverPhotos[selectedIndex].cost! +
                            " / NIGHT",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 2.0,
                              width: size.width * 0.2,
                              color: Colors.white,
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  )),
                              child: Center(
                                child: Text(
                                  (selectedIndex + 1).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () => changeImage(coverPhotos),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}

class IntroDesktop extends StatefulWidget {
  const IntroDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroDesktop> createState() => _IntroDesktopState();
}

class _IntroDesktopState extends State<IntroDesktop> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("coverPhotos")
          .orderBy("timestamp", descending: true)
          .limit(4)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: circularProgress(),
          );
        } else {
          List<CoverPhoto> coverPhotos = [];

          snapshot.data!.docs.forEach((element) {
            CoverPhoto photo = CoverPhoto.fromDocument(element);

            coverPhotos.add(photo);
          });

          return Stack(
            children: [
              ImageFade(
                image: NetworkImage(coverPhotos[selectedIndex].imageUrl!),
                duration: const Duration(seconds: 2),
                syncDuration: const Duration(seconds: 1),
                height: size.height * 0.9,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(color: Colors.black26),
              ),
              Positioned.fill(
                child: Image.asset(
                  "assets/intro/clouds_bottom.png",
                  height: size.height * 0.9,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                  child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 2.0,
                            width: size.width * 0.03,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            coverPhotos[selectedIndex].city!.toUpperCase() +
                                ", " +
                                coverPhotos[selectedIndex]
                                    .country!
                                    .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(color: Colors.white),
                          ),
                          Text(
                            coverPhotos[selectedIndex].name!.toUpperCase(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .apply(color: Colors.white),
                          ),
                          Text(
                            coverPhotos[selectedIndex].description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            coverPhotos[selectedIndex].currency! +
                                " " +
                                coverPhotos[selectedIndex].cost! +
                                " / NIGHT",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .apply(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.5,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                List.generate(coverPhotos.length, (index) {
                              CoverPhoto photo = coverPhotos[index];

                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 20.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            photo.imageUrl!,
                                            height: size.height * 0.3,
                                            width: size.width * 0.1,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.black26,
                                                      Colors.transparent
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter)),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10.0,
                                          left: 5.0,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                photo.name!
                                                    .toUpperCase()
                                                    .split(" ")
                                                    .length, (index) {
                                              return Text(
                                                photo.name!
                                                    .toUpperCase()
                                                    .split(" ")[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .apply(color: Colors.white),
                                              );
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.05),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 2.0,
                                width: size.width * 0.2,
                                color: Colors.white,
                              ),
                              Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    )),
                                child: Center(
                                  child: Text(
                                    (selectedIndex + 1).toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
            ],
          );
        }
      },
    );
  }
}
