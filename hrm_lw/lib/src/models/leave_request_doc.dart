import 'dart:convert';

LeaveRequestDoc leaveRequestDocFromJson(String str) =>
    LeaveRequestDoc.fromJson(json.decode(str));

String leaveRequestDocToJson(LeaveRequestDoc data) =>
    json.encode(data.toJson());

class LeaveRequestDoc {
  LeaveRequestDoc({
    this.fileName,
    this.imageFile,
  });

  String fileName;
  String imageFile;

  factory LeaveRequestDoc.fromJson(Map<String, dynamic> json) =>
      LeaveRequestDoc(
        fileName: json["fileName"],
        imageFile: json["imageFile"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "imageFile": imageFile,
      };
}
