import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mickeytours/providers/scrollProvider.dart';
import 'package:mickeytours/routes.dart';
import 'package:mickeytours/widgets/contactBtn.dart';
import 'package:mickeytours/widgets/customAppBar.dart';
import 'package:mickeytours/widgets/emailUs.dart';
import 'package:mickeytours/widgets/footer.dart';
import 'package:mickeytours/widgets/holidayHomes.dart';
import 'package:mickeytours/widgets/intro.dart';
import 'package:mickeytours/widgets/ratings.dart';
import 'package:mickeytours/widgets/safaries.dart';
import 'package:mickeytours/widgets/screen2.dart';
import 'package:mickeytours/widgets/whatsappBtn.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/helpers/renderer_state.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//gsutil cors set cors.json gs://project-5-97d71.appspot.com
//Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(RobotDetector(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<ScrollProvider>(create: (_) => ScrollProvider())
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    CustomRoutes.setupRouter();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mickey Tours And Travel',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [seoRouteObserver],
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: "/",
      onGenerateRoute: CustomRoutes.router.generator,
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final ScrollController _controller = ScrollController();
  bool lastStatus = true;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_scrollListener);
    Timer(const Duration(seconds: 7), () {
      //checkDeviceToken();
    });
  }

  checkDeviceToken() async {
    // Request permission
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //Get Device Token

    await messaging
        .getToken(
      vapidKey:
          "BLFLLVQwh5lIAUkMEoWr9k8TIkXSTulwiT1Y3xKG7Z0cSZkAJH3THwShAkeY5oQsEmvjdXmStKcuaghrrrHCHOU",
    )
        .then((deviceToken) async {
      //print(deviceToken);

      await FirebaseFirestore.instance
          .collection("tokens")
          .doc("tokenList_1")
          .get()
          .then((querySnapshot) async {
        List<dynamic> tokens = [];

        //print(querySnapshot.data());

        setState(() {
          tokens = querySnapshot.get("tokens");
        });

        if (!tokens.contains(deviceToken)) {
          print("Device Token is Absent");
          tokens.add(deviceToken);

          await FirebaseFirestore.instance
              .collection("tokens")
              .doc("tokenList_1")
              .update({
            "timestamp": DateTime.now().millisecondsSinceEpoch,
            "count": tokens.length,
            "tokens": tokens,
          });
        } else {
          print("Device Token is Present");
        }
      });
    });
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _controller.hasClients &&
        _controller.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: const WhatsappButton(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50.0),
        child: CustomAppBar(
          isShrink: isShrink,
        ),
      ),
      body: RawScrollbar(
        controller: _controller,
        isAlwaysShown: true,
        radius: const Radius.circular(6.0),
        thumbColor: Colors.pink,
        thickness: 12.0,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Intro(),
              Screen2(),
              const Safaries(),
              const HolidayHomes(),
              // // const EmailUs(),
              const Ratings(),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
