import 'package:flutter/material.dart';
import 'package:new_login_screen/widgets/text_field_widget.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/tasks.png', height: 250),
                      SizedBox(height: 20),
                      Form(
                          key: _formKey,
                          child: Column(children: [
                            TextFormField(
                                controller: _nameController,
                                decoration: decoration("Nome"),
                                validator: (value) =>
                                    requiredValidator(value, "o nome")),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _emailController,
                                decoration: decoration("Email"),
                                validator: (value) =>
                                    requiredValidator(value, "o email!")),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _passwordController,
                                decoration: decoration("Senha"),
                                obscureText: true,
                                validator: (value) =>
                                    requiredValidator(value, "a senha")),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {}
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Registrar'),
                                  ],
                                )),
                            SizedBox(height: 10),
                          ])),
                    ]))));
  }
}
