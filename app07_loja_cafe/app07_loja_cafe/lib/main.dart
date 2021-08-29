import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'criarconta.dart';
import 'login.dart';
import 'model/Cafe.dart';

void main() async {
  // Registrar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/principal': (context) => TelaPrincipal(uid: ''),
      '/cadastro': (context) => TelaCadastro(),
      '/login': (context) => TelaLogin(),
      '/criarconta': (context) => TelaCriarConta(),
    },
  ));

  //
  // Teste do Firebase
  //
  /*
  var db = FirebaseFirestore.instance;

  db.collection('cafes').add({"nome": "Café Melita 500g", "preco": "R\$ 9,85"});
  db
      .collection('cafes')
      .doc("cafe001")
      .set({"nome": "Café Melita 500g", "preco": "R\$ 9,85"});

  Cafe cafe = Cafe('', 'Café Utam 1kg', 'R\$ 25,65');
  db.collection('cafes').add(cafe.toJson());
  */
}

//
// Tela Principal
//
class TelaPrincipal extends StatefulWidget {
  final String uid;
  TelaPrincipal({required this.uid});

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Referência a coleção nomeada "cafes" do Firestore
  late CollectionReference cafes;
  late String nome;

  @override
  void initState() {
    super.initState();
    cafes = FirebaseFirestore.instance.collection('cafes');

    FirebaseFirestore.instance.collection('usuarios').doc(widget.uid).get().then((value{

    }));
  }

  Widget itemLista(item) {
    Cafe cafe = Cafe.fromJson(item.data(), item.id);
    return ListTile(
      title: Text(cafe.nome, style: TextStyle(fontSize: 24)),
      subtitle: Text(cafe.preco, style: TextStyle(fontSize: 18)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Apagar um café
          cafes.doc(cafe.id).delete();
        },
      ),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro', arguments: cafe.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            Container(
              child: Text('Café Store'),
            ),
            Container(
              child: Text('Nome'),
            ),
          ]),
          centerTitle: true,
          backgroundColor: Colors.brown),

      //Exibir os documentos
      body: StreamBuilder<QuerySnapshot>(

          //fonte de dados
          stream: cafes.snapshots(),

          //aparência
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Erro ao conectar no Firebase'));

              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());

              default:
                final dados = snapshot.requireData;

                return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      return itemLista(dados.docs[index]);
                    });
            }
          }),

      //
      // Adicionar novos cafés
      //
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro');
        },
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}
