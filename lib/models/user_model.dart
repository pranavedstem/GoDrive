class ProfileModel {
  final String name;
  final String phone;
  final String email;
  final String username;
  final String profilePicture;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.username,
    required this.profilePicture,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) {
    return ProfileModel(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      profilePicture: data['profilePicture'] ?? '',  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
    };
  }
}
