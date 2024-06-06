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
  List<String> listToDos = [];
  String errorMessage = "";

  final TextEditingController _addToDoTextFieldController =
      TextEditingController();

  void addToDo(String item) {
    setState(() {
      if (listToDos.contains(item)) return;

      listToDos.add(item);
      _addToDoTextFieldController.clear();
      errorMessage = "";
    });
  }

  void _deleteToDo(String item) {
    setState(() {
      listToDos.remove(item);
    });
  }

  void clearError() {
    setState(() {
      errorMessage = "";
    });
  }

  bool _validate() {
    String currToDo = _addToDoTextFieldController.text;

    if (currToDo.isEmpty) {
      setState(() {
        errorMessage = "Please enter a ToDo";
      });

      return false;
    }

    if (listToDos.contains(currToDo)) {
      setState(() {
        errorMessage = "This ToDo already exists";
      });

      return false;
    }

    return true;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addTextField(errorMessage),
          const SizedBox(width: 16),
          _addButton(),
        ],
      ),
    );
  }

  Widget _addTextField(String error) {
    return Expanded(
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: _addToDoTextFieldController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Add a new ToDo",
          errorText: error.isEmpty ? null : error,
        ),
        onChanged: (_) => clearError(),
      ),
    );
  }

  Widget _addButton() {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: () {
          _validate() ? addToDo(_addToDoTextFieldController.text) : null;
        },
        child: const Text("Add"),
      ),
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
