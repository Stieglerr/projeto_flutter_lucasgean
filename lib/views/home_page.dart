import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _openModalForm(String? docId) async {
    if (docId != null) {
      DocumentSnapshot documentSnapshot = await firestoreService.getTask(docId);
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      _titleController.text = data["title"];
      _descriptionController.text = data["description"];
    }
    
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
              Divider(color: Colors.white),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Título",
                  fillColor: Colors.white,
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
                  filled: true,
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (docId == null) {
                    firestoreService.addTask(
                      _titleController.text, _descriptionController.text);
                  } else {               
                    firestoreService.updateTask(docId, _titleController.text, _descriptionController.text);
                  }
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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = tasksList[index];
                String docId = document.id;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String taskTitle = data['title'];
                String taskDescription = data["description"];

                return Padding(
                  padding: EdgeInsets.all(16),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(taskTitle),
                    subtitle: Text(taskDescription),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _openModalForm(docId);
                          },
                          icon: Icon(Icons.settings),
                        ), 
                        IconButton(
                          onPressed: () {
                            firestoreService.deleteTask(docId);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              }
            );
          } else {
            return Container();
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModalForm(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
