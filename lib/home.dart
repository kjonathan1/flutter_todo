import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/toto_items.dart';

class Home extends StatefulWidget {

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buidAppBar(),
      body: Stack(
        children: [Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column( children: [
            //dsdfdfdsearchBox(),
            Expanded(
              child: ListView( children: [
                Container(
                  margin: const EdgeInsets.only(top:50, bottom: 20),
                  child: const Text('All ToDos', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                  ),
                  for(ToDo todo in _foundToDo.reversed)
                    ToDoItems(
                      todo: todo, 
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _onDeleteItem,
                    ),
                  
              ],),
            )
                      
        
            ]),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Row(
        //     children:  [
        //       Expanded(
        //         child: Container(
        //           margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //           decoration:  BoxDecoration(
        //             color: Colors.white,
        //             boxShadow: const [
        //               BoxShadow(
        //                 color: Colors.grey, 
        //                 offset: Offset(0.0, 0.0),
        //                 blurRadius: 10.0,
        //                 spreadRadius: 0.0 ),
        //             ],
        //             borderRadius: BorderRadius.circular(10), 
        //           ),
        //           child: TextField(
        //             controller: _todoController,
        //             decoration: const InputDecoration(
        //               hintText: 'Add new Todo',
        //               border: InputBorder.none,
        //             )
        //           )
        //         )
        //       ),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 20, right: 20),
        //         child: ElevatedButton(
        //           onPressed: () {
        //             _addToDoItem(_todoController.text);
        //           },
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.blue[700],
        //             //minimumSize:  Size(60, 50),
        //             elevation: 10
        //           ), 
        //           child: const Text('+', style: TextStyle(fontSize: 40, color: Colors.white),),
        //         ),
        //       )
        //     ],
        //   ),
        // )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children:  [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey, 
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0 ),
                    ],
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add new Todo',
                      border: InputBorder.none,
                    )
                  )
                )
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    //minimumSize:  Size(60, 50),
                    elevation: 10
                  ), 
                  child: const Text('+', style: TextStyle(fontSize: 25, color: Colors.white),),
                ),
              )
            ],
          ),
        )),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
    
  }

  void _onDeleteItem(String id){
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

   void _addToDoItem(String todo){
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String todo){
    List<ToDo> results = [];
    if(todo.isEmpty){
      results = todoList;
    } else {
      results = todoList.where((element) => element.todoText!.toLowerCase().contains(todo.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }



  AppBar _buidAppBar(){
    return AppBar(
        backgroundColor: Colors.grey[100],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            const Icon(Icons.menu, size: 40,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: searchBox(),
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/icon.jpg'))
            )
          ]
        )
      );
  }

  Widget searchBox() {
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                contentPadding:  EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black),             
              ),
            )
            );
  }
}