import 'package:flutter/material.dart';
import 'package:new_login_screen/widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
            children: [
              // Image.asset("assets/tasks.png", width: 200, height: 200),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: decoration("E-mail"),
                        validator: (value) =>
                            requiredValidator(value, "o email"),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _senhaController,
                        decoration: decoration("Senha"),
                        validator: (value) =>
                            requiredValidator(value, "a senha"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login'),
                            ],
                          )),
                      TextButton(
                        child: const Text("Ainda não tem conta? Registre-se"),
                        onPressed: () {
                          Navigator.pushNamed(context, "/loginRegister");
                        },
                      )
                    ],
                  ))
            ],
          ),
        )));
  }
}
