// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tracker/model/stepper_model.dart';

class ProjectModel {
  final String id;
  final String adminId;
  final String projectName;
  final String category;
  final String startDate;
  final String endDate;
  final List<String>? team;
  final List<StepperModel>? stepper;
  final String status;
  ProjectModel({
    required this.id,
    required this.adminId,
    required this.projectName,
    required this.category,
    required this.startDate,
    required this.endDate,
    this.team,
    this.stepper,
    required this.status,
  });

  ProjectModel copyWith({
    String? id,
    String? adminId,
    String? projectName,
    String? category,
    String? startDate,
    String? endDate,
    List<String>? team,
    List<StepperModel>? stepper,
    String? status,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      adminId: adminId ?? this.adminId,
      projectName: projectName ?? this.projectName,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      team: team ?? this.team,
      stepper: stepper ?? this.stepper,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'adminId': adminId,
      'projectName': projectName,
      'category': category,
      'startDate': startDate,
      'endDate': endDate,
      'team': team,
      'stepper': stepper!.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] ?? "",
      adminId: map['adminId'] ?? "",
      projectName: map['projectName'] ?? "",
      category: map['category'] ?? "",
      startDate: map['startDate'] ?? "",
      endDate: map['endDate'] ?? "",
      team: map['team'] != null ? List<String>.from((map['team'] ?? [])) : [],
      stepper: map['stepper'] != null
          ? List<StepperModel>.from(
              (map['stepper'] ?? []).map<StepperModel?>(
                (x) => StepperModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(id: $id, adminId: $adminId, projectName: $projectName, category: $category, startDate: $startDate, endDate: $endDate, team: $team, stepper: $stepper, status: $status)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.adminId == adminId &&
        other.projectName == projectName &&
        other.category == category &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        listEquals(other.team, team) &&
        listEquals(other.stepper, stepper) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        adminId.hashCode ^
        projectName.hashCode ^
        category.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        team.hashCode ^
        stepper.hashCode ^
        status.hashCode;
  }
}
