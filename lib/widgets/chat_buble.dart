import 'dart:io';

import 'package:flutter/material.dart';
import 'package:custom_selectable_text/custom_selectable_text.dart';


class ChatBuble extends StatelessWidget {
  final Alignment alignment;
  final String message;
  final File image;
  const ChatBuble({Key? key, required this.alignment, required this.message, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSelectableText(message,
              items: [
                CustomSelectableTextItem.icon(
                    icon: const Icon(Icons.copy),
                    controlType: SelectionControlType.copy,
                    onPressed: (text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Copied $text text"),
                      ));
                    }),
                CustomSelectableTextItem.icon(
                  controlType: SelectionControlType.selectAll,
                  icon: const Icon(Icons.select_all),
                ),
                CustomSelectableTextItem.icon(
                    icon: const Icon(Icons.share),
                    onPressed: (text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Shared $text text"),
                      ));
                    }),
                CustomSelectableTextItem.popUpMenuButton(
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text("Text 1"),
                        ),
                        const PopupMenuItem(
                          child: Text("Text 2"),
                        ),
                      ],
                    )),
              ],
            ),
            image.path == "" ? Text("") : Image.file(image),
            // Image.network("https://thumbs.dreamstime.com/z/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg")
          ],
        ),
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )
        ),
      ),
    );
  }
}
