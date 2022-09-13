import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/controle/CReceitas.dart';
import 'package:projeto/controle/CTipoReceita.dart';
import 'package:projeto/modelo/beans/receita.dart';
import 'package:projeto/modelo/beans/tipoReceita.dart';

class CadReceita extends StatefulWidget {
  @override
  _CadReceitaState createState() => _CadReceitaState();
}

class _CadReceitaState extends State<CadReceita> {
  //lista de tipo de Receitas
  List<TipoReceita> _tiposReceita = [];
  String dropdownValue = "Tipo Receita";
  late TipoReceita dropdownValue2;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cad. Receitas"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: <Widget>[
            //card para inserção
            Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Tipo de Receita:"),
                        //se a lista ainda não foi carregada, mostra circular, se foi mostra do dropdown
                        _tiposReceita.isEmpty?
                        CircularProgressIndicator():
                        DropdownButton<TipoReceita>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (TipoReceita? newValue) {
                            setState(() {
                              dropdownValue2 = newValue!;
                            });
                          },
                          items: //<String>['Tipo Receita', 'Two', 'Free', 'Four']
                          _tiposReceita
                              .map<DropdownMenuItem<TipoReceita>>((TipoReceita value) {
                            return DropdownMenuItem<TipoReceita>(
                              value: value,
                              child: Text(value.nome),
                            );
                          }).toList(),
                        ),
                        Text("Observações:"),
                        TextField(controller: _observacoes,),
                        Text("Valor:"),
                        TextField(controller: _valor,),
                        Row(children: <Widget>[
                          Expanded(child: Column(children: <Widget>[
                            Text("Data:"),
                            TextField(controller: _data,),
                          ],),),
                          Expanded(child: Column(children: <Widget>[
                            Text("Hora:"),
                            TextField(controller: _hora,),
                          ],),)
                        ],),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          _insereReceita();
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12.0)
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 10,),
            Text("::Dados::"),
            Expanded(
              child: Card(
                child: ListView(children: _listViewReceita),
              ),
            )
          ],
        )
    );
  }

  TextEditingController _observacoes = TextEditingController();
  TextEditingController _valor = TextEditingController();
  TextEditingController _data = TextEditingController();
  TextEditingController _hora = TextEditingController();

  //lista de tipo de Receitas
  List<Receita> _listReceita = [];
  //listView de tipos de Receitas
  List<Widget> _listViewReceita = [];

  _setDropDown() async {
    //busca lista de objetos Receita do BD
    _tiposReceita = await CTipoReceitas().getAllList();

    setState(() {
      try{
        //coloca o dorpdownValue, o primeiro elemento buscado
        dropdownValue2 = _tiposReceita.first;
      }catch(x){
        print("erro");
      }
    });

  }
  _setListView() async {
    //busca lista de objetos Receita do BD
    _listReceita = (await CReceita().getAllList()).cast<Receita>();
    //monta listView já na treade de visualização de forma dinâmica
    setState(() {
      try {
        _listViewReceita = _listReceita
            .map(
              (_data) => Card(
              elevation: 3,
              child: Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _data.valor.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.black),
                        ),
                        Text(
                          _data.data.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.black),
                        ),
                        Text(
                          _data.hora.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.black),
                        ),
                        Text(
                          _data.observacoes.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.black),
                        ),
                      ],),),
                    ButtonTheme(
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          //necessário colocar est exclamação pois o timpo da variável é ? e pode ser nula
                          _deleteReceita(_data.id!);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        color: Colors.blueGrey,
                      ),
                    )
                  ],
                ),
              )),
        )
            .toList();
      } catch (_) {
        print("Não foi possível adicionar ao carrinho!");
        /*Toast.show("Não foi possível adicionar ao carrinho!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);*/
      }
    });
  }
  _insereReceita() {
    Receita g = Receita(null,dropdownValue2.id!,_observacoes.text,_data.text,_hora.text,double.parse(_valor.text));
    CReceita().insert(g);
    setState(() {
      _setListView();
    });
  }
  _deleteReceita(int id){
    CReceita().deletar(id);
    setState(() {
      _setListView();
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _setListView();
    });
    _setDropDown();
  }
}