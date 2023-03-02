class User {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String bannerPicture;
  final String bioDescription;
  final bool isTwitterBlue;
  final List<String>? followers;
  final List<String>? following;
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.bannerPicture,
    required this.bioDescription,
    required this.isTwitterBlue,
    this.followers,
    this.following,
  });


  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profilePicture,
    String? bannerPicture,
    String? bioDescription,
    bool? isTwitterBlue,
    List<String>? followers,
    List<String>? following,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      bannerPicture: bannerPicture ?? this.bannerPicture,
      bioDescription: bioDescription ?? this.bioDescription,
      isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'bannerPicture': bannerPicture,
      'bioDescription': bioDescription,
      'isTwitterBlue': isTwitterBlue,
      'followers': followers,
      'following': following,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['\$id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String,
      bannerPicture: map['bannerPicture'] as String,
      bioDescription: map['bioDescription'] as String,
      isTwitterBlue: map['isTwitterBlue'] as bool,
      followers: map['followers'] != null ? List<String>.from(map['followers']) : null,
      following: map['following'] != null ? List<String>.from(map['following']) : null,
    );
  }

  @override
  String toString() {
    return 'User(\$id: $id, email: $email, name: $name, profilePicture: $profilePicture, bannerPicture: $bannerPicture, bioDescription: $bioDescription, isTwitterBlue: $isTwitterBlue, followers: $followers, following: $following)';
  }
}
