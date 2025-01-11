import 'package:dio/dio.dart';
import 'package:event_app/utils/api.dart';

class EventServices {
  final Dio _dio = Dio();

  login({required String email, password}) async {
    try {
      var response = await _dio.post(Api.login, data: {
        "Email": email,
        "Password": password,
      });
      print('|||||||||||| response of login ||||||||||||||||');
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('caught error ${e.toString()}');
    }
  }

  signUp(
      {required String name,
      required String email,
      required String password,
      required int speciality,
      required int country,
      required String mobile,
      required String instagram,
      required String tikTok,
      required bool userConsent}) async {
    try {
      print('|||||||||||||||| 2||||||||||||');
      var response = await _dio.post(Api.signUp, data: {
        "UserName": name,
        "Email": email,
        "Mobile": mobile,
        "Password": password,
        "Speciality": speciality == 1
            ? 'Speciality 1'
            : speciality == 2
                ? 'Speciality 2'
                : speciality == 3
                    ? 'Speciality 3'
                    : 'Speciality 4',
        "Country": country == 1
            ? 'UAE'
            : country == 2
                ? 'India'
                : country == 3
                    ? 'Saudi Arabia'
                    : 'Kuwait',
        "InstagramLink": instagram,
        "TikTokLink": tikTok,
        "UserConsent": userConsent.toString(),
      });
      print('|||||||||||| response of signup ||||||||||||||||');
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {}
  }

  getAgenda() async {
    try {
      var response = await _dio.post(
        Api.agenda,
        queryParameters: {"EventId": 1},
      );
      print('|||||||||||| response of agenda ||||||||||||||||');
      print(response.data);
      print(response.data['Data']['Message']);
      if (response.data['Data']['Message'] == 'Success') {
        return response.data;
      }
    } catch (e) {}
  }

  getSpeakers() async {
    try {
      var response =
          await _dio.post(Api.speakers, queryParameters: {"EventId": 1});
      print('|||||||||||| response of speakers ||||||||||||||||');
      print(response.data);
      print(response.data['Data']['Message']);
      if (response.data['Data']['Message'] == 'Success') {
        return response.data;
      }
    } catch (e) {}
  }
}
