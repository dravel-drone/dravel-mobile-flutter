class TermData {
  final int id;
  final String title;
  final String content;
  final bool required;

  TermData({
    required this.id,
    required this.title,
    required this.content,
    this.required = true,
  });
}