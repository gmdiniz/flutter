import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  updateTitle(value, id) {
    // ignore: deprecated_member_use
    DocumentReference documentReference = Firestore.instance.collection("DoIt Simple").document(id['title']);
    Map <String, String> title = {"todoTitle": value};
    // ignore: deprecated_member_use
    documentReference.updateData({"todoTitle": value});
  }
  
  updateDescription(value, id) {
    // ignore: deprecated_member_use
    DocumentReference documentReference = Firestore.instance.collection("DoIt Simple").document(id['title']);
    Map <String, String> description = {"todoDescription": value};
    // ignore: deprecated_member_use
    documentReference.updateData(description);
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = ModalRoute.of(context).settings.arguments;
    var hintTitleText = (ModalRoute.of(context).settings.arguments as Map)["title"].toString();
    var hintDescriptionText = (ModalRoute.of(context).settings.arguments as Map)["description"].toString();

    if (hintDescriptionText == "") {
      hintDescriptionText = "Insira uma descrição para esta tarefa";
    }


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white10,
        onPressed: () {
          
        },
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage(
                                  'imagens/back-arrow-icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              updateTitle(value, snapshot);
                            },
                            decoration: InputDecoration(
                              hintText: hintTitleText,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 7,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) async {
                          updateDescription(value, snapshot);
                        },
                        decoration: InputDecoration(
                          hintText: hintDescriptionText,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 50,
                    thickness: 0.5,
                    color: Colors.white,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Visibility(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: Color(0xFF86829D), width: 1.5)),
                            child: Image(
                              image: AssetImage('imagens/check_icon2.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                               
                              },
                              decoration: InputDecoration(
                                hintText: "Inserir ToDo",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 