import 'package:flutter/material.dart';
import 'package:themed_to_do_list/data/models.dart';
import 'package:themed_to_do_list/data/services.dart';

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
  String errorMessage = "";

  final TextEditingController _addToDoTextFieldController =
      TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  void onPressedAdd() {
    final ToDo newToDo = ToDo(title: _addToDoTextFieldController.text);

    _databaseService.addToDo(newToDo);
    _addToDoTextFieldController.clear();

    setState(() {
      errorMessage = "";
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
          _validate() ? onPressedAdd() : null;
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget _list() {
    return StreamBuilder(
      stream: _databaseService.getToDos(),
      builder: (context, snapshot) {
        List toDos = snapshot.data?.docs ?? [];
        if (toDos.isEmpty) {
          return const Center(
              child: Text("Looks like there's nothing for you to do!"));
        }

        return Expanded(
          child: ListView.separated(
            itemCount: toDos.length,
            itemBuilder: (context, index) {
              ToDo currToDo = toDos[index].data();
              String currToDoId = toDos[index].id;

              return _listItem(currToDoId, currToDo);
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        );
      },
    );
  }

  Widget _listItem(String toDoId, ToDo toDo) {
    return ListTile(
      title: Text(toDo.title),
      trailing: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () => _databaseService.deleteToDo(toDoId),
      ),
    );
  }
}
