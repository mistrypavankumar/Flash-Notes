import 'package:flutter/material.dart';

class NotepadScreen extends StatefulWidget {
  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Save",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return null;
          })
        ],
      ),
    );
  }
}
