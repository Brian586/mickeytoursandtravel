import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mickeytours/models/social.dart';
import 'package:mickeytours/widgets/customButton.dart';
import 'package:mickeytours/widgets/customTextField.dart';

class EmailUs extends StatefulWidget {
  const EmailUs({Key? key}) : super(key: key);

  @override
  State<EmailUs> createState() => _EmailUsState();
}

class _EmailUsState extends State<EmailUs> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset("assets/icons/travel_icons.png",
            height: size.height * 0.7, width: size.width, fit: BoxFit.contain),
        // Positioned.fill(
        //   child: Container(
        //     height: size.height * 0.7,
        //     width: size.width,
        //     color: Colors.black12,
        //   ),
        // ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "CONTACT US",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .apply(color: Colors.pink),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "e-mail Us",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Text(
                        "Send us an email or contact us through our social media handles",
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(socials.length, (index) {
                          Social social = socials[index];

                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(
                                social.icon!,
                                height: 20.0,
                                width: 20.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05, vertical: 20.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.pink.shade50,
                          border: Border.all(
                            color: Colors.pink,
                            width: 1.0,
                          )
                          // image: const DecorationImage(
                          //     image: AssetImage("assets/carousel/14.jpg"),
                          //     fit: BoxFit.cover)
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "EMAIL US",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .apply(color: Colors.pink),
                                    ),
                                    CustomTextField(
                                      controller: name,
                                      hintText: "Name",
                                      title: "Name: ",
                                      inputType: TextInputType.name,
                                    ),
                                    CustomTextField(
                                      controller: email,
                                      hintText: "Email",
                                      title: "Email: ",
                                      inputType: TextInputType.emailAddress,
                                    ),
                                    CustomTextField(
                                      controller: description,
                                      hintText: "Type Something...",
                                      title: "Type Something here:",
                                      inputType: TextInputType.text,
                                    ),
                                  ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  title: "Send Email",
                                  color: Colors.red,
                                  onTap: () {
                                    if (name.text.isNotEmpty &&
                                        email.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      Timer(const Duration(seconds: 3), () {
                                        Fluttertoast.showToast(
                                            msg: "Email Sent Successfully!");

                                        setState(() {
                                          name.clear();
                                          email.clear();
                                          description.clear();
                                        });
                                      });
                                    }
                                  },
                                ),
                                const SizedBox()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
