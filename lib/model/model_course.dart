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

  factory CourseModel.fromJson(Map<String, dynamic> jsonData) {
    return CourseModel(
      name: jsonData['name'],
      content: jsonData['content'],
      distance: jsonData['distance'],
      duration: jsonData['duration'],
      id: jsonData['id'],
      photoUrl: jsonData['photo_url']
    );
  }
}