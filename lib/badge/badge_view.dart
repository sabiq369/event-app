import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/global_variables.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class BadgeView extends StatelessWidget {
  BadgeView({super.key});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (connectivityService.isConnected.value) {
          return Scaffold(
            key: scaffoldKey,
            endDrawer: openDrawer(),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    commonAppBar(scaffoldKey: scaffoldKey),
                    SizedBox(height: 70),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(0, 3), // Changes the shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: userQrCode!,
                              height: 300,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: LoadingIndicator(
                                  indicatorType: Indicator.lineScale,
                                  colors: [ColorConstants().loadingColor],
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              userQrCode == ''
                                  ? 'Oops! Something went wrong. Unable to display the QR code.'
                                  : 'SCAN THIS QR CODE FOR ATTENDANCE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants().greyTitleColor),
                            ),
                          ),
                          userName == ''
                              ? SizedBox()
                              : Align(
                                  child: Text(
                                    ''' "$userName"''',
                                    style: TextStyle(
                                        color:
                                            ColorConstants().toggleButtonColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                          SizedBox(height: 20)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return NoInternetPage();
        }
      },
    );
  }
}
