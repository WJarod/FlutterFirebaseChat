import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14071A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: Get.height * 0.2,
            ),
            TextFormField(
              controller: controller.emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email',
                enabled: true,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("Please enter a valid email");
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                controller.emailController.text = value!;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            TextFormField(
              controller: controller.passwordController,
              obscureText: controller.isObscure3.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(controller.isObscure3.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      controller.isObscure3.value =
                          !controller.isObscure3.value;
                    }),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                enabled: true,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                RegExp regex = RegExp(r'^.{6,}$');
                if (value!.isEmpty) {
                  return "Password cannot be empty";
                }
                if (!regex.hasMatch(value)) {
                  return ("please enter valid password min. 6 character");
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                controller.passwordController.text = value!;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            SizedBox(
              width: Get.width * 0.9,
              height: 50,
              child: ElevatedButton.icon(
                  onPressed: (() => controller.Login()),
                  icon: Obx(() {
                    return controller.startLogin.value
                        ? const SpinKitFadingCircle(
                            color: Colors.white,
                            size: 20.0,
                          )
                        : Container();
                  }),
                  label: Text(
                    'Login',
                    style: Get.textTheme.headline3!.copyWith(fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color(0xFF1668CF);
                        }
                        return const Color(0xFF1668CF);
                      },
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return 0;
                        }
                        return 0; // Defer to the widget's default.
                      },
                    ),
                  )),
            )
          ])),
    );
  }
}
