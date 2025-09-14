// Paste this complete code into: lib/models/user_profile.dart

import 'package:hive/hive.dart';

// This line connects to the file that will be auto-generated
part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int age;

  @HiveField(2)
  late String location;

  @HiveField(3)
  late String currentClass;

  @HiveField(4)
  late List<String> subjects;
}
