import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/controle/CGastos.dart';
import 'package:projeto/controle/CTipoGasto.dart';
import 'package:projeto/modelo/beans/gasto.dart';
import 'package:projeto/modelo/beans/tipoGasto.dart';

class CadGasto extends StatefulWidget {

  @override
  _CadGastoState createState() => _CadGastoState();
}

class _CadGastoState extends State<CadGasto> {

  //lista de tipo de gastos
  List<TipoGasto> _tiposGasto = [];
  String dropdownValue = "Tipo Gasto";
  late TipoGasto dropdownValue2;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cad. Gastos"),
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
                      Text("Tipo de Gasto:"),
                      //se a lista ainda não foi carregada, mostra circular, se foi mostra do dropdown
                      _tiposGasto.isEmpty?
                        CircularProgressIndicator():
                        DropdownButton<TipoGasto>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (TipoGasto? newValue) {
                            setState(() {
                              dropdownValue2 = newValue!;
                            });
                          },
                          items: //<String>['Tipo Gasto', 'Two', 'Free', 'Four']
                          _tiposGasto
                              .map<DropdownMenuItem<TipoGasto>>((TipoGasto value) {
                            return DropdownMenuItem<TipoGasto>(
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
                        _insereGasto();
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
          Text("DADOS"),
          Expanded(
            child: Card(
              child: ListView(children: _listViewGasto),
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
  List<Gasto> _listGasto = [];
  //listView de tipos de Receitas
  List<Widget> _listViewGasto = [];


  _setDropDown() async {
    //busca lista de objetos Gasto do BD
    _tiposGasto = await CTipoGastos().getAllList();

    setState(() {
      try{
        //coloca o dorpdownValue, o primeiro elemento buscado
        dropdownValue2 = _tiposGasto.first;
      }catch(x){
        print("erro");
      }
    });

  }

  _setListView() async {
    //busca lista de objetos Receita do BD
    _listGasto = (await CGasto().getAllList()).cast<Gasto>();
    //monta listView já na treade de visualização de forma dinâmica
    setState(() {
      try {
        _listViewGasto = _listGasto
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
  _insereGasto() {
    Gasto g = Gasto(null,dropdownValue2.id!,_observacoes.text,_data.text,_hora.text,double.parse(_valor.text));
    CGasto().insert(g);
    setState(() {
      _setListView();
    });
  }
  _deleteReceita(int id){
    CGasto().deletar(id);
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