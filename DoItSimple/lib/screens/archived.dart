import 'package:flutter/material.dart';

import 'package:mytodolist/navigator/navigation_bloc.dart';

class Archivedpage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Arquivados",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
