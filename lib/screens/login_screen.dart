import 'package:flutter/material.dart';
import 'booking_screen.dart';

class LoginScreen extends StatelessWidget {
  final userController = TextEditingController();
  final passController = TextEditingController();

  LoginScreen({super.key});

  bool fakeLogin(String user, String pass) {
    return user == "admin" && pass == "123";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: userController, decoration: InputDecoration(labelText: "Usuário")),
          TextField(controller: passController, decoration: InputDecoration(labelText: "Senha")),
          ElevatedButton(
            onPressed: () {
              if (fakeLogin(userController.text, passController.text)) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BookingScreen()));
              }
            },
            child: Text("Entrar"),
          )
        ],
      ),
    );
  }
}
