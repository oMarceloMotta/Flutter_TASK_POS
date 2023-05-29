class Task {
  String? id;
  String name;
  bool status;
  String location;

  Task(this.name, this.status, this.location, {this.id});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        location = json['location'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'status': status,
      'location': location,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  static List<Task> listFromJson(Map<String, dynamic>? json) {
    List<Task> tasks = [];

    json?.forEach((key, value) {
      Map<String, dynamic> item = {"id": key, ...value};
      tasks.add(Task.fromJson(item));
    });
    return tasks;
  }
}
