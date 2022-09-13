import 'package:flutter/material.dart';
import 'package:projeto/pages/checagem_page.dart';
import 'package:projeto/pages/createanuncio.dart';
import 'package:projeto/pages/favoritos.dart';
import 'package:projeto/pages/meusPets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/pages/relatorios.dart';
import 'package:projeto/pages/testPagina.dart';

import '../projeto/manin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  initState() {
    pegarUsuario();
  }

  Widget build(BuildContext context) {
    return Scaffold(

      drawer: new Drawer(
        width: 280,
        backgroundColor: Colors.white,
        child: new ListView(

          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: new BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              accountName: Text(nome),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Container(
                  child: Image.asset("assets/user-picture.png"),
                ),
                //backgroundImage: ,
              ),
            ),

            ListTile(
                title: new Text("Pets-Favoritos"),
                trailing: Icon(Icons.star_border),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePets()),
                  );
                }),
            ListTile(
                trailing: Icon(Icons.add),
                title: new Text("Adicionar Pet"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAnuncioPage()),
                  );
                }),
            ListTile(
                title: new Text("Meus Pets"),
                trailing: Icon(Icons.pets_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeusPets()),
                  );
                }),
            ListTile(
              title: new Text("Configurações Conta"),
              trailing: Icon(Icons.settings),
              onTap: () => BorderRadius.circular(1),
            ),
            ListTile(
                title: new Text("Relatórios"),
                trailing: Icon(Icons.pets_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Relatorios()),
                  );
                }),
            ListTile(
                title: new Text("Pagina Teste"),
                trailing: Icon(Icons.pan_tool),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestePagina()),
                  );
                }),
            ListTile(
                title: new Text("LastPage"),
                trailing: Icon(Icons.add_a_photo_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LastPage2()),
                  );
                }),
            ListTile(
              dense: true,
              title: Text('Sair'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                sair();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: SizedBox(
            width: 90,
            child: Text('Adota-Pet'),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 60,
            child: FlatButton(
              child: Icon(
                Icons.search,
                color: Color(0xFFBABABA),
              ),
              onPressed: () => {},
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF2F3F6),
        child: ListView(
          children: <Widget>[
            cardItem(),
            cardItem(),
            cardItem2(),
            SizedBox(
              height: 68,
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
        tooltip: 'Adicionar Pet',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAnuncioPage()),
          );
        },
      ),
    );
  }

  pegarUsuario() async {
    User? usuario = await _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
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

Widget cardItem() {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://static1.patasdacasa.com.br/articles/8/10/38/@/4864-o-cachorro-inteligente-mostra-essa-carac-articles_media_mobile-1.jpg"),
          ),
          title: Text("Genilson Arantes"),

          subtitle: Text("09/05/2019 18:37"),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          child: Image.asset("assets/post-picture-002.png"),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            "Pets Para a Adoção:\n"
                "Raças: Pug, Vira Lata, Pastor Alemão, Pincher\n"
                "Meios De Contatos: \nEmail: mimosa@gmail.com \nTelefone: (37)99999-9999\nEndereço: Rua Fulano de Tal",
            textAlign: TextAlign.left,
          ),
        ),
        ButtonTheme(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.star_border),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.whatsapp),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.phone),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.mail),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget cardItem2() {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://static1.patasdacasa.com.br/articles/8/10/38/@/4864-o-cachorro-inteligente-mostra-essa-carac-articles_media_mobile-1.jpg"),
          ),
          title: Text("Kalita Gonçalves"),
          subtitle: Text("09/05/2022 18:37"),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          child: Image.asset("assets/post-picture-001.png"),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            "Nome: Theo",
            textAlign: TextAlign.left,
          ),
        ),
        ButtonTheme(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.star_border),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.whatsapp),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.phone),
                onPressed: () {},
              ),
              FlatButton(
                child: Icon(Icons.mail),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
