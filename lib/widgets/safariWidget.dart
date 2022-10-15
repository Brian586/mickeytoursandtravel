import 'package:flutter/material.dart';
import 'package:mickeytours/models/safari.dart';
import 'package:mickeytours/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';

class SafariWidget extends StatefulWidget {
  final Safari? safari;
  const SafariWidget({Key? key, this.safari}) : super(key: key);

  @override
  State<SafariWidget> createState() => _SafariWidgetState();
}

class _SafariWidgetState extends State<SafariWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isMobile;

        return isMobile
            ? SafariWidgetMobile(
                safari: widget.safari,
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                              child: ImageRenderer(
                                alt: widget.safari!.name!,
                                src: widget.safari!.imageUrl!,
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/blank_image.png",
                                  image: widget.safari!.imageUrl!,
                                  width: size.width,
                                  height: size.height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              left: 0.0,
                              child: Container(
                                height: 30.0,
                                width: size.width,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Colors.black,
                                      Colors.transparent
                                    ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.wb_sunny_outlined,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      widget.safari!.days.toString() + " DAYS",
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      widget.safari!.nights.toString() +
                                          " NIGHTS",
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    "${widget.safari!.city}, ${widget.safari!.country}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              Text(
                                widget.safari!.description!,
                                maxLines: 3,
                                style: const TextStyle(
                                    overflow: TextOverflow.fade),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 1.0,
                                    width: size.width,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${widget.safari!.currency} ${widget.safari!.cost}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0),
                                      ),
                                      RaisedButton(
                                        color: Colors.pink,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: const Text(
                                          "Book Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          CustomRoutes.router.navigateTo(
                                            context,
                                            "/safaries/${widget.safari!.safariID}",
                                          );
                                        },
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class SafariWidgetMobile extends StatefulWidget {
  final Safari? safari;
  const SafariWidgetMobile({Key? key, this.safari}) : super(key: key);

  @override
  State<SafariWidgetMobile> createState() => _SafariWidgetMobileState();
}

class _SafariWidgetMobileState extends State<SafariWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/blank_image.png",
                    image: widget.safari!.imageUrl!,
                    width: size.width,
                    height: size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 30.0,
                    width: size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white,
                          size: 14.0,
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          widget.safari!.days.toString() + " DAYS",
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.safari!.nights.toString() + " NIGHTS",
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                            fontWeight: FontWeight.w700, fontSize: 20.0),
                      ),
                      Text(
                        "${widget.safari!.city}, ${widget.safari!.country}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      widget.safari!.description!,
                      maxLines: 3,
                      style: const TextStyle(overflow: TextOverflow.fade),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 1.0,
                        width: size.width,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.safari!.currency} ${widget.safari!.cost}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18.0),
                          ),
                          RaisedButton(
                            color: Colors.pink,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: const Text(
                              "Book Now",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              CustomRoutes.router.navigateTo(
                                context,
                                "/safaries/${widget.safari!.safariID}",
                              );
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
