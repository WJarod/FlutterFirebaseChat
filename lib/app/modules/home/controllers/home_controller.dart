import 'package:chat_firebase/app/data/api.dart';
import 'package:chat_firebase/app/modules/communication/bindings/communication_binding.dart';
import 'package:chat_firebase/app/modules/communication/views/communication_view.dart';
import 'package:chat_firebase/app/modules/user/bindings/user_binding.dart';
import 'package:chat_firebase/app/modules/user/views/user_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  var box = GetStorage();
  RxBool startLogin = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isObscure3 = true.obs;
  RxBool visible  = false.obs;

  @override
  void onInit() {
    box.remove('user');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future Login() async {
    try {
      var response = await ApiRequest().postRequest("http://34.76.202.156/user/signin", {"mail": emailController.text, "password": passwordController.text});
      if (response.statusCode != 200)
      {
        startLogin.value = false;
        Get.snackbar('Error', "Une erreur c'est produite",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ));
      }
      else {
        box.remove('user');
        box.write('user', response.data);
        if (kDebugMode) {
          print(box.read('user'));
        }
        box.write('token', response.data['tokenJWT']);
        box.write('isAuthenticated', true);
        // dynamic result = await registerFirebaseWithEmailAndPassword(emailController.text, passwordController.text);
        // if(result == null) {
        //   if(alreadyExists == true) {
        //     print(response.data.toString());
        //     startLogin.value = false;
        //
        //
        //     box.write('firebaseUser', result);
        //   }
        // } else {
        //   print(result.toString());
        // }
      }
    } on Exception catch (e) {
      startLogin.value = false;
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Error', 'Veuillez vérifiez vos informations',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ));
    }
    Get.offAll(() => UserView(), binding: UserBinding());
    Get.snackbar('Success', 'Bienvenue',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ));
  }
}
