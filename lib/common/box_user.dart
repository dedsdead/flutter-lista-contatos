import 'package:hive/hive.dart';

import '../model/user.dart';

class UserBox {
  static Box<UserModel> getUsersBox() => Hive.box('users');
}
