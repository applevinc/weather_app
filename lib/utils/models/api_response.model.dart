class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;
  final String? error;

  ApiResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      data: json['data'],
      message: json['message'],
      error: json['error'],
    );
  }
}
