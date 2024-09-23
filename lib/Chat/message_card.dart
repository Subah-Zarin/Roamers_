import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_date_util.dart';
import 'apis.dart';
import 'message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key , required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return APIs.user.uid == widget.message.fromId ? _greenMessage() : _blueMessage();
  }
  // sender message

 Widget _blueMessage() {

   final mq = MediaQuery.of(context).size;
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       //message content
       Flexible(
         child: Container(
           padding: EdgeInsets.all(widget.message.type == Type.image
               ? mq.width * .03
               : mq.width * .04),
           margin: EdgeInsets.symmetric(
               horizontal: mq.width * .04, vertical: mq.height * .01),
           decoration: BoxDecoration(
               color: const Color.fromARGB(255, 221, 245, 255),
               border: Border.all(color: Colors.lightBlue),
               //making borders curved
               borderRadius: const BorderRadius.only(
                   topLeft: Radius.circular(30),
                   topRight: Radius.circular(30),
                   bottomRight: Radius.circular(30))),
           child: widget.message.type == Type.text
               ?
           //show text
           Text(
             widget.message.msg,
             style: const TextStyle(fontSize: 15, color: Colors.black87),
           )
               :
           //show image

         ),
       ),

       //message time
       Padding(
         padding: EdgeInsets.only(right: mq.width * .04),
         child: Text(
           MyDateUtil.getFormattedTime(
               context: context, time: widget.message.sent),
           style: const TextStyle(fontSize: 13, color: Colors.black54),
         ),
       ),
     ],
   );
 }

 //our msg

  Widget _greenMessage() {
    final mq = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: mq.width * .04),

            //double tick blue icon for message read
            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
            //show text
            Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            )
                :
            //show image

          ),
        ),
      ],
    );
  }



}

