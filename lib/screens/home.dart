import 'package:flutter/material.dart';
import 'package:note_pad/model/notes.dart';
import 'package:note_pad/screens/notepad.dart';
import 'package:note_pad/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'notepad.dart';

class HomeScreenLayout extends StatefulWidget {
  @override
  _HomeScreenLayoutState createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notes> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Notes>();
      updateListView();
    }

    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              expandedHeight: 300,
              backgroundColor: Colors.lightBlueAccent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Flash Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ],
        ),
      ),
      //Navigation drawer --------------->>>>>>>>>>>>>>>>
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              leading: Icon(
                Icons.note,
              ),
              title: Text(
                "Flash Notes",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people,
              ),
              title: Text(
                "Shared notebook",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
              ),
              title: Text(
                "Recycle bin",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Divider(
                thickness: 1.5,
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation ------------------>>>>>>>>>>>>>>>>
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
        color: Colors.lightBlueAccent,
      ),
      //Floating action button --------------->>>>>>>>>>>>>>>>
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotepadScreen(Notes("", " ", 2)),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            title: Text(
              this.noteList[position].title,
            ),
            subtitle: Text(this.noteList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              // navigateToDetail(this.noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Notes note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // void navigateToDetail() {
  //   bool result = Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         NotepadScreen();
  //       },
  //     ),
  //   );

  //   if (result == true) {
  //     updateListView();
  //   }
  // }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Notes>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
