// TodoModel represents a basic todo item with a title and completion status.
// This model is used for in-memory operations and JSON serialization.
class TodoModel {
  String title;
  bool isDone;

// @param title: The title of the todo item (required)
// @param isDone: The completion status of the todo item (optional, defaults to false)
  TodoModel({required this.title, this.isDone = false});

// Converts the TodoModel object to a JSON-compatible Map
// This is useful for serialization, e.g., when storing data or sending it over the network
// @return A Map containing the todo item's data
  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};

// Creates a TodoModel object from a JSON-compatible Map
// This is useful for deserialization, e.g., when retrieving stored data or receiving it from a network
// @param json: A Map containing the todo item's data
// @return A new TodoModel instance
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      TodoModel(title: json['title'], isDone: json['isDone']);

  @override
  String toString() => 'TodoModel(title: $title, isDone: $isDone)';
}

// TodoDBModel represents a todo item with additional database-specific information.
// This model is used for database operations, including an ID field for unique identification.
class TodoDBModel {
  // It's nullable because it might not be set when creating a new item
  int? id;
  String title;
  bool isDone;

  // @param id: The unique identifier for the todo item (optional)
  // @param title: The title of the todo item (required)
  // @param isDone: The completion status of the todo item (optional, defaults to false)
  TodoDBModel({this.id, required this.title, this.isDone = false});

  // Converts the TodoDBModel object to a Map suitable for database operations
  // This is useful when inserting or updating items in the database
  // @return A Map containing the todo item's data
  Map<String, dynamic> toMap() => {
        'title': title,
        'isDone': isDone
            ? 1
            : 0, // Store boolean as integer in SQLite (1 for true, 0 for false)
      };

  // Creates a TodoDBModel object from a Map retrieved from the database
  // This is useful when querying items from the database
  // @param map: A Map containing the todo item's data as retrieved from the database
  // @return A new TodoDBModel instance
  factory TodoDBModel.fromMap(Map<String, dynamic> map) => TodoDBModel(
        id: map['id'],
        title: map['title'],
        isDone: map['isDone'] ==
            1, // Convert integer to boolean (1 is true, 0 is false)
      );

  /* copyWith is a special method that helps us create a *new* TodoDBModel
     that is a copy of an *existing* TodoDBModel, but with some changes.
     It's like making a photocopy and then writing something different on it. */
  TodoDBModel copyWith({int? id, String? title, bool? isDone}) {
    return TodoDBModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() => 'TodoDBModel(id: $id, title: $title, isDone: $isDone)';
}
