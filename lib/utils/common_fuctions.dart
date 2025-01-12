import 'package:event_app/agenda_page/agenda_view/agenda_view.dart';
import 'package:event_app/ask_questions/view/ask_question_view.dart';
import 'package:event_app/auth/login/view/login_view.dart';
import 'package:event_app/badge/badge_view.dart';
import 'package:event_app/home_page/home_page_view.dart';
import 'package:event_app/speakers_page/speakers_list/view/speakers_view.dart';
import 'package:event_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

buttonTextStyle() {
  return TextStyle(color: ColorConstants().textButtonColor, fontSize: 15);
}

toastMessage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

commonAppBar({String title = '', showDrawer = true}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          TextButton.icon(
            onPressed: () => Get.back(),
            label: Text(
              'Back',
              style: TextStyle(color: ColorConstants().backColor, fontSize: 18),
            ),
            icon: Icon(CupertinoIcons.back,
                color: ColorConstants().backColor, size: 26),
          ),
          Spacer(),
          if (showDrawer)
            IconButton(
              onPressed: () {
                globalScaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(CupertinoIcons.line_horizontal_3,
                  color: ColorConstants().backColor, size: 26),
            ),
          SizedBox(width: 15),
        ],
      ),
      Divider(),
      Image.asset('assets/images/riyadh-loreal.png'),
      SizedBox(height: 15),
      Text(
        title,
        style: TextStyle(
            fontSize: 20,
            color: ColorConstants().darkBlueColor,
            fontWeight: FontWeight.w600),
      ),
      if (title != '')
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5),
          child: Divider(),
        ),
    ],
  );
}

openDrawer() {
  return Drawer(
    backgroundColor: Colors.white,
    child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          drawerListTile(
            icon: CupertinoIcons.home,
            title: 'Home',
            onTap: () => Get.offAll(() => HomePageView()),
          ),
          drawerListTile(
            icon: CupertinoIcons.calendar,
            title: 'Agenda',
            onTap: () {
              Get.back();
              Get.to(() => AgendaView());
            },
          ),
          drawerListTile(
            icon: CupertinoIcons.person,
            title: 'Speakers',
            onTap: () {
              Get.back();
              Get.to(() => SpeakersView());
            },
          ),
          drawerListTile(
            icon: CupertinoIcons.qrcode,
            title: 'Badge',
            onTap: () {
              Get.back();
              Get.to(() => BadgeView());
            },
          ),
          drawerListTile(icon: Icons.map_outlined, title: 'Venue'),
          drawerListTile(
              icon: Icons.perm_media_outlined, title: 'Brand Innovation'),
          drawerListTile(
            icon: Icons.question_mark,
            title: 'Ask Question',
            onTap: () {
              Get.back();
              Get.to(() => AskQuestionView());
            },
          ),
          drawerListTile(icon: Icons.bar_chart_outlined, title: 'Voting'),
          drawerListTile(icon: Icons.public, title: 'Social Media'),
          drawerListTile(icon: Icons.checklist_outlined, title: 'Survey'),
          drawerListTile(icon: Icons.school_outlined, title: 'CME'),
        ],
      ),
    ),
  );
}

drawerListTile(
    {required IconData icon, required String title, void Function()? onTap}) {
  return ListTile(
    onTap: onTap,
    contentPadding: EdgeInsets.only(left: 25),
    leading: Icon(icon),
    title: Text(title),
  );
}

shimmer(
    {required double width, required double height, required double radius}) {
  return Shimmer.fromColors(
      baseColor: ColorConstants.shimmerBase,
      highlightColor: ColorConstants.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: ColorConstants.shimmerBase,
            borderRadius: BorderRadius.circular(radius)),
      ));
}

loadingButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorConstants().buttonBrightColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    child: LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple,
      colors: [Colors.white],
    ),
  );
}

getSnackBar(
    {required String title,
    required String desc,
    required IconData icon,
    bool success = false}) {
  return Get.snackbar(
    title,
    desc,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: success ? Colors.green : Colors.redAccent,
    colorText: Colors.white,
    icon: Icon(icon, color: Colors.white),
  );
}

noDataFound() {
  return Column(
    children: [
      Lottie.asset('assets/images/empty.json'),
      SizedBox(height: 10),
      Text(
        'No Data Found',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
    ],
  );
}

fixErrors(BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Please fix the errors')));
}

clearPrefs({required String msg}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  Get.offAll(() => LoginView());
  if (msg != '') toastMessage(msg: msg);
}
