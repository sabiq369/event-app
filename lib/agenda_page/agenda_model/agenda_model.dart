// To parse this JSON data, do
//
//     final agendaModel = agendaModelFromJson(jsonString);

import 'dart:convert';

AgendaModel agendaModelFromJson(String str) =>
    AgendaModel.fromJson(json.decode(str));

String agendaModelToJson(AgendaModel data) => json.encode(data.toJson());

class AgendaModel {
  final dynamic contentEncoding;
  final dynamic contentType;
  final Data? data;
  final int jsonRequestBehavior;
  final dynamic maxJsonLength;
  final dynamic recursionLimit;

  AgendaModel({
    required this.contentEncoding,
    required this.contentType,
    required this.data,
    required this.jsonRequestBehavior,
    required this.maxJsonLength,
    required this.recursionLimit,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        contentEncoding: json["ContentEncoding"],
        contentType: json["ContentType"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        jsonRequestBehavior: json["JsonRequestBehavior"],
        maxJsonLength: json["MaxJsonLength"],
        recursionLimit: json["RecursionLimit"],
      );

  Map<String, dynamic> toJson() => {
        "ContentEncoding": contentEncoding,
        "ContentType": contentType,
        "Data": data!.toJson(),
        "JsonRequestBehavior": jsonRequestBehavior,
        "MaxJsonLength": maxJsonLength,
        "RecursionLimit": recursionLimit,
      };
}

class Data {
  final List<Result> result;
  final String message;

  Data({
    required this.result,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["Result"] == null
            ? []
            : List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
        message: json["Message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Result": List<dynamic>.from(result.map((x) => x.toJson())),
        "Message": message,
      };
}

class Result {
  final int id;
  final int eventid;
  final String title;
  final DateTime date;
  final String time;
  final dynamic starttime;
  final dynamic endtime;
  final String topic;
  final String speakerName;
  final String day;
  final String specialcell;
  final String injection;

  Result({
    required this.id,
    required this.eventid,
    required this.title,
    required this.date,
    required this.time,
    required this.starttime,
    required this.endtime,
    required this.topic,
    required this.speakerName,
    required this.day,
    required this.specialcell,
    required this.injection,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] ?? 0,
        eventid: json["Eventid"] ?? 0,
        title: json["Title"] ?? 'N/A',
        date: DateTime.parse(json["date"]),
        time: json["time"] ?? 'N/A',
        starttime: json["Starttime"] ?? '',
        endtime: json["Endtime"] ?? '',
        topic: json["topic"] ?? 'N/A',
        speakerName: json["speaker_name"] ?? '',
        day: json["day"] ?? '',
        specialcell: json["specialcell"] ?? '',
        injection: json["injection"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Eventid": eventid,
        "Title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "Starttime": starttime,
        "Endtime": endtime,
        "topic": topic,
        "speaker_name": speakerName,
        "day": day,
        "specialcell": specialcell,
        "injection": injection,
      };
}

// enum Specialcell {
//   EMPTY,
//   FREE_AFTERNOON
// }
//
// final specialcellValues = EnumValues({
//   "": Specialcell.EMPTY,
//   "Free afternoon": Specialcell.FREE_AFTERNOON
// });
//
// enum Title {
//   SATURDAY_20_TH_APRIL_2024,
//   SATURDAY_20_TH_APRIL_2025,
//   SUNDAY_21_ST_APRIL_2024,
//   TITLE_SUNDAY_21_ST_APRIL_2024
// }

// final titleValues = EnumValues({
//   "SATURDAY 20TH APRIL 2024": Title.SATURDAY_20_TH_APRIL_2024,
//   "SATURDAY 20TH APRIL 2025": Title.SATURDAY_20_TH_APRIL_2025,
//   "SUNDAY 21ST APRIL 2024": Title.SUNDAY_21_ST_APRIL_2024,
//   "\tSUNDAY 21ST APRIL 2024": Title.TITLE_SUNDAY_21_ST_APRIL_2024
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
