import 'package:chat_firebase/app/data/models/user.dart';
import 'package:chat_firebase/app/modules/communication/views/widget/build_message.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/communication_controller.dart';

class CommunicationView extends GetView<CommunicationController> {
  const CommunicationView({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Scaffold(
      backgroundColor: const Color(0xff14071A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(user!.firstname! + " " + user!.name!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              child: buildMessage(box.read('user')['id'], user!.id!),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.message,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'message',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {},
                    onSaved: (value) {
                      controller.message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller.message.text.isNotEmpty) {
                      controller.fs.collection('Messages').doc().set({
                        'senderId': box.read('user')['id'],
                        'senderName': box.read('user')['name'],
                        'message': controller.message.text.trim(),
                        'time': DateTime.now(),
                        'receiverId': user!.id!,
                        'receiverName': user!.name!,
                      });

                      controller.message.clear();
                    }
                  },
                  icon: const Icon(Icons.send_sharp, color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
