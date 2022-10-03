import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controle/checagem_page.dart';

class accoutConfigs extends StatefulWidget {
  const accoutConfigs({Key? key}) : super(key: key);

  @override
  State<accoutConfigs> createState() => _accoutConfigsState();
}

class _accoutConfigsState extends State<accoutConfigs> {
  final novaSenha = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
    );
  }
}
