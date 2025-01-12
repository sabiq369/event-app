import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }

  Future<void> _checkInitialConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
  }
}
