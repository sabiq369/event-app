import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SpeakerIndividualPage extends StatelessWidget {
  const SpeakerIndividualPage(
      {super.key,
      required this.name,
      required this.image,
      required this.speakerDesignation});
  final String image;
  final String speakerDesignation;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            commonAppBar(showDrawer: false),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
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
                      imageUrl: image,
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/place_holder.png',
                            width: 55, height: 55),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScale,
                          colors: [ColorConstants().loadingColor],
                        ),
                      ),
                    ),
                  ),
                  Html(data: speakerDesignation),
                  Text(
                    name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
