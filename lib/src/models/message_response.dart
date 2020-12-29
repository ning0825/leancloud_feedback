import 'feedback.dart';

///The model class for [fetchMessages] API.
class ConversationResponse {
  List<Message> results;

  ConversationResponse({this.results});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      ConversationResponse(
        results: (json['results'] as List)
            .map((e) =>
                e == null ? null : Message.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': results,
      };
}

class Message {
  String type;
  String content;
  Feedback feedback;
  String createdAt;
  String updatedAt;
  String objectId;

  Message(
      {this.type,
      this.content,
      this.feedback,
      this.createdAt,
      this.updatedAt,
      this.objectId});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: json['type'] as String,
        content: json['content'] as String,
        feedback: json['feedback'] == null
            ? null
            : Feedback.fromJson(json['feedback'] as Map<String, dynamic>),
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        objectId: json['objectId'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'content': content,
        'feedback': feedback,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'objectId': objectId,
      };
}
