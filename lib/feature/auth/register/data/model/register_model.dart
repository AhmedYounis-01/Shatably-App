class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String? userName;
  final String? role;
  final String? phoneNumber;

  RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    this.userName,
    this.role,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'userName': userName,
      'role': role,
      'phoneNumber': phoneNumber,
      // if (role != null) 'role': role,
      // if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };
  }
}

class RegisterResponse {
  final String message;
  final UserData user;

  RegisterResponse({required this.message, required this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      user: UserData.fromJson(json['user']),
    );
  }
}

class UserData {
  final String userName;
  final String email;
  final String role;

  UserData({required this.userName, required this.email, required this.role});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
    );
  }
}
