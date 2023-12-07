import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tracker/core/common/failure.dart';
import 'package:tracker/core/contants/firebase_conatants.dart';
import 'package:tracker/core/contants/type_def.dart';
import 'package:tracker/core/firebase_provider.dart';
import 'package:tracker/model/project_model.dart';
import 'package:tracker/model/task_model.dart';

final taskRepositoryProvider = Provider(
  (ref) => TaskRepsoitory(
    firestore: ref.watch(firestoreProvider),
  ),
);

class TaskRepsoitory {
  final FirebaseFirestore _firestore;

  TaskRepsoitory({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get tasks =>
      _firestore.collection(FirebaseConstants.tasksCollection);

  CollectionReference get projects =>
      _firestore.collection(FirebaseConstants.projectCollection);

  FutureVoid addTask(TaskModel taskModel) async {
    try {
      return right(tasks.doc(taskModel.id).set(taskModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid createProject(ProjectModel projectModel) async {
    try {
      return right(projects.doc(projectModel.id).set(projectModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<ProjectModel>> getProject(String uid) {
    return projects
        .where('team', arrayContains: uid)
        .orderBy('startDate', descending: true)
        .snapshots()
        .map(
          (project) => project.docs.map((e) {
            print(e.data());
            return ProjectModel.fromMap(e.data() as Map<String, dynamic>);
          }).toList(),
        )
        .handleError((error) {
      print("Error fetching data: $error");
    });
  }

  Stream<List<TaskModel>> getTask(String uid) {
    return tasks
        .where('uid', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (task) => task.docs.map((e) {
            print(e.data());
            return TaskModel.fromMap(e.data() as Map<String, dynamic>);
          }).toList(),
        )
        .handleError((error) {
      print("Error fetching data: $error");
    });
  }
}
