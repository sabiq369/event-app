// To parse this JSON data, do
//
//     final speakersModel = speakersModelFromJson(jsonString);

import 'dart:convert';

SpeakersModel speakersModelFromJson(String str) =>
    SpeakersModel.fromJson(json.decode(str));

String speakersModelToJson(SpeakersModel data) => json.encode(data.toJson());

class SpeakersModel {
  final dynamic contentEncoding;
  final dynamic contentType;
  final Data data;
  final int jsonRequestBehavior;
  final dynamic maxJsonLength;
  final dynamic recursionLimit;

  SpeakersModel({
    required this.contentEncoding,
    required this.contentType,
    required this.data,
    required this.jsonRequestBehavior,
    required this.maxJsonLength,
    required this.recursionLimit,
  });

  factory SpeakersModel.fromJson(Map<String, dynamic> json) => SpeakersModel(
        contentEncoding: json["ContentEncoding"] ?? '',
        contentType: json["ContentType"] ?? '',
        data: Data.fromJson(json["Data"]),
        jsonRequestBehavior: json["JsonRequestBehavior"] ?? 0,
        maxJsonLength: json["MaxJsonLength"] ?? '',
        recursionLimit: json["RecursionLimit"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ContentEncoding": contentEncoding,
        "ContentType": contentType,
        "Data": data.toJson(),
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
  final int eventid;
  final int id;
  final String speakerName;
  final String speakerDesignation;
  final String speakerBio;
  final String speakerImage;
  final String speakerType;
  final dynamic imagePath;
  final int order;
  final dynamic orderId;

  Result({
    required this.eventid,
    required this.id,
    required this.speakerName,
    required this.speakerDesignation,
    required this.speakerBio,
    required this.speakerImage,
    required this.speakerType,
    required this.imagePath,
    required this.order,
    required this.orderId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        eventid: json["Eventid"] ?? 0,
        id: json["id"] ?? 0,
        speakerName: json["speaker_name"] ?? '',
        speakerDesignation: json["speaker_designation"] ?? '',
        speakerBio: json["speaker_bio"] ?? '',
        speakerImage: json["speaker_image"] ?? '',
        speakerType: json["speaker_type"] ?? '',
        imagePath: json["image_path"] ?? '',
        order: json["Order"] ?? 0,
        orderId: json["OrderId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Eventid": eventid,
        "id": id,
        "speaker_name": speakerName,
        "speaker_designation": speakerDesignation,
        "speaker_bio": speakerBio,
        "speaker_image": speakerImage,
        "speaker_type": speakerType,
        "image_path": imagePath,
        "Order": order,
        "OrderId": orderId,
      };
}
