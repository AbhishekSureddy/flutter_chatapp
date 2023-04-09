import 'package:chatapp/chat_page.dart';
// import 'package:chatapp/counter_app.dart';
import 'package:chatapp/login_page.dart';
// import 'package:flutter/material.dart';
//
//
// void main() {
//   runApp(ChatApp());
// }
//
// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Chat app!!",
//       theme: ThemeData(primarySwatch: Colors.amber),
//       // home: CounterStateful(buttonColor: Colors.blue),
//       home: LoginPage(),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:custom_selectable_text/custom_selectable_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat app!!",
      theme: ThemeData(primarySwatch: Colors.amber),
      // home: CounterStateful(buttonColor: Colors.blue),
      // home: MyHomePage(title: "Chatapp"),
      home: LoginPage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image.path == "" ? Text('No image selected.') : Image.file(_image),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Select Image'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: uploadImage,
                  child: Text('Upload Image'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("value: $_responseString"),
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
        ],
      ),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter DDIIDD Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
