import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/core/contants/utils.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/create/repository/task_repository.dart';
import 'package:tracker/model/project_model.dart';
import 'package:tracker/model/task_model.dart';
import 'package:uuid/uuid.dart';

final taskControllerProvider = StateNotifierProvider<TaskController, bool>(
  (ref) => TaskController(
    taskRepsoitory: ref.read(taskRepositoryProvider),
    ref: ref,
  ),
);

final getProjectProvider = StreamProvider.family((ref, String uid) {
  final taskController = ref.watch(taskControllerProvider.notifier);
  return taskController.getProject(uid);
});
final getTaskProvider = StreamProvider.family((ref, String uid) {
  final taskController = ref.watch(taskControllerProvider.notifier);
  return taskController.getTask(uid);
});

class TaskController extends StateNotifier<bool> {
  final TaskRepsoitory _taskRepsoitory;
  final Ref _ref;

  TaskController({required TaskRepsoitory taskRepsoitory, required Ref ref})
      : _taskRepsoitory = taskRepsoitory,
        _ref = ref,
        super(false);

  void addTask(
    final BuildContext context,
    final String title,
    final String date,
    final String startT,
    final String endT,
    final String status,
  ) async {
    String taskId = const Uuid().v1();
    final user = _ref.read(userProvider)!;
    state = true;
    final task = TaskModel(
      id: taskId,
      uid: user.uid,
      title: title,
      date: date,
      startT: startT,
      endT: endT,
      status: status,
    );
    final res = await _taskRepsoitory.addTask(task);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Task added successfully!');
      Navigator.of(context).pop();
    });
  }

  void createProject(
    final BuildContext context,
    final String projectName,
    final String category,
    final List<String> team,
    final String startDate,
    final String endDate,
    final String status,
  ) async {
    String projectId = const Uuid().v1();
    final user = _ref.read(userProvider)!;
    state = true;
    final project = ProjectModel(
      id: projectId,
      adminId: user.uid,
      projectName: projectName,
      category: category,
      startDate: startDate,
      endDate: endDate,
      status: status,
      team: team,
      stepper: [],
    );
    final res = await _taskRepsoitory.createProject(project);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Project created successfully!');
      Navigator.of(context).pop();
    });
  }

  Stream<List<ProjectModel>> getProject(String uid) {
    return _taskRepsoitory.getProject(uid);
  }

  Stream<List<TaskModel>> getTask(String uid) {
    return _taskRepsoitory.getTask(uid);
  }
}
