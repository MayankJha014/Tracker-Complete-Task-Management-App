// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectTaskModel {
  final String id;
  final String uid;
  final String title;
  final String sdate;
  final String edate;
  final String status;
  ProjectTaskModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.sdate,
    required this.edate,
    required this.status,
  });

  ProjectTaskModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? sdate,
    String? edate,
    String? status,
  }) {
    return ProjectTaskModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      sdate: sdate ?? this.sdate,
      edate: edate ?? this.edate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'sdate': sdate,
      'edate': edate,
      'status': status,
    };
  }

  factory ProjectTaskModel.fromMap(Map<String, dynamic> map) {
    return ProjectTaskModel(
      id: map['id'] ?? "",
      uid: map['uid'] ?? "",
      title: map['title'] ?? "",
      sdate: map['sdate'] ?? "",
      edate: map['edate'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectTaskModel.fromJson(String source) =>
      ProjectTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StepperModel(id: $id, uid: $uid, title: $title, sdate: $sdate, edate: $edate, status: $status)';
  }

  @override
  bool operator ==(covariant ProjectTaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.title == title &&
        other.sdate == sdate &&
        other.edate == edate &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        title.hashCode ^
        sdate.hashCode ^
        edate.hashCode ^
        status.hashCode;
  }
}
