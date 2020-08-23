import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        leading: Icon(
          Icons.text_fields,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.attach_file,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return null;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              autofocus: true,
              keyboardType: TextInputType.multiline,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Notes",
                border: InputBorder.none,
              ),
              scrollPadding: EdgeInsets.all(20.0),
              autofocus: true,
              maxLines: 999999,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: true,
    );
  }
}
