import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/pages/checagem_page.dart';

class TestePagina extends StatefulWidget {
  const TestePagina({Key? key}) : super(key: key);

  @override
  State<TestePagina> createState() => _TestePaginaState();
}

class _TestePaginaState extends State<TestePagina> {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  String pagina = 'Pagina Teste';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Teste'),

        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Exit'),
                onTap: () {
                  sair();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChecagemPage(),
        ),
      ),
    );
  }

}
