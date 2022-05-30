import 'package:chat_firebase/app/data/api.dart';
import 'package:chat_firebase/app/data/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  //TODO: Implement UserController
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getUsers() async {
    try {
      var response = await ApiRequest()
          .getRequest("user api");
      if (response.statusCode != 200) {
        print("Une erreur est survenus");
      } else {
        for (var user in response.data) {
          users.add(User.fromJson(user));
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
