import 'package:chat_firebase/app/data/models/user.dart';
import 'package:chat_firebase/app/modules/communication/bindings/communication_binding.dart';
import 'package:chat_firebase/app/modules/communication/views/communication_view.dart';
import 'package:chat_firebase/app/modules/home/bindings/home_binding.dart';
import 'package:chat_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Scaffold(
        backgroundColor: const Color(0xff14071A),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => ListView.builder(
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        User user = controller.users[index];
                        return user.id == box.read('user')['id'] ? Container(): ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                user.profilPicture!,
                              ),
                            ),
                            title: Text(
                              user.name!,
                              style: const TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            trailing: InkWell(
                              onTap: () => Get.to(CommunicationView(user: user,), binding: CommunicationBinding()),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xff14071A),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                child: const Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ));
                      })),
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (() => {
                        Get.offAll(const HomeView(), binding: HomeBinding())
                      }),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return const Color(0xFF1668CF);
                            }
                            return const Color(0xFF1668CF); /// Defer to the widget's default.
                          },
                        ),

                        elevation: MaterialStateProperty.resolveWith<double>(
                          // As you said you dont need elevation. I'm returning 0 in both case
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return 0;
                            }
                            return 0; // Defer to the widget's default.
                          },
                        ),
                      ),
                      child: Text(
                        'Log out',
                        style: Get.textTheme.headline3!.copyWith(fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
