import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListScreen(),
  ));
}

class ListItem {
  dynamic title;
  dynamic subtitle;

  ListItem(this.title, this.subtitle);
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListItem> items = [];

  TextEditingController newTitleController = TextEditingController();
  TextEditingController newSubtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ))
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newTitleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newSubtitleController,
                  decoration: const InputDecoration(
                    labelText: "Subtitle",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addItem();
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text("Add"),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                ),
                title: Text('${items[index].title}'),
                subtitle: Text('${items[index].subtitle}'),
                trailing: Icon(Icons.arrow_forward_outlined),
                onLongPress: () {
                  _showOptionsDialog(context, index);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text("Edit"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditBottomSheet(context, index);
                },
              ),
              ListTile(
                title: const Text("Delete"),
                onTap: () {
                  Navigator.pop(context);
                  _deleteItem(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditBottomSheet(BuildContext context, int index) {
    TextEditingController titleController =
        TextEditingController(text: items[index].title);
    TextEditingController subtitleController =
        TextEditingController(text: items[index].subtitle);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: "Title", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(
                      labelText: "Subtitle", border: OutlineInputBorder()),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    items[index].title = titleController.text;
                    items[index].subtitle = subtitleController.text;
                  });
                  Navigator.pop(context);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text("Edit Done"),
              ),
              const SizedBox(
                height: 152,
              )
            ],
          ),
        );
      },
    );
  }

  void _addItem() {
    final String title = newTitleController.text;
    final String subtitle = newSubtitleController.text;
    if (title.isNotEmpty && subtitle.isNotEmpty) {
      setState(() {
        items.add(ListItem(title, subtitle));
      });
      newTitleController.clear();
      newSubtitleController.clear();
    }
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
