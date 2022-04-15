import 'package:flutter/material.dart';
import 'package:survey/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey/questionnaire/survey_dass.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    // recuperar os dados dos controladores
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    // condições para a validação

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty) {
        // condições validadas e efetuar o registo de um novo utilizador
        setState(() {
          _mensagemErro = " ";
        });
        //metódo criar utilizador no firebase
        Utilizador utilizador = Utilizador("", email, password);

        _loginUtilizador(utilizador);
      } else {
        setState(() {
          _mensagemErro = "Password insuficiente";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o email";
      });
    }
  }

  // metódo que realiza a autenticação de um utilizador existente na base de dados
  _loginUtilizador(Utilizador utilizador) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: utilizador.email, password: utilizador.password)
        .then((firebaseUser) {
      // encaminhamento para a página inicial do utilizador autenticado
      Navigator.push(context, MaterialPageRoute(builder: (context) => dass()));
    }).catchError((erro) {
      setState(() {
        _mensagemErro = "Falha, verifique os dados de acesso";
      });
    });
  }

  Future _verificarLoginUtilizador() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // encaminhamento para a página inicial do utilizador autenticado
      //  Navigator.push(
        //    context, MaterialPageRoute(builder: (context) => questionnaire()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _verificarLoginUtilizador();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Text(
                    "StressOnCampus",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
                              borderRadius: BorderRadius.circular(32))),
                    )),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(26, 16, 32, 16),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _validarCampos();
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
