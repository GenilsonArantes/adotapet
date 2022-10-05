import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/pages/home.page.dart';

class CreateAnuncio extends StatefulWidget {
  const CreateAnuncio({Key? key}) : super(key: key);

  @override
  State<CreateAnuncio> createState() => _CreateAnuncioState();
}

class _CreateAnuncioState extends State<CreateAnuncio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Center(
          child: SizedBox(

            child: Text('Criando Anuncio'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Criando Anuncio",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Por favor, informe os seus dados, e dados dos pets, e também imagem do(s) pet(s):",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _tecTipoAnimal,
                        decoration: InputDecoration(
                          labelText: "Tipo Animal",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _tecRaca,
                        decoration: InputDecoration(
                          labelText: "Raças",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _tecDataNascimentoPet,
                        decoration: InputDecoration(
                          labelText: "Data Nascimento Pet",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _tecEmailDonoPet,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _tecTelefoneDonoPet,
                        decoration: InputDecoration(
                          labelText: "Telefone",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _tecEndereco,
                        decoration: InputDecoration(
                          labelText: "Endereço",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _tecDescricaoPet,
                        decoration: InputDecoration(
                          labelText: "Descrição",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [
                              Color(0xFFF58524),
                              Color(0XFFF92B7F),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: SizedBox.expand(
                          child: FlatButton(
                            child: Text(
                              "Enviar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              salvarPetFirestore();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }



  final _tecTipoAnimal = TextEditingController();
  final _tecRaca = TextEditingController();
  final _tecDataNascimentoPet = TextEditingController();
  final _tecEmailDonoPet = TextEditingController(); //_tecTelefone
  final _tecTelefoneDonoPet = TextEditingController();
  final _tecEndereco = TextEditingController();
  final _tecDescricaoPet = TextEditingController();

  salvarPetFirestore()async{
    await Firebase.initializeApp();
    var collection = FirebaseFirestore.instance.collection('anuncios');
    collection.doc().set({
      'tipoAnimal':_tecTipoAnimal.text,
      'raca':_tecRaca.text,
      'dataNascimentoPet':_tecDataNascimentoPet.text,
      'emailDonoPet':_tecEmailDonoPet.text,
      'telefoneDonoPet':_tecTelefoneDonoPet.text,
      'endereco':_tecEndereco.text,
      'descricao':_tecDescricaoPet.text


    }).then((value) => print('Registrado')).catchError((error)=>print('deu errado$error'));

  }
}
