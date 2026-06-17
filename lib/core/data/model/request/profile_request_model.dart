class ProfileRequestModel {
  final String name;
  final String email;
  final String? gender;
  final String? ttl;
  final String? avatar;

  ProfileRequestModel({
    required this.name,
    required this.email,
    this.gender,
    this.ttl,
    this.avatar,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      if (gender != null) 'gender': gender!,
      if (ttl != null) 'ttl': ttl!,
      if (avatar != null) 'avatar': avatar!,
    };
  }
}