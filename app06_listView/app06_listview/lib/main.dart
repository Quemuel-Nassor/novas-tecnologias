import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView',
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuPrincipal(),
        '/list1': (context) => ListViewBuilder(),
        '/list2': (context) => ListViewSepareted(),
      },
    )
  );
}

//
// MENU PRINCIPAL
//
class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),

        //
        // LISTVIEW
        //
        child: ListView(
          children: [
            Icon(Icons.list,size:120,color:Colors.grey),
            Text('O widget ListView permite adicionar uma lista ' +
                 'de itens roláveis',
                 style: TextStyle(fontSize: 18, color:Colors.grey, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 40),

            ListTile(
              
              leading: Icon(Icons.label, color: Colors.grey),
              trailing: Icon(Icons.build, color: Colors.grey),
              title: Text('ListView.builder', style: TextStyle(fontSize: 32, color:Colors.grey)),
              subtitle: Text('O construtor builder() é utilizado para repetir um conjunto de itens. ', style: TextStyle(fontSize: 14, color:Colors.grey, fontStyle: FontStyle.italic)),
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/list1');
              },
              hoverColor: Colors.blue[100],

            ),

            ListTile(
              
              leading: Icon(Icons.label, color: Colors.grey),
              trailing: Icon(Icons.build, color: Colors.grey),
              title: Text('ListView.separeted', style: TextStyle(fontSize: 32, color:Colors.grey)),
              subtitle: Text('O construtor separeted() é utilizado para repetir um conjunto de itens com um separador. ', style: TextStyle(fontSize: 14, color:Colors.grey, fontStyle: FontStyle.italic)),
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/list2');
              },
              hoverColor: Colors.blue[100],

            ),

          ],
        ),


      ),
    );
  }
}

//
// ListView.builder
//
class ListViewBuilder extends StatefulWidget {
  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.builder'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [

          //
          // HORIZONTAL
          //
          Container(
            padding: EdgeInsets.fromLTRB(40,40,40,0),
            height: 320,

              //
              // ListView.builder
              //
              child: ListView.builder(

                //Orientação
                scrollDirection: Axis.horizontal,

                //Aparência o item da lista
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Item $index')),
                  );
                },

                //Quantidade de itens
                itemCount: 100,

              ),

          ),

          //
          // VERTICAL
          //
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Row(
                      children:[
                        Image.network('https://picsum.photos/id/${index+1}/160'),  
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Mussum Ipsum, cacilds vidis litro abertis. Não sou faixa preta cumpadi, sou preto inteiris, inteiris. Per aumento de cachacis, eu reclamis. Quem manda na minha terra sou euzis! Cevadis im ampola pa arma uma pindureta.'))
                        )
                      ]
                    ),
                  );
                },

                //Quantidade de itens
                itemCount: 100,
              ),

            ),
          ),

        ],
      ),
    );
  }
}

//
// ListView.separeted
//
class ListViewSepareted extends StatefulWidget {
  @override
  _ListViewSeparetedState createState() => _ListViewSeparetedState();
}

class _ListViewSeparetedState extends State<ListViewSepareted> {

  //lista dinâmica simplesmente encadeada
  var lista = [];

  var txtTarefa = TextEditingController();

  @override
  void initState(){
    super.initState();
    lista.add('Ir ao supermercado');
    lista.add('Trocar a lâmpada da cozinha');
    lista.add('Alimentar o gato');
    lista.add('Comprar pizza');
    lista.add('Abastecer o veículo');
    lista.add('Cortar o cabelo');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),

        //
        // ListView.separeted
        //
        child: ListView.separated(
          //reverse: true,

          //Aparência do Item
          itemBuilder: (context,index){
            return ListTile(
              title: Text(lista[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red[100]),
                onPressed: (){
                  setState(() {
                    lista.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tarefa removida com sucesso.'),
                        duration: Duration(seconds: 2),
                      )    
                    );
                  });
                },
              ),
            );
          }, 

          //Aparência do separador
          separatorBuilder: (context,index){
            return Divider(
              color: Colors.lightBlue[100],
              thickness: 2,
            );
          }, 

          //Quantidade de itens
          itemCount: lista.length
          
        ),

      ),

      //
      // ADICIONAR TAREFA
      //  
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Adicionar tarefa', style: TextStyle(fontSize: 12)),
                content: TextField(
                  controller: txtTarefa,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Informe a tarefa'
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('adicionar'),
                    onPressed: (){
                      setState(() {
                        lista.add(txtTarefa.text);
                        txtTarefa.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tarefa adicionada com sucesso.'),
                            duration: Duration(seconds: 2),
                          )    
                        );
                      });
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('cancelar'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],

              );
            }
          );

        },
      ),

    );
  }}
