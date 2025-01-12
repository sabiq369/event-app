import 'package:event_app/agenda_page/agenda_controller/agenta_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AgendaView extends StatelessWidget {
  AgendaView({super.key});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (connectivityService.isConnected.value) {
          final AgendaController agendaController = Get.put(AgendaController());
          return Scaffold(
            key: globalScaffoldKey,
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
                    commonAppBar(title: 'AGENDA'),
                    apiData(context, agendaController),
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

  apiData(BuildContext context, AgendaController agendaController) {
    return Expanded(
      child: Obx(() {
        return agendaController.isLoading.value
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScale,
                    colors: [ColorConstants().loadingColor],
                  ),
                ),
              )
            : agendaController.agendaModel!.data!.result.isEmpty
                ? noDataFound()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  agendaController.changeColor(whichButton: 1),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      agendaController.button1.value
                                          ? ColorConstants().toggleButtonColor
                                          : Colors.white),
                              child: Text(
                                'DAY 1 - SATURDAY\nAPRIL 20, 2024',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: agendaController.button1.value
                                        ? Colors.white
                                        : ColorConstants().toggleButtonColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  agendaController.changeColor(whichButton: 2),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      agendaController.button2.value
                                          ? ColorConstants().toggleButtonColor
                                          : Colors.white),
                              child: Text(
                                'DAY 1 - SATURDAY\nAPRIL 20, 2024',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: agendaController.button2.value
                                        ? Colors.white
                                        : ColorConstants().toggleButtonColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: ColorConstants().greyTitleColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: title(title: 'Time'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 170),
                                child: title(title: 'Details'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: agendaController
                                .agendaModel!.data!.result.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                color: ColorConstants().contBgColor,
                                child: Column(
                                  children: [
                                    Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(150),
                                        1: FlexColumnWidth()
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: agendaController
                                                          .agendaModel!
                                                          .data!
                                                          .result[index]
                                                          .time ==
                                                      ''
                                                  ? SizedBox()
                                                  : Text(
                                                      agendaController
                                                          .agendaModel!
                                                          .data!
                                                          .result[index]
                                                          .time,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  agendaController
                                                              .agendaModel!
                                                              .data!
                                                              .result[index]
                                                              .topic ==
                                                          ''
                                                      ? SizedBox()
                                                      : Text(
                                                          agendaController
                                                              .agendaModel!
                                                              .data!
                                                              .result[index]
                                                              .topic,
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                  agendaController
                                                              .agendaModel!
                                                              .data!
                                                              .result[index]
                                                              .speakerName ==
                                                          ''
                                                      ? SizedBox()
                                                      : Text(
                                                          agendaController
                                                              .agendaModel!
                                                              .data!
                                                              .result[index]
                                                              .speakerName,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    if (index !=
                                        agendaController.agendaModel!.data!
                                                .result.length -
                                            1)
                                      Divider(
                                        color: ColorConstants().dividerColor,
                                        thickness: 2,
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
      }),
    );
  }

  title({required String title}) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }
}
