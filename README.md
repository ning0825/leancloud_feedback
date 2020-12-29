# leancloud_feedback

A Flutter package that provides APIs to access lean cloud feedback service, and a widget to display/send messages.



## Usage

1. Import package              
    ```dart
    import 'package:leancloud_feedback/leancloud_feedback.dart';
    ```
2. Initialize   
   Call ``initLCFeedback`` with your ``AppID``, ``AppKey``
   and ``REST API Server URL``, these fields can be found in
   lean cloud console -> {your application} -> Settings -> App keys.

3. Call APIs                   
   Refer to [API Page](https://pub.dev/documentation/leancloud_feedback/latest/leancloud_feedback/leancloud_feedback-library.html).

4. Use ``ConversationWidget``               

    ```dart
    ///[messages]: Contains all messages between `dev` and `user`, you can call [fetchMessages] to get it.
    ///[onSendText]: The callback when user press send button.
    ///[role]: Make message be display on the correct side(left or right). This only accept two values 'dev' and user'.
    const ConversationWidget({this.messages, this.onSendText, this.role = 'user'})
    ```

   


