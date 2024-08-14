class TermModel {
  final int id;
  final String title;
  final String content;
  final bool required;

  TermModel({
    required this.id,
    required this.title,
    required this.content,
    this.required = true,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) {
    return TermModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      required: json['required'],
    );
  }
}