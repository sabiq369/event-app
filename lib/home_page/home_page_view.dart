import 'package:event_app/agenda_page/agenda_view/agenda_view.dart';
import 'package:event_app/ask_questions/view/ask_question_view.dart';
import 'package:event_app/badge/badge_view.dart';
import 'package:event_app/speakers_page/speakers_list/view/speakers_view.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  HomePageView({super.key});
  final List<Color> colors = [
    ColorConstants().color1,
    ColorConstants().color2,
    ColorConstants().color3,
  ];

  final List<String> items = [
    'assets/images/agenda.png',
    'assets/images/speakers.png',
    'assets/images/badge.png',
    'assets/images/venue.png',
    'assets/images/images.png',
    'assets/images/videos.png',
    'assets/images/questions.png',
    'assets/images/voting.png',
    'assets/images/social.png',
    'assets/images/survey.png',
    'assets/images/cme.png',
    'assets/images/more.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants().appBarColor,
        actions: [
          IconButton(
              onPressed: () => showLogOutDialog(), icon: Icon(Icons.logout)),
          SizedBox(width: 5)
        ],
      ),
      drawer: openDrawer(),
      body: GridView.builder(
        padding: EdgeInsets.all(22.5),
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Get.to(() => AgendaView());
              } else if (index == 1) {
                Get.to(() => SpeakersView());
              } else if (index == 2) {
                Get.to(() => BadgeView());
              } else if (index == 6) {
                Get.to(() => AskQuestionView());
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: Image.asset(
                items[index],
                // fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }

  showLogOutDialog() async {
    Get.defaultDialog(
      title: 'Log Out',
      titleStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
      ),
      middleText: "Are you sure you want to log out?",
      middleTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      backgroundColor: Colors.white,
      radius: 10,
      barrierDismissible: false,
      content: Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 50,
            color: Colors.redAccent,
          ),
          SizedBox(height: 10),
          Text(
            "This action will log you out of your account.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      confirm: ElevatedButton.icon(
        onPressed: () async {
          await clearPrefs(msg: '');
          getSnackBar(
              title: "Logged Out",
              desc: "You have successfully logged out.",
              success: true,
              icon: Icons.logout);
        },
        icon: Icon(
          Icons.logout,
          size: 18,
          color: Colors.white,
        ),
        label: Text(
          "Log Out",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
        ),
        child: Text("Cancel"),
      ),
    );
  }
}
