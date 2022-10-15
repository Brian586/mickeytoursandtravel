import 'package:flutter/material.dart';
import 'package:mickeytours/models/post.dart';
import 'package:mickeytours/pages/postDetails.dart';
import 'package:mickeytours/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';

class PostWidget extends StatefulWidget {
  final Post? post;
  const PostWidget({Key? key, this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isMobile;

        return isMobile
            ? PostWidgetMobile(
                post: widget.post,
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
                                alt: widget.post!.name!,
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/blank_image.png",
                                  image: widget.post!.imageUrl!,
                                  width: size.width,
                                  height: size.height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5.0,
                              right: 5.0,
                              child: RaisedButton(
                                color: Colors.pink,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Text(
                                  widget.post!.type!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  CustomRoutes.router.navigateTo(context,
                                      "/categories/${widget.post!.type!}");
                                },
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
                                    widget.post!.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    "${widget.post!.city}, ${widget.post!.country}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              Text(
                                widget.post!.description!,
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
                                        "${widget.post!.currency} ${widget.post!.price}",
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
                                            "/holiday_homes/${widget.post!.postId}",
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

class PostWidgetMobile extends StatefulWidget {
  final Post? post;
  const PostWidgetMobile({Key? key, this.post}) : super(key: key);

  @override
  State<PostWidgetMobile> createState() => _PostWidgetMobileState();
}

class _PostWidgetMobileState extends State<PostWidgetMobile> {
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
                  child: ImageRenderer(
                    src: widget.post!.imageUrl!,
                    alt: widget.post!.name!,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/blank_image.png",
                      image: widget.post!.imageUrl!,
                      width: size.width,
                      height: size.height * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: RaisedButton(
                    color: Colors.pink,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      widget.post!.type!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      CustomRoutes.router.navigateTo(
                          context, "/categories/${widget.post!.type!}");
                    },
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
                        widget.post!.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.0),
                      ),
                      Text(
                        "${widget.post!.city}, ${widget.post!.country}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      widget.post!.description!,
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
                            "${widget.post!.currency} ${widget.post!.price}",
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
                                "/holiday_homes/${widget.post!.postId}",
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
