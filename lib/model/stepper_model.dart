// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StepperModel {
  final String stepperId;
  final String userId;
  final String status;
  StepperModel({
    required this.stepperId,
    required this.userId,
    required this.status,
  });

  StepperModel copyWith({
    String? stepperId,
    String? userId,
    String? status,
  }) {
    return StepperModel(
      stepperId: stepperId ?? this.stepperId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stepperId': stepperId,
      'userId': userId,
      'status': status,
    };
  }

  factory StepperModel.fromMap(Map<String, dynamic> map) {
    return StepperModel(
      stepperId: map['stepperId'] ?? "",
      userId: map['userId'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory StepperModel.fromJson(String source) =>
      StepperModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StepperModel(stepperId: $stepperId, userId: $userId, status: $status)';

  @override
  bool operator ==(covariant StepperModel other) {
    if (identical(this, other)) return true;

    return other.stepperId == stepperId &&
        other.userId == userId &&
        other.status == status;
  }

  @override
  int get hashCode => stepperId.hashCode ^ userId.hashCode ^ status.hashCode;
}
