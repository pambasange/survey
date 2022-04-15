import 'package:survey/model/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey/person_page.dart';



class registo extends StatefulWidget {
  const registo({Key? key}) : super(key: key);

  @override
  State<registo> createState() => _registoState();
}

class _registoState extends State<registo> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    // recuperar os dados dos controladores
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    // condições para a validação
    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (password.isNotEmpty && password.length > 5) {
          // condições validadas e efetuar o registo de um novo utilizador
          setState(() {
            _mensagemErro = " ";
          });
          //metódo criar utilizador no firebase
          Utilizador utilizador = Utilizador(nome, email, password);

          _registarUtilizador(utilizador);
        } else {
          setState(() {
            _mensagemErro = "Preencha a password com seis ou mais carateres ";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o email";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o nome";
      });
    }
  }

  _registarUtilizador(Utilizador utilizador) {
    FirebaseAuth Auth = FirebaseAuth.instance;
    Auth.createUserWithEmailAndPassword(
            email: utilizador.email, password: utilizador.password)
        .then((firebaseUser) {
      setState(() {
        _mensagemErro = "Sucesso";
      });

      // encaminhamento para a página inicial do utilizador autenticado
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((erro) {
      print("falha: " + erro.toString());
      setState(() {
        _mensagemErro = "Falha, verifique os campos";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 45, top: 10),
                  child: Text(
                    "StressOnCampus",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(26, 16, 32, 16),
                          hintText: "Nome",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerEmail,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(26, 16, 32, 16),
                          hintText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    )),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(26, 16, 32, 16),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Novo Registo",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      _validarCampos();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
