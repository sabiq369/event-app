import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/speakers_page/speakers_individual_page/speaker_individual_page.dart';
import 'package:event_app/speakers_page/speakers_list/controller/speakers_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SpeakersView extends StatelessWidget {
  SpeakersView({super.key});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (connectivityService.isConnected.value) {
          final SpeakersController speakersController =
              Get.put(SpeakersController());
          return Scaffold(
            key: globalScaffoldKey,
            endDrawer: openDrawer(),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    commonAppBar(title: 'SPEAKERS'),
                    Expanded(
                      child: Obx(
                        () {
                          return speakersController.isLoading.value
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 150),
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.lineScale,
                                      colors: [ColorConstants().loadingColor],
                                    ),
                                  ),
                                )
                              : speakersController
                                      .speakersModel!.data.result.isEmpty
                                  ? noDataFound()
                                  : ListView.builder(
                                      itemCount: speakersController
                                          .speakersModel!.data.result.length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 20),
                                      itemBuilder: (context, index) {
                                        var speaker = speakersController
                                            .speakersModel!.data.result[index];
                                        return ListTile(
                                          onTap: () => Get.to(() =>
                                              SpeakerIndividualPage(
                                                  name: speaker.speakerName,
                                                  image: speaker.speakerImage,
                                                  speakerDesignation: speaker
                                                      .speakerDesignation)),
                                          leading: SizedBox(
                                            width: 55,
                                            height: 55,
                                            child: CachedNetworkImage(
                                              imageUrl: speaker.speakerImage,
                                              placeholder: (context, url) =>
                                                  ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: shimmer(
                                                    width: 55,
                                                    height: 55,
                                                    radius: 100),
                                              ), // Placeholder widget
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(
                                                    'assets/images/place_holder.png',
                                                    width: 55,
                                                    height: 55),
                                              ),
                                              width: 50,
                                              height: 50, // Error widget
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                speaker.speakerName,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Transform(
                                                transform:
                                                    Matrix4.translationValues(
                                                        -5, 0, 0),
                                                child: Html(
                                                    data: speaker
                                                        .speakerDesignation),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                        },
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
