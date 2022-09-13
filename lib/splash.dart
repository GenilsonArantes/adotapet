import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/pages/checagem_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  void initState() {
    super.initState();
    //espera 3 segundos do splash
    Future.delayed(Duration(seconds: 3)).then((_) {
      //muda para a proxima tela
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChecagemPage()));
    });
  }


  //constroe a tela do splash
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "Adota-Pet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
        ),
      ),

    );
  }
}
