class CourseModel {
  String name;
  String content;
  String? photoUrl;
  int distance;
  int duration;
  int id;

  CourseModel({
    required this.name,
    required this.content,
    required this.distance,
    required this.duration,
    required this.id,
    this.photoUrl
  });
}