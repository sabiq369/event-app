import 'package:event_app/services/services.dart';
import 'package:event_app/speakers_page/speakers_list/model/speakers_model.dart';
import 'package:get/get.dart';

class SpeakersController extends GetxController {
  SpeakersModel? speakersModel;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    apiCall();
  }

  void apiCall() async {
    isLoading.value = true;
    var data = await EventServices().getSpeakers();
    if (data != null) {
      speakersModel = SpeakersModel.fromJson(data);
      isLoading.value = false;
    }
  }
}
