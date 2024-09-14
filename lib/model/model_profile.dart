class ProfileModel {
  String uid;
  String name;
  String? imageUrl;
  int postCount;
  int followerCount;
  int followingCount;
  String? oneLiner;
  String? drone;
  bool isFollowing;

  ProfileModel({
    required this.uid,
    required this.name,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    this.oneLiner,
    this.drone,
    this.isFollowing = false,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      uid: jsonData['uid'],
      name: jsonData['name'],
      imageUrl: jsonData['image'],
      postCount: jsonData['post_count'] ?? 0,
      followerCount: jsonData['follower_count'] ?? 0,
      followingCount: jsonData['following_count'] ?? 0,
      oneLiner: jsonData['one_liner'],
      drone: jsonData['drone'],
      isFollowing: jsonData['is_following'] ?? false
    );
  }
}

class FollowModel {
  String uid;
  String name;
  String email;
  String? imageUrl;
  String? oneLiner;
  String? drone;
  bool isFollow;

  FollowModel({
    required this.uid,
    required this.name,
    required this.email,
    this.oneLiner,
    this.drone,
    this.imageUrl,
    this.isFollow = false
  });

  factory FollowModel.fromJson(Map<String, dynamic> jsonData, {
    bool isFollow = false
  }) {
    return FollowModel(
      uid: jsonData['uid'],
      name: jsonData['name'],
      email: jsonData['email'],
      imageUrl: jsonData['image'],
      oneLiner: jsonData['one_liner'],
      drone: jsonData['drone'],
      isFollow: isFollow
    );
  }
}
