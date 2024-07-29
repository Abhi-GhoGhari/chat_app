class TodoModal {
  String id, title;
  bool status;
  int dTime;

  TodoModal(
    this.id,
    this.title,
    this.status,
    this.dTime,
  );
  factory TodoModal.froMap(Map data) => TodoModal(
        data['id'] ?? "000",
        data['title'] ?? "undefined",
        data['status'] ?? "false",
        data['dTime'] ?? "111",
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'status': status,
        'dTime': dTime,
      };
}
