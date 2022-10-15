import 'package:flutter/material.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/contactBtn.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isShrink;

  const CustomAppBar({Key? key, this.isShrink}) : super(key: key);

  choiceAction(BuildContext context, String choice) {
    switch (choice) {
      case "HOME":
        CustomRoutes.router.navigateTo(context, "/");
        break;
      case "HOLIDAY HOMES":
        CustomRoutes.router.navigateTo(context, "/holiday_homes");
        break;
      case "SAFARIES":
        CustomRoutes.router.navigateTo(context, "/safaries");
        break;
      case "CONTACT US":
        launch("tel:+254702846342");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile =
            sizingInformation.isMobile || sizingInformation.isTablet;

        return AnimatedContainer(
          duration: const Duration(seconds: 2),
          decoration: BoxDecoration(
              color: isShrink! ? Colors.pink.shade50 : Colors.transparent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => CustomRoutes.router.navigateTo(context, "/"),
                  child: TextRenderer(
                    style: TextRendererStyle.header6,
                    child: Text(
                      "MICKEY TOURS AND TRAVEL",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .apply(color: isShrink! ? Colors.pink : Colors.white),
                    ),
                  ),
                ),
                isMobile
                    ? PopupMenuButton<String>(
                        icon: Icon(
                          Icons.menu,
                          color: isShrink! ? Colors.pink : Colors.white,
                          //size: 25.0,
                        ),
                        offset: const Offset(0.0, 10.0),
                        onSelected: (v) {
                          choiceAction(context, v);
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            "HOME",
                            "SAFARIES",
                            "HOLIDAY HOMES",
                            "CONTACT US"
                          ].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  CustomRoutes.router.navigateTo(context, "/"),
                              child: Text(
                                "HOME",
                                style: TextStyle(
                                    color:
                                        isShrink! ? Colors.pink : Colors.white),
                              )),
                          TextButton(
                              onPressed: () => CustomRoutes.router
                                  .navigateTo(context, "/safaries"),
                              child: Text(
                                "SAFARIES",
                                style: TextStyle(
                                    color:
                                        isShrink! ? Colors.pink : Colors.white),
                              )),
                          TextButton(
                              onPressed: () => CustomRoutes.router
                                  .navigateTo(context, "/holiday_homes"),
                              child: Text(
                                "HOLIDAY HOMES",
                                style: TextStyle(
                                    color:
                                        isShrink! ? Colors.pink : Colors.white),
                              )),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       "ABOUT",
                          //       style: TextStyle(
                          //           color:
                          //               isShrink! ? Colors.pink : Colors.white),
                          //     )),
                          ContactButton(
                            color: isShrink! ? Colors.pink : Colors.white,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
