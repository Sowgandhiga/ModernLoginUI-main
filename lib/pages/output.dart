import 'package:hive/hive.dart';

part 'output.g.dart';

@HiveType(typeId: 1)
class Output {
  Output({required this.pickup, required this.drop});
  @HiveField(0)
  String pickup;

  @HiveField(1)
  String drop;
}
