import 'package:event_app/agenda_page/agenda_view/agenda_view.dart';
import 'package:event_app/ask_questions/view/ask_question_view.dart';
import 'package:event_app/auth/login/view/login_view.dart';
import 'package:event_app/badge/badge_view.dart';
import 'package:event_app/home_page/home_page_controller/home_page_controller.dart';
import 'package:event_app/speakers_page/speakers_list/view/speakers_view.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.put(HomePageController());
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
    'assets/images/more.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants().appBarColor,
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Get.offAll(() => LoginView());
              },
              icon: Icon(
                Icons.logout,
              ))
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
}
