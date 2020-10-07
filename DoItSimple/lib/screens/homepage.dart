import 'package:flutter/material.dart';
import 'package:mytodolist/screens/taskpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytodolist/navigator/navigation_bloc.dart';

class Homepage extends StatefulWidget with NavigationStates{
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String todoTitle = "";
  String todoDescription = "";
  var taskCount = 0;

  createTodos() {
    // ignore: deprecated_member_use
    DocumentReference documentReference = Firestore.instance.collection("DoIt Simple").document(todoTitle);
    taskCount = taskCount + 1;
    Map <String, String> todos = {"todoTitle": todoTitle, "todoDescription": todoDescription};

    // ignore: deprecated_member_use
    documentReference.setData(todos).whenComplete(() {
      print("$todoTitle criado");
    });
  }

  deleteTodos(item) {
    // ignore: deprecated_member_use
    DocumentReference documentReference = Firestore.instance.collection("DoIt Simple").document(item);
    taskCount = taskCount - 1;
    documentReference.delete().whenComplete(() {
      print("$item excluido");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Adicionar Lembrete"),
                  content: TextField(
                    onChanged: (String value) {
                      todoTitle = value;
                    },
                  ),
                  actions: <Widget>[
                    Center(
                      child: RaisedButton(
                          onPressed: () {
                            createTodos();
                            Navigator.of(context).pop();
                          },
                          child: Text("Adicionar"),
                          padding: EdgeInsets.all(20),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 53.0, right: 20.0, bottom: 0, top: 20.0),
            child: ListTile(
              title: Text(
                "Lembretes",
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 35),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.done_all,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$taskCount Tasks',
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  )
                )
              ],
            )
          ),
          Divider(
            height: 64,
            thickness: 0.5,
            color: Colors.white,
            indent: 32,
            endIndent: 32,
          ),
          StreamBuilder(
              // ignore: deprecated_member_use
              stream: Firestore.instance.collection("DoIt Simple").snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return Container(
                    height: 480,
                    margin: const EdgeInsets.only(right: 10, left: 10, top: 40),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
                          taskCount = snapshots.data.documents.length;
                          return Dismissible(
                              onDismissed: (direction) {
                                deleteTodos(documentSnapshot["todoTitle"]);
                              },
                              key: Key(documentSnapshot["todoTitle"]),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TaskPage(),
                                            settings: RouteSettings(
                                              arguments: {
                                                "title": documentSnapshot["todoTitle"],
                                                "description": documentSnapshot["todoDescription"]
                                                },
                                            ),
                                          ),
                                        ).then(
                                          (value) {
                                            setState(() {});
                                          },
                                        );
                                  },
                                  title: Text(documentSnapshot["todoTitle"]),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        deleteTodos(documentSnapshot["todoTitle"]);
                                      }),
                                ),
                              ));
                        }),
                  );
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
        ],
      ),
    );
  }
}