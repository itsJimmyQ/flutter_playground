class ToDo {
  String title;

  ToDo({required this.title});

  ToDo.fromJson(Map<String, dynamic> json) : title = json['title'];

  copyWith({
    String? title,
  }) {
    return ToDo(
      title: title ?? this.title,
    );
  }

  toJson() {
    return {
      'title': title,
    };
  }
}
