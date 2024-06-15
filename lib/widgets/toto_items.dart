import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItems({super.key, required this.todo, required this.onToDoChanged, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //print('Tap on task');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone? TextDecoration.lineThrough: null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              //print('delete the task');
              onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
