import 'package:fluro/fluro.dart';
import 'package:mickeytours/main.dart';
import 'package:mickeytours/pages/categoriesListing.dart';
import 'package:mickeytours/pages/holidayHomesListing.dart';
import 'package:mickeytours/pages/postDetails.dart';
import 'package:mickeytours/pages/safariDetails.dart';
import 'package:mickeytours/pages/safariesListing.dart';

class CustomRoutes {
  static final FluroRouter router = FluroRouter();

  static Handler homeHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return const LandingPage();
  });

  static Handler safariesHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return const SafariesListing();
  });

  static Handler holidayHomesHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return const HolidayHomesListing();
  });

  static Handler holidayHomeDetailsHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return PostDetails(
      postID: params["id"][0],
    );
  });

  static Handler safariDetailsHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return SafariDetails(
      safariID: params["id"][0],
    );
  });

  static Handler categoriesHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return CategoriesListing(
      category: params["id"][0],
    );
  });

  static void setupRouter() {
    router.define("/", handler: homeHandler);

    router.define("/safaries",
        handler: safariesHandler, transitionType: TransitionType.fadeIn);

    router.define("/holiday_homes",
        handler: holidayHomesHandler, transitionType: TransitionType.fadeIn);

    router.define("/holiday_homes/:id",
        handler: holidayHomeDetailsHandler,
        transitionType: TransitionType.fadeIn);

    router.define("/safaries/:id",
        handler: safariDetailsHandler, transitionType: TransitionType.fadeIn);

    router.define("/categories/:id",
        handler: categoriesHandler, transitionType: TransitionType.fadeIn);
  }
}
