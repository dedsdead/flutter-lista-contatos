import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String userId;
  @HiveField(1)
  late String userName;
  @HiveField(2)
  late String userEmail;
}
