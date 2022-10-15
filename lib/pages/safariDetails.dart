import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/models/post.dart';
import 'package:mickeytours/models/safari.dart';
import 'package:mickeytours/pages/postDetails.dart';
import 'package:mickeytours/widgets/ProgressWidget.dart';
import 'package:mickeytours/widgets/customAppBar.dart';
import 'package:mickeytours/widgets/footer.dart';
import 'package:mickeytours/widgets/whatsappBtn.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SafariDetails extends StatefulWidget {
  final String? safariID;
  const SafariDetails({Key? key, this.safariID}) : super(key: key);

  @override
  State<SafariDetails> createState() => _SafariDetailsState();
}

class _SafariDetailsState extends State<SafariDetails> {
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("safaries")
            .doc(widget.safariID)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: circularProgress(),
            );
          } else {
            Safari safari = Safari.fromDocument(snapshot.data!);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("safaries")
                          .doc(safari.safariID)
                          .collection("images")
                          .limit(1)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return linearProgress();
                        } else {
                          List<dynamic> imageUrls =
                              snapshot.data!.docs[0]["urls"];

                          return imageUrls.length == 1
                              ? Image.network(
                                  imageUrls[0],
                                  height: size.height * 0.6,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                )
                              : CarouselDisplay(
                                  imageUrls: imageUrls,
                                );
                        }
                      },
                    ),
                    ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        bool isMobile = sizingInformation.isMobile;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 20.0 : size.width * 0.1,
                              vertical: 20.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 800.0,
                              minWidth: 300.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40.0,
                                ),
                                RaisedButton(
                                  color: Colors.pink.shade50,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: const Text(
                                    "Safaries",
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                  onPressed: () {},
                                ),
                                Text(
                                  safari.name!,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  safari.city! + ", " + safari.country!,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                    "${safari.currency} ${safari.cost} / NIGHT"),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  "Overview",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(
                                        color: Colors.pink,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 1.0,
                                          width: size.width,
                                          color: Colors.pink,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          height: 1.0,
                                          width: size.width,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(safari.description!),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                BookingForm(
                                  post: Post(
                                    postId: safari.safariID,
                                    imageUrl: safari.imageUrl,
                                    description: safari.description,
                                    name: safari.name,
                                    city: safari.city,
                                    country: safari.country,
                                    locality: "",
                                    payPeriod: "Per Night",
                                    price: safari.cost,
                                    currency: safari.currency,
                                    type: "Safari",
                                    address: "",
                                    latitude: 0.0,
                                    longitude: 0.0,
                                    username: "",
                                    phone: "",
                                    ownerUrl: "",
                                    userId: "",
                                    email: "",
                                    timestamp: safari.timestamp,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Footer(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
