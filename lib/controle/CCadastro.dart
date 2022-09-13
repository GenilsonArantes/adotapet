import 'package:projeto/modelo/bd/bd_core.dart';
import 'package:projeto/modelo/beans/cadastro.dart';

class CCadastro{

  Future<int> insert(Cadastro g) async {
    int id = await BdCore.instance.insert(g.toMap(),BdCore.tableCadastro);
    print('linha inserida id: $id');
    return id;
  }
  Future<int> update(Cadastro g) async {
    final linhasAfetadas = await BdCore.instance.update(g.toMap(),BdCore.tableCadastro);
    print('atualizadas $linhasAfetadas linha(s)');
    return linhasAfetadas;
  }
  Future<int> deletar(int id) async {
    //final id = await BdCore.instance.queryRowCount(BdCore.tableCadastro);
    final linhaDeletada = await BdCore.instance.delete(id, BdCore.tableCadastro);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
    return linhaDeletada;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableCadastro);
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
    return todasLinhas;
  }

  Future<List<Cadastro>> getAllList() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableCadastro);
    List<Cadastro> lg = List.generate(todasLinhas.length, (i) {
      return Cadastro(
          todasLinhas[i]['id'],
          todasLinhas[i]['nome'],
          todasLinhas[i]['cpf'],
          todasLinhas[i]['email'],
          todasLinhas[i]['telefone'],
          todasLinhas[i]['senha']
      );
    });
    return lg;
  }

  Future<Cadastro> get(int id) async {
    String sql = ""
        "SELECT * "
        "FROM cadastro "
        "WHERE id = $id;";
    final todasLinhas = await BdCore.instance.querySQL(sql);
    List<Cadastro> lg = List.generate(todasLinhas.length, (i) {
      return Cadastro(
          todasLinhas[i]['id'],
          todasLinhas[i]['nome'],
          todasLinhas[i]['cpf'],
          todasLinhas[i]['email'],
          todasLinhas[i]['telefone'],
          todasLinhas[i]['senha']

      );
    });
    late Cadastro c;
    try {
      c = lg.elementAt(0);
    }catch(_){}
    return c;
  }

}
