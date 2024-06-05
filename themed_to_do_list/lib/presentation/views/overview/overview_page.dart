import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _OverviewView();
  }
}

class _OverviewView extends StatefulWidget {
  @override
  State<_OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<_OverviewView> {
  String currToDo = "";
  List<String> listToDos = [];

  final TextEditingController _addToDoTextFieldController =
      TextEditingController();

  void addToDo(String item) {
    setState(() {
      if (listToDos.contains(item)) return;

      listToDos.add(item);
      currToDo = "";
      _addToDoTextFieldController.clear();
    });
  }

  void _deleteToDo(String item) {
    if (!listToDos.contains(item)) return;

    setState(() {
      listToDos.remove(item);
    });
  }

  void onChangedCurrToDo(String value) {
    setState(() {
      currToDo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _list(),
      ],
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _addTextField(),
          const SizedBox(width: 16),
          _addButton(),
        ],
      ),
    );
  }

  Widget _addTextField() {
    return Expanded(
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: _addToDoTextFieldController,
        onChanged: onChangedCurrToDo,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Add a new ToDo",
        ),
      ),
    );
  }

  Widget _addButton() {
    return FilledButton(
      onPressed: () {
        addToDo(currToDo);
      },
      child: const Text("Add"),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: listToDos.length,
        itemBuilder: (context, index) {
          return _listItem(listToDos[index]);
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  Widget _listItem(String item) {
    return ListTile(
      title: Text(item),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline_rounded),
        onPressed: () => _deleteToDo(item),
      ),
    );
  }
}
