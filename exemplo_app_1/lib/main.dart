import 'package:flutter/material.dart';

void main() {
  //Indicar a 1ª tela do app que será exibida
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App02',
      home: TelaPrincipal(),
    ),
  );
}

BoxDecoration customBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.blue,
      width: 2.0,
      style: BorderStyle.solid,
    ),
  );
}

Container halfColumn(String content, Color color, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.5 - 10,
    height: MediaQuery.of(context).size.height * 0.15 - 20,
    decoration: customBoxDecoration(),
    child: Center(
      child: Text(
        content,
        style: new TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Container rowCustom(String content, Color color, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.615,
    decoration: customBoxDecoration(),
    child: Center(
      child: Text(
        content,
        style: new TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

//Tela principal
class TelaPrincipal extends StatelessWidget {
  //O método build é responsável por construir os widgets que serão exibidos na tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //start appBar
      appBar: AppBar(
        title: Text(
          'Custom Screen',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 32.0,
                  color: Colors.black,
                ),
                onPressed: () {},
              )),
        ],
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      //endAppBar
      //start appBody
      backgroundColor: Colors.white,
      body: Container(
        margin: new EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          right: 10.0,
          bottom: 30.0,
        ),
        //start column child
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  halfColumn('A', Colors.yellow, context),
                  halfColumn('B', Colors.blue, context),
                ],
              ),
            ),
            rowCustom('C', Colors.yellow, context),
            Container(
              child: Row(
                children: [
                  halfColumn('D', Colors.green, context),
                  halfColumn('E', Colors.red, context),
                ],
              ),
            ),
          ],
        ),
        //end column
      ),
    );
  }
}
