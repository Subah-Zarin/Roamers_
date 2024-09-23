


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roamers/Chat/search_page.dart';
import 'package:roamers/homepage/profile.dart';
import 'package:roamers/service/auth_service.dart';
import 'package:roamers/widgets/widgets.dart';

import '../helper/helper_function.dart';
import '../my_date_util.dart';
import '../service/database_service.dart';
import '../widgets/group_tile.dart';
import 'package:roamers/shared/constant.dart';

import 'apis.dart';
import 'chat_user.dart';
import 'message.dart';
import 'message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];

  //for handling message text changes
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final mq = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),

      ),

      //body
      body:  SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                  //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox();

                  //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      _list = data
                          ?.map((e) => Message.fromJson(e.data()))
                          .toList() ??
                          [];

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(message: _list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('Say Hii! 👋',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              ),
            ),

            //progress indicator for showing uploading

            //chat input filed
            _chatInput(),

            //show emojis on keyboard emoji button click & vice versa

          ],
        ) ,
      ),
    ),









  }

  Widget _appBar() {
    return SafeArea(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => profile()));
          },
          child: StreamBuilder(
               stream: APIs.getUserInfo(widget.user.id),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => ChatUser.fromJson(e.data()as Map<String, dynamic>)).toList() ??
                        [];

                return Row(
                  children: [
                    //back button
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black54)),

                    //user profile picture


                    //for adding some space
                    const SizedBox(width: 10),

                    //user name & last seen time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //user name
                        Text(list.isNotEmpty ? list[0].name : widget.user.name,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),

                        //for adding some space
                        const SizedBox(height: 2),

                        //last seen time of user
                        Text(
                            list.isNotEmpty
                                ? list[0].isOnline
                                ? 'Online'
                                : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: list[0].lastActive)
                                : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: widget.user.lastActive),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black54)),
                      ],
                    )
                  ],
                );
              })),
    );
  }

  Widget _chatInput(){
    return Padding(
      padding: EdgeInsets.all(0.8),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [

                  Expanded(
                      child: TextField(
                        controller: _textController,
                        keyboardType: TextInputType.multiline,

                        decoration: const InputDecoration(
                            hintText: 'Type Something...',
                            hintStyle: TextStyle(color: Colors.blueAccent),
                            border: InputBorder.none),
                      )),

                  //pick image from gallery button


                  //take image from camera button

                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                if (_list.isEmpty) {
                  //on first message (add user to my_user collection of chat user)
                  APIs.sendFirstMessage(
                      widget.user, _textController.text, Type.text);
                } else {
                  //simply send message
                  APIs.sendMessage(
                      widget.user, _textController.text, Type.text);
                }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }


}