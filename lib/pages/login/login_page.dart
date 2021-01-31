import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:login_firebase/shared/model/user_model.dart';
import 'package:login_firebase/utils/validation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final scaffoldState = GlobalKey<ScaffoldState>();
    bool _passwordVisible = false;

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('signup');
            },
            child: Text('Criar conta',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
        title:
            Text('Entrar', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: _formKey,
              child: Consumer<AuthService>(builder: (_, authService, __) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      enabled: !authService.loading,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        prefixIcon: Icon(Icons.mail),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValidation(email)) return "Email invalido";
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: !authService.loading,
                      controller: senhaController,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      obscureText: true,
                      validator: (senha) {
                        if (senha.isEmpty || senha.length < 6)
                          return "senha invalida";
                        return null;
                      },
                    ),
                    Align(
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: Text("Esqueci minha senha"),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        onPressed: authService.loading
                            ? null
                            : () {
                                if (_formKey.currentState.validate()) {
                                  authService.sigin(
                                    user: UserModel(
                                      email: emailController.text,
                                      password: senhaController.text,
                                    ),
                                    onFail: (e) {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Falha ao Entrar $e",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onSucess: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              },
                        child: authService.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Entrar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
