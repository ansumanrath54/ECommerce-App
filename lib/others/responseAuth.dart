import 'dart:convert';

ResponseAuth responseAuthFromJson(String str) =>
    ResponseAuth.fromJson(json.decode(str));

String responseAuthToJson(ResponseAuth data) => json.encode(data.toJson());

class ResponseAuth {
  ResponseAuth({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
    required this.error,
  });

  final bool status;
  final String message;
  dynamic data;
  final String token;
  dynamic error;

  factory ResponseAuth.fromJson(Map<String, dynamic> json) => ResponseAuth(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    token: json["token"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "token": token,
    "error": error,
  };
}