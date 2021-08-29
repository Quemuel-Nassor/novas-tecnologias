import 'dart:html';

import 'package:app07_loja_cafe/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Café Store'),
          centerTitle: true,
          backgroundColor: Colors.brown),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtEmail,
              style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email'
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Senha'
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 150,
              child: OutlinedButton(
                child: Text('entrar'),
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  login(txtEmail.text,txtSenha.text);
                },
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 150,
              child: TextButton(
                child: Text('Criar conta'),
                onPressed: (){
                  Navigator.pushNamed(context, '/criarconta');
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      
    );
  }

  //
  // LOGIN com Firebase Auth
  //
  void login(email, senha){

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: senha).then((resultado) {

        isLoading = false;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=>TelaPrincipal(uid: resultado.user!.uid))
        );

    }).catchError((erro){

      var errorCode = erro.code;
      var mensagem = '';
      if (errorCode == 'user-not-found'){
        mensagem = 'Usuário não encontrado';
      }else if (errorCode == 'wrong-password'){
        mensagem = 'Senha inválida';
      }else if (errorCode == 'invalid-email'){
        mensagem = 'Email inválido';
      }else{
        mensagem = erro.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERRO: $mensagem'),
          duration: Duration(seconds: 2),
        )
      );

    });

  }


}