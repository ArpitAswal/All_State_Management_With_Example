import 'package:hive/hive.dart';
part 'hive_todo_model.g.dart';

@HiveType(typeId: 0)
class HiveTodoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  bool isDone;

  HiveTodoModel({required this.title, this.isDone = false});
}