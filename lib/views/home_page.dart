import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_login_screen/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  void _openModalForm() {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 99, 131, 151),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Adicionar Tarefas",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Título",
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.text_fields_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  filled: true,
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  firestoreService.addTask(
                    _titleController.text, _descriptionController.text);               
                  _titleController.clear();
                  _descriptionController.clear();
                  Navigator.pop(context);
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName != null ? widget.user.displayName! : 'Não informado'),
              accountEmail: Text(widget.user.email != null ? widget.user.email! : 'Não informado'),
            ),
            ListTile(
              title: Text('Deslogar'),
              onTap: logoutUser,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModalForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
