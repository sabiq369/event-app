// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String message;
  final dynamic eventid;
  final bool status;
  final int id;
  final String useruniqueid;
  final String qrCode;
  final String doctorName;
  final String email;
  final List<EventId> eventIds;

  LoginModel({
    required this.message,
    required this.eventid,
    required this.status,
    required this.id,
    required this.useruniqueid,
    required this.qrCode,
    required this.doctorName,
    required this.email,
    required this.eventIds,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["Message"] ?? '',
        eventid: json["eventid"] ?? 0,
        status: json["Status"] ?? false,
        id: json["id"] ?? 0,
        useruniqueid: json["Useruniqueid"] ?? '',
        qrCode: json["QrCode"] ?? '',
        doctorName: json["DoctorName"] ?? '',
        email: json["Email"] ?? '',
        eventIds: json["EventIds"] == null
            ? []
            : List<EventId>.from(
                json["EventIds"].map((x) => EventId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "eventid": eventid,
        "Status": status,
        "id": id,
        "Useruniqueid": useruniqueid,
        "QrCode": qrCode,
        "DoctorName": doctorName,
        "Email": email,
        "EventIds": List<dynamic>.from(eventIds.map((x) => x.toJson())),
      };
}

class EventId {
  final int id;
  final int userId;
  final int eventId;
  final bool isActive;
  final dynamic dateTime;

  EventId({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.isActive,
    required this.dateTime,
  });

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
        id: json["Id"] ?? 0,
        userId: json["UserId"] ?? 0,
        eventId: json["EventId"] ?? 0,
        isActive: json["IsActive"] ?? false,
        dateTime: json["DateTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "EventId": eventId,
        "IsActive": isActive,
        "DateTime": dateTime,
      };
}
