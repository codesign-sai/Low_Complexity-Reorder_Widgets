import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class NewHome extends StatefulWidget {
  NewHome({Key key, String title}) : super(key: key);

  String get title => null;

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with SingleTickerProviderStateMixin {
  final List<String> items = ['1', '2', '3', '4', '5'];
  final List<String> deletedItems = [];
//initial two tabs
  List<Widget> tabList = [
    Tab(text: 'List', icon: Icon(Icons.list_alt)),
    Tab(text: 'Trash', icon: Icon(Icons.delete)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        //App bar setting
        appBar: AppBar(
          title: Text('Low Complexity - Reorder Widgets'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: tabList,
          ),
        ),
        //body setting
        body: TabBarView(
          children: <Widget>[
            //display original list
            Stack(
              children: [
                ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    setState(
                      () {
                        var child = items.removeAt(oldIndex);
                        items.insert(newIndex, child);
                        //location = newIndex;
                        //print(newIndex);
                      },
                    );
                  },
                  children: getListItems(),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      onPressed: () {
                        //var newCard = items.add(Container();
                        setState(() {
                          //_showItems = true;
                          int newItem = items.length + 1;
                          items.add('$newItem');
                        });
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
            //Display trash list
            Container(
              child: ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  setState(
                    () {
                      var child = deletedItems.removeAt(oldIndex);
                      deletedItems.insert(newIndex, child);
                      //location = newIndex;
                      //print(newIndex);
                    },
                  );
                },
                children: getDeletedListItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

//deleted list view builder
  List<Widget> getDeletedListItems() => deletedItems
      .asMap()
      .map((i, ditem) => MapEntry(i, buildDeletedListTile(ditem, i)))
      .values
      .toList();
//original list view builder
  List<Widget> getListItems() => items
      .asMap()
      .map((i, item) => MapEntry(i, buildListTile(item, i)))
      .values
      .toList();
//custom original list tile
  Widget buildListTile(String item, int index) {
    return Container(
      key: ValueKey(item),
      height: 120,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          //delete icon
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.dangerous),
              iconSize: 25,
              onPressed: () {
                setState(
                  () {
                    deletedItems.add(items[index]);
                    items.remove(items[index]);
                  },
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Widget ' + item,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('-', style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('Location ' + '#$index',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color:
                    Colors.primaries[int.parse(item) % Colors.primaries.length],
                //color: randomColor(),
                borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }

//custom trash's list tile
  Widget buildDeletedListTile(String item, int index) {
    return Container(
      key: ValueKey(item),
      height: 120,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          //redo icon
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.redo),
              iconSize: 25,
              onPressed: () {
                setState(
                  () {
                    items.add(deletedItems[index]);
                    deletedItems.remove(deletedItems[index]);
                  },
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Widget ' + item,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('-', style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('Location ' + '#$index',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color:
                    Colors.primaries[int.parse(item) % Colors.primaries.length],
                //color: randomColor(),
                borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}
