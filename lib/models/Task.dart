// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

class Task{
  int id;
  String title;
  String description;
  bool isCompleted;
  Task(
  {required this.id,
  required this.title,
  required this.description,
  required this.isCompleted});
  // ignore: non_constant_identifier_names
   Map<String, dynamic>toMap() {
      return{
      'id': id,
      'title':title,
      'description':description,
      'isCompleted':isCompleted? 1:0,
    };
  }
}

