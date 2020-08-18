import 'package:flutter/material.dart';
import 'package:note_pad/screens/notepad.dart';

class HomeScreenLayout extends StatefulWidget {
  @override
  _HomeScreenLayoutState createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  @override
  Widget build(BuildContext context) {
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
      //Floating action button --------------->>>>>>>>>>>>>>>>
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NotepadScreen(),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
