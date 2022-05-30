import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildMessage(String senderId, String receiverId){
  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();

  return StreamBuilder(
    stream: messageStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("something is wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        itemBuilder: (_, index) {
          QueryDocumentSnapshot? qs;
          if(snapshot.data!.docs[index]['senderId'] == senderId && snapshot.data!.docs[index]['receiverId'] == receiverId)
          {
            qs = snapshot.data!.docs[index];
          }
          if(snapshot.data!.docs[index]['senderId'] == receiverId && snapshot.data!.docs[index]['receiverId'] == senderId){
            qs = snapshot.data!.docs[index];
          }
          Timestamp t = qs == null ? Timestamp(10, 10) : qs['time'];
          DateTime d = t.toDate();
          if (kDebugMode) {
            print(d.toString());
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: qs == null ? Container() : Column(
              crossAxisAlignment: senderId == qs['senderId']
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: senderId == qs['senderId'] ? const Color(0xffC13372) : const Color(0xff612880),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Row(
                      children: [
                        Text(senderId == qs['senderId'] ? qs['senderName'] :
                        qs['receiverName'],
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white
                          ),
                        ),
                        const SizedBox(width: 25,),
                        Text("${(d.hour + 2).toString()}:${d.minute.toString()}",
                          style: TextStyle(
                              fontSize: 15,
                              color: senderId == qs['senderId'] ? const Color(0xffC13372) : const Color(0xff612880),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            qs['message'],
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}