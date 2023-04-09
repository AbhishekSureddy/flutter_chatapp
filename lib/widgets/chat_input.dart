import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:http/http.dart' as http;

class ChatInput extends StatefulWidget{
  final Function(String, File) onSubmit;
  ChatInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ChatInput createState() => _ChatInput();
}

class _ChatInput extends State<ChatInput> {

  File _image = File("");
  final picker = ImagePicker();
  String? _responseString;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 100);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImage() async {
    var uri = Uri.parse("http://192.168.0.12:5000/upload-image");
    var request = http.MultipartRequest('POST', uri);
    var multipartFile = await http.MultipartFile.fromPath("image", _image.path);
    print("multipartfile: ${_image.path}");
    request.files.add(multipartFile);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    setState(() {
      _responseString = String.fromCharCodes(responseData);
    });
    print("responseString: $_responseString");
  }

  Future<void> onSendButtonClick() async {
    print("chatMessage: ${chatMessageController.text}");
    final newChatMessage = chatMessageController.text;
    // user input
    widget.onSubmit(newChatMessage, _image);
    // output from api
    await uploadImage();
    widget.onSubmit("$_responseString", File(""));
  }
  final chatMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: getImage, icon: Icon(Icons.add)),
          Expanded(child: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            controller: chatMessageController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Type your message here!",
              hintStyle: TextStyle(color: Colors.white),
            ),
          )),
          IconButton(onPressed: onSendButtonClick, icon: Icon(Icons.send))
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24), bottom: Radius.circular(24))
      ),
    );
  }
}
