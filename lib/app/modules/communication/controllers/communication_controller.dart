import 'package:chat_firebase/app/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommunicationController extends GetxController {
  //TODO: Implement CommunicationController

  final fs = FirebaseFirestore.instance;
  final TextEditingController message = new TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
