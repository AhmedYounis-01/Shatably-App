class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class LoginResponse {
  final String token;
  final String expiryDate;
  final String username;

  LoginResponse({
    required this.token,
    required this.expiryDate,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      expiryDate: json['expiryDate'],
      username: json['username'],
    );
  }
}
