import 'package:chatapp/chat_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  void loginUser(context) {
    print("username: ${usernameController.text}");
    print("login successful!");
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(username: usernameController.text,)));
  }
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let's sign you in!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.brown, fontWeight: FontWeight.bold),),
              Text(
                "Welcome back!!\n we missed you!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),),
              Image.network("https://thumbs.dreamstime.com/z/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
              width: 100,),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "enter your username",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    loginUser(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 24),
                  )
              ),
              InkWell(
                onTap: () => {print("tapped the link...")},
                onLongPress: () => {print("long pressed...")},
                child: Column(
                  children: [
                    Text("find us on"),
                    Text(
                      "https://google.com",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}