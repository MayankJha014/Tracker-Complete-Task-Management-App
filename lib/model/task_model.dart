// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String id;
  final String uid;
  final String title;
  final String date;
  final String startT;
  final String endT;
  final String status;
  TaskModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.date,
    required this.startT,
    required this.endT,
    required this.status,
  });

  TaskModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? date,
    String? startT,
    String? endT,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      date: date ?? this.date,
      startT: startT ?? this.startT,
      endT: endT ?? this.endT,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'date': date,
      'startT': startT,
      'endT': endT,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? "",
      uid: map['uid'] ?? "",
      title: map['title'] ?? "",
      date: map['date'] ?? "",
      startT: map['startT'] ?? "",
      endT: map['endT'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, uid: $uid, title: $title, date: $date, startT: $startT, endT: $endT, status: $status)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.title == title &&
        other.date == date &&
        other.startT == startT &&
        other.endT == endT &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        title.hashCode ^
        date.hashCode ^
        startT.hashCode ^
        endT.hashCode ^
        status.hashCode;
  }
}
