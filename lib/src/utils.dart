import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../leancloud_feedback.dart';
import '../leancloud_feedback.dart';
import '../leancloud_feedback.dart';
import '../leancloud_feedback.dart';
import 'models/send_response.dart';
import 'models/message_response.dart';
import 'models/thread_response.dart';

///This library contains all REST API request functions. e.g., [createFeedback], [fetchAllThreads] and [fetchMessages].
///
///Ensure this is initialized using [init] before calling all request functions.
String _feedbackBaseUrl;

Map<String, String> _headers;

String _get = 'GET';
String _post = 'POST';
String _del = 'DELETE';
String _put = 'PUT';

http.Client _client;

///Initialize using your lean cloud application info.
///
///These fields can be found in lean cloud console -> {your application}
/// -> Settings -> App keys.
void initLCFeedback(
    {@required String appID, @required String appKey, @required serverUrl}) {
  _feedbackBaseUrl = '$serverUrl/feedback';
  _headers = {'X-LC-Id': appID, 'X-LC-Key': appKey};

  _client = http.Client();
}

///Create and send a new feedback message.
///
///This will generate a new feedback thread, contrary to [userAppendMessage] and [devAppendMessage] which sends messages to a exsiting feedback thread.
Future<SendResponse> createFeedback(String content, String contact) async {
  SendResponse sendResponse;
  await _callRestAPI(
    _post,
    _feedbackBaseUrl,
    body: '{"status": "open", "content": "$content","contact" : "$contact"}',
    onResponse: (response) =>
        sendResponse = SendResponse.fromJson(response as Map<String, dynamic>),
  );
  return sendResponse;
}

///Send a message as a user to specified feedback thread.
Future<SendResponse> userAppendMessage(String threadId, String content) async {
  return _appendMessage(threadId, content, 'user');
}

///Send a message as a dev to specified feedback thread.
Future<SendResponse> devAppendMessage(String threadId, String content) async {
  return _appendMessage(threadId, content, 'dev');
}

Future<SendResponse> _appendMessage(
    String threadId, String content, String type) async {
  SendResponse sendResponse;
  await _callRestAPI(
    _post,
    _feedbackBaseUrl + '/$threadId/threads',
    body: '{"type": "$type", "content": "$content", "attachment": ""}',
    onResponse: (response) =>
        sendResponse = SendResponse.fromJson(response as Map<String, dynamic>),
  );
  return sendResponse;
}

///Fetch all feedback threads.
///
///This function will fetch all feedback threads that you received, thus should
///only be used in a console-like application.
Future<List<Thread>> fetchAllThreads() async {
  List<Thread> threadResponse;
  await _callRestAPI(_get, _feedbackBaseUrl,
      onResponse: (response) => threadResponse =
          ThreadResponse.fromJson(response as Map<String, dynamic>).results);
  return threadResponse;
}

///Fetch a feedback thread specified by [threadId].
Future<List<Thread>> fetchSpecThread(String threadId) async {
  List<Thread> threadResponse;
  await _callRestAPI(_get, _feedbackBaseUrl,
      contentType: 'application/x-www-form-urlencoded',
      bodyFields: {'where': '{"objectId":"$threadId"}'},
      onResponse: (response) => threadResponse =
          ThreadResponse.fromJson(response as Map<String, dynamic>).results);
  return threadResponse;
}

///Fetch all messages of this thread.
///
///Contains all conversation content in this thread.
Future<List<Message>> fetchMessages(String threadId) async {
  List<Message> messages;
  await _callRestAPI(_get, _feedbackBaseUrl + '/$threadId/threads',
      onResponse: (response) => messages =
          ConversationResponse.fromJson(response as Map<String, dynamic>)
              .results);
  return messages;
}

Future<bool> delThread(String threadId) async {
  var isDelOK = false;
  await _callRestAPI(
    _del,
    _feedbackBaseUrl + '/$threadId',
    onResponse: (response) => isDelOK = true,
  );
  return isDelOK;
}

extension UpdateStatus on Thread {
  ///Update this thread's status to 'open'.
  Future<bool> open() async {
    return _updateThreadStatus(objectId, 'open');
  }

  ///Update this thread's status to 'close'.
  Future<bool> close() async {
    return _updateThreadStatus(objectId, 'close');
  }
}

Future<bool> _updateThreadStatus(String threadId, String status) async {
  bool updatedSuccess = false;
  await _callRestAPI(
    _put,
    _feedbackBaseUrl + '/$threadId',
    body: '{"status":"$status"}',
    onResponse: (response) {
      updatedSuccess = true;
    },
  );
  return updatedSuccess;
}

///General http request function for all REST API call.
Future<void> _callRestAPI(
  String method,
  String url, {
  String body,
  Map<String, String> bodyFields,
  String contentType = 'application/json',
  void Function(Map response) onResponse,
  void Function(String statusCode) onError,
}) async {
  var request = http.Request(method, Uri.parse(url))
    ..headers.addAll(_headers..addAll({'Content-Type': contentType}));
  if (body != null) {
    request.body = body;
  }
  if (bodyFields != null) {
    request.bodyFields = bodyFields;
  }

  http.StreamedResponse response = await _client.send(request);
  if (response.statusCode == 200 || response.statusCode == 201) {
    onResponse.call(
      jsonDecode(await response.stream.bytesToString()),
    );
  } else {
    onError?.call((response.statusCode.toString()));
  }
}
