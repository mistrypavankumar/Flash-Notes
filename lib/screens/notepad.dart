import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:note_pad/model/notes.dart';
import 'package:note_pad/utils/database_helper.dart';

class NotepadScreen extends StatefulWidget {
  final Notes note;

  NotepadScreen(this.note);
  @override
  State<StatefulWidget> createState() {
    return _NotepadScreenState(this.note);
  }
}

class _NotepadScreenState extends State<NotepadScreen> {
  DatabaseHelper helper = DatabaseHelper();

  Notes note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NotepadScreenState(this.note);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;
    return WillPopScope(
      onWillPop: () {
        // Write some code to control things, when user press Back navigation button in device navigationBar
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: GestureDetector(
            onTap: () {
              setState(() {
                debugPrint("you clicked me");
                _save();
              });
            },
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Save",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
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
          padding:
              const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
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
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    debugPrint("something is changed");
                  },
                  decoration: InputDecoration(
                    hintText: "Notes",
                    border: InputBorder.none,
                  ),
                  scrollPadding: EdgeInsets.all(20.0),
                  autofocus: true,
                  maxLines: 999999,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomPadding: true,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            color: Colors.lightBlueAccent,
            height: 60,
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
