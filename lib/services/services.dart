import 'package:dio/dio.dart';
import 'package:event_app/utils/api.dart';
import 'package:event_app/utils/common_fuctions.dart';

class EventServices {
  final Dio _dio = Dio();

  login({required String email, password}) async {
    try {
      var response = await _dio.post(
        Api.login,
        data: {
          "Email": email,
          "Password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      clearPrefs(msg: e.toString());
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
      var response = await _dio.post(
        Api.signUp,
        data: {
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
                  ? 'KSA'
                  : country == 3
                      ? 'EGYPT'
                      : country == 4
                          ? 'SPAIN'
                          : country == 5
                              ? 'UK'
                              : 'USA',
          "InstagramLink": instagram,
          "TikTokLink": tikTok,
          "UserConsent": userConsent.toString(),
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      clearPrefs(msg: e.toString());
    }
  }

  getAgenda() async {
    try {
      var response = await _dio.post(
        Api.agenda,
        queryParameters: {"EventId": 1},
      );
      if (response.data['Data']['Message'] == 'Success') {
        return response.data;
      }
    } catch (e) {
      clearPrefs(msg: e.toString());
    }
  }

  getSpeakers() async {
    try {
      var response =
          await _dio.post(Api.speakers, queryParameters: {"EventId": 1});
      if (response.data['Data']['Message'] == 'Success') {
        return response.data;
      }
    } catch (e) {
      clearPrefs(msg: e.toString());
    }
  }

  askQuestion(
      {required String speakerName,
      required String askedBy,
      required String question,
      required int eventId}) async {
    try {
      var response = await _dio.post(
        Api.askQuestion,
        data: {
          "SpeakerName": speakerName,
          "AskedBy": askedBy,
          "QuestionDetail": question,
          "EventId": eventId
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      clearPrefs(msg: e.toString());
    }
  }
}
