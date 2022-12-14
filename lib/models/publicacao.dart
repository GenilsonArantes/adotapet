class Usuario{
  //necessário este interrogação para inserir valor nulo
  late String id;
  late String nome;
  late String cpf;
  late String email;
  late String telefone;
  late String senha;


  // criando um construtor
  Usuario(this.id, this.nome, this.cpf,this.email,this.telefone,this.senha);

  Usuario.map(dynamic obj) {
    this.id = obj['id'];
    this.nome = obj['nome'];
    this.cpf = obj['cpf'];
    this.email = obj['email'];
    this.telefone = obj['telefone'];
    this.senha = obj['senha'];

  }

  Map<String, dynamic> toMap() {
    var mapa = new Map<String, dynamic>();
    //mapa["id"] = id;
    mapa["nome"] = nome;
    mapa["cpf"] = cpf;
    mapa["email"] = email;
    mapa["telefone"] = telefone;
    mapa["senha"] = senha;
    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
  }

  Usuario.fromMap(Map<String, dynamic> mapa) {
    this.id = mapa['id'];
    this.nome = mapa['nome'];
    this.cpf = mapa['cpf'];
    this.email = mapa['email'];
    this.telefone = mapa['telefone'];
    this.senha = mapa['senha'];

  }
}