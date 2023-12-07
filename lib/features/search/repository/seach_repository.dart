import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/core/contants/firebase_conatants.dart';
import 'package:tracker/core/firebase_provider.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/model/user_model.dart';

final searchRepositoryProvider = Provider(
  (ref) => SearchRepository(
    ref: ref,
    firestore: ref.watch(firestoreProvider),
  ),
);

class SearchRepository {
  final Ref _ref;
  final FirebaseFirestore _firestore;

  SearchRepository({required Ref ref, required FirebaseFirestore firestore})
      : _ref = ref,
        _firestore = firestore;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.userCollection);

  Stream<List<UserModel>> searchUser(String query) {
    final userData = _ref.read(userProvider)!;
    return _user
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        // if (userData.uid == user['uid']) {
        //   continue;
        // }
        users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
      }
      return users;
    });
  }
}
