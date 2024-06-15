class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

   int  hello(){
    return 1;
  }
  
  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Checked Mail', isDone: true),
      ToDo(id: '2', todoText: 'Morning Exercice', isDone: true),
      ToDo(id: '3', todoText: 'Sport'),
      ToDo(id: '4', todoText: 'Team meaating'),
      ToDo(id: '5', todoText: 'Work on mobile App for 2 hour'),
      ToDo(id: '6', todoText: 'Footing with Devine', isDone: true),
      ToDo(id: '7', todoText: 'Dinner'),
    ];
  }
}