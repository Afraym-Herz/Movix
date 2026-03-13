class RatingResponse {
  final int statusCode;
  final String statusMessage;

  RatingResponse({
    required this.statusCode,
    required this.statusMessage,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      statusCode: json['status_code'] ?? 0,
      statusMessage: json['status_message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'status_message': statusMessage,
    };
  }
}
