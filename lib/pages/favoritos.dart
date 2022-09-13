import 'package:flutter/material.dart';

class FavoritePets extends StatefulWidget {
  const FavoritePets({Key? key}) : super(key: key);

  @override
  State<FavoritePets> createState() => _FavoritePetsState();
}

class _FavoritePetsState extends State<FavoritePets> {
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
            width: 130,
            child: Text('Favoritos'),
          ),
        ),
      ),
      body: Container(
        child: Container(
            child:ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(12, (index){return card(index.toString());}),
                ),
              ],
            )
        ),
      ),

    );
  }
 /* Widget build(BuildContext context) {
    return content();
  }
*/
  Widget content(){
    return Center(
      child: Container(
          child:ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(12, (index){return card(index.toString());}),
              ),
            ],
          )
      ),
    );
  }

  card([String name = "Pet",String number = "Numero"]){
    return Card(
      child: ListTile(
        leading: Icon(Icons.account_circle, size: 50),
        title: Text(name),
        subtitle: Text(number),
        textColor: Colors.pink,
      ),
    );
  }


}