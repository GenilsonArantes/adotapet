import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/visao/cadGasto.dart';
import 'package:projeto/visao/cadReceita.dart';
import 'package:projeto/visao/cadTipoGasto.dart';
import 'package:projeto/visao/cadTipoReceita.dart';
import 'package:projeto/visao/principal.dart';
import 'package:projeto/visao/relatorios.dart';

//indice de seleção da tela
int _selectedIndex = 0;

//vetor de telas a serem utilizadas
List<Widget> _stOptions = <Widget>[
  Principal(),
  CadReceita(),
  CadGasto(),
  CadTipoReceita(),
  CadTipoGasto(),
  Relatorios(),
];

class Navegar extends StatefulWidget {
  int _opcao;

  //contrutor passando o indice da tela selecionada
  Navegar(this._opcao);

  @override
  _NavegarState createState() => _NavegarState(this._opcao);
}

class _NavegarState extends State<Navegar> {

  //construtor
  _NavegarState(this._opcao);
  int _opcao;

  @override
  void initState() {
    _selectedIndex = _opcao;
  }


  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Gastos/Receitas"),
        backgroundColor: Colors.blue,
      ),

      //corpo da aplicação, aqui são setadas as telas
      body: _stOptions.elementAt(_selectedIndex),

      //botões do BN
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Tipos Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Tipo Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Relatorios',
          ),
        ],

        unselectedItemColor: Colors.grey,

        currentIndex: _selectedIndex,

        selectedItemColor: Colors.orange,
        //greenAccent,
        onTap:
        _onItemTapped, //chama o métdodo onItemTapped ao clicar no botao do BTNNavigation
      ),
    );
  }

  @override
  void _onItemTapped(int  index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}