import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class Screen2 extends StatelessWidget {
  Screen2({Key? key}) : super(key: key);

  // final List<String> images = [
  //   "assets/carousel/1.jpg",
  //   //"assets/carousel/2.jpg",
  //   "assets/carousel/3.jpg",
  //   //"assets/carousel/4.jpg",
  //   "assets/carousel/7.jpg",
  //   "assets/carousel/10.jpg",
  // ];

  final List<Screen2Image> images = [
    Screen2Image(
      image: "assets/carousel/1.jpg",
      url:
          "https://firebasestorage.googleapis.com/v0/b/project-5-97d71.appspot.com/o/SEO%2F1.jpg?alt=media&token=03b5fe97-9210-4c09-a252-2201ce96d89e",
    ),
    Screen2Image(
      image: "assets/carousel/3.jpg",
      url:
          "https://firebasestorage.googleapis.com/v0/b/project-5-97d71.appspot.com/o/SEO%2F3.jpg?alt=media&token=bd6a0717-53c8-439e-9418-b12ec1c6808d",
    ),
    Screen2Image(
      image: "assets/carousel/7.jpg",
      url:
          "https://firebasestorage.googleapis.com/v0/b/project-5-97d71.appspot.com/o/SEO%2F7.jpg?alt=media&token=fe93ae19-0b8d-4381-9b84-0b9d7c5dd999",
    ),
    Screen2Image(
      image: "assets/carousel/10.jpg",
      url:
          "https://firebasestorage.googleapis.com/v0/b/project-5-97d71.appspot.com/o/SEO%2F10.jpg?alt=media&token=e085cee0-abc2-43cb-8abf-f433c205587a",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isMobile;

        return Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000.0,
                minWidth: 450.0,
              ),
              child: Image.asset(
                "assets/icons/travel_icons.png",
                height: isMobile ? size.height * 0.6 : size.height * 0.8,
                width: size.width,
                fit: BoxFit.contain,
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextRenderer(
                    text: "Get The Best Safari Holidays \n Tours & Trips",
                    style: isMobile
                        ? TextRendererStyle.header4
                        : TextRendererStyle.header3,
                    child: Text(
                      "Get The Best Safari Holidays \n Tours & Trips",
                      textAlign: TextAlign.center,
                      style: isMobile
                          ? Theme.of(context).textTheme.headline4
                          : Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 3.0,
                    width: 50.0,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: const TextRenderer(
                      text:
                          "We offer the best of African safari tours. As a local company based in Nairobi, Kenya, we specialize in African Safari Tours and tailor-made packages. We have various safari trips from budget to luxury for solo travelers, couples, family, and all other types of travelers. We offer safari tours across Africa",
                      child: Text(
                        "We offer the best of African safari tours. As a local company based in Nairobi, Kenya, we specialize in African Safari Tours and tailor-made packages. We have various safari trips from budget to luxury for solo travelers, couples, family, and all other types of travelers. We offer safari tours across Africa",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(images.length, (index) {
                        String image = images[index].image!;

                        return Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(isMobile ? 0.0 : 10.0),
                            child: ImageRenderer(
                              alt: "Mickey Tours & Travel ${index + 1}",
                              src: images[index].url!,
                              child: Image.asset(
                                image,
                                height: size.height * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class Screen2Image {
  final String? image;
  final String? url;

  Screen2Image({this.image, this.url});
}
