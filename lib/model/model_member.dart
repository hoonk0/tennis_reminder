class ModelMember {
  final String id;
  final String memberid;
  final String pw;
  final String name;
  final String phone;
  final String location;
  final String email;
  final bool isAdmin;
  final List<String> favorites;

  // 생성자
  ModelMember({
    required this.id,
    required this.memberid,
    required this.pw,
    required this.name,
    required this.phone,
    required this.location,
    required this.email,
    this.isAdmin = false,
    this.favorites = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberid': memberid,
      'pw': pw,
      'name': name,
      'phone': phone,
      'location': location,
      'email': email,
      'isAdmin': isAdmin,
      'favorites': favorites,
    };
  }

  factory ModelMember.fromJson(Map<String, dynamic> json) {
    return ModelMember(
      id: json['id'],
      memberid: json['memberid'],
      pw: json['pw'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      email: json['email'],
      isAdmin: json['isAdmin'] ?? false,
      favorites: List<String>.from(json['favorites'] ?? []),
    );
  }
}
