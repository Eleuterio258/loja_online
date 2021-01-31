import 'package:flutter/material.dart';
import 'package:login_firebase/shared/model/user_model.dart';
import 'package:login_firebase/utils/validation.dart';

class SignupPageFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _scaffoldState = GlobalKey<ScaffoldState>();
    final UserModel userModel = UserModel();
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Criar conta',
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                    onSaved: (nome) => userModel.nome = nome,
                    decoration: InputDecoration(
                      hintText: 'Nome completo',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    validator: (nome) {
                      if (nome.isEmpty) {
                        return 'Compo Obrigatorio';
                      } else if (nome.trim().split(' ').length <= 1)
                        return 'Preencha seu Nome Completo';
                      return null;
                    }),
                SizedBox(height: 16),
                TextFormField(
                    onSaved: (email) => userModel.email = email,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'Compo Obrigatorio';
                      } else if (!emailValidation(email))
                        return 'E-mail invalido';
                      return null;
                    }),
                SizedBox(height: 16),
                TextFormField(
                    onSaved: (senha) => userModel.password = senha,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty) {
                        return 'Compo Obrigatorio';
                      } else if (pass.length < 6) {
                        return 'Senha muito Curta';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                TextFormField(
                    onSaved: (senhaConf) => userModel.confPassword = senhaConf,
                    decoration: InputDecoration(
                      hintText: 'Repita a Senha',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: true,
                    validator: (passR) {
                      if (passR.isEmpty) {
                        return 'Compo Obrigatorio';
                      } else if (passR.length < 6) {
                        return 'Senha muito Curta';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        if (userModel.password != userModel.confPassword) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Senhas não coincidem",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                      }
                    },
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
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
