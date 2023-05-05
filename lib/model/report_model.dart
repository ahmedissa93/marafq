import 'dart:convert';

class ReportModel {
  int id;
  String service;
  // String room_id;
  String status;
  String report_number;
  String date;

  // String description;
  // String user_name;
  int reporter_by;
  // String maintenance_user_id;
  // String location;

  ReportModel({
    required this.id,
    required this.service,
    required this.status,
    required this.reporter_by,
    required this.report_number,
    required this.date,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json["id"],
      service: json["service"],
      status: json["status"],
      reporter_by: json["reporter_by"],
      report_number: json["report_number"],
      date: json["date"],
    );
  }
}
