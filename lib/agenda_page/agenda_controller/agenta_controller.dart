import 'package:event_app/agenda_page/agenda_model/agenda_model.dart';
import 'package:event_app/services/services.dart';
import 'package:get/get.dart';

class AgendaController extends GetxController {
  AgendaModel? agendaModel;
  RxBool isLoading = false.obs, button1 = true.obs, button2 = false.obs;
  @override
  void onInit() {
    super.onInit();
    apiCall();
  }

  void apiCall() async {
    isLoading.value = true;
    var data = await EventServices().getAgenda();
    if (data != null) {
      agendaModel = AgendaModel.fromJson(data);
      isLoading.value = false;
    }
  }

  changeColor({required int whichButton}) {
    if (whichButton == 1) {
      button2.value = false;
      button1.value = true;
    } else {
      button2.value = true;
      button1.value = false;
    }
  }
}
