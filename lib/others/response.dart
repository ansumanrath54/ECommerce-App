import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  bool status;
  String message;
  dynamic data;
  dynamic error;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "error": error,
  };
}