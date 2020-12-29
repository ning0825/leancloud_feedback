import 'package:flutter/material.dart';
import 'package:leancloud_feedback/leancloud_feedback.dart';

///A conversation widget that can display/send messages.
///
///This widget composed of a conversation UI, an input box and a send button,
///just like what you can see in every IM app. You can use this as
///demostration purpose.
class ConversationWidget extends StatefulWidget {
  ///[messages]: Contains all messages between `dev` and `user`, you can call [fetchMessages] to get it.
  ///[onSendText]: The callback when user press send button.
  ///[role]: Make message be display on the correct side(left or right). This only accept two values 'dev' and user'.
  const ConversationWidget({this.messages, this.onSendText, this.role = 'user'})
      : assert(role == 'dev' || role == 'user');

  final List<Message> messages;
  final Function(String) onSendText;
  final String role;

  @override
  _ConversationWidgetState createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  TextEditingController _controller;
  ScrollController _listController;
  FocusNode _node;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _listController = ScrollController();
    _node = FocusNode();
    _node.addListener(() {
      _listController.animateTo(0.0,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  Widget _getMessageContainer(Message message) {
    bool isRole = message.type == widget.role;

    var container = [
      Container(
        constraints: BoxConstraints.loose(Size(300, 1000)),
        padding: EdgeInsets.all(8),
        child: Text(message.content),
        decoration:
            BoxDecoration(color: isRole ? Colors.greenAccent : Colors.white),
      ),
      Icon(
        message.type == 'dev' ? Icons.developer_board : Icons.person,
        size: 50,
        color: Colors.black,
      ),
    ];

    return Row(
      children: isRole ? container : container.reversed.toList(),
      mainAxisAlignment:
          isRole ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            constraints: BoxConstraints.loose(MediaQuery.of(context).size),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              controller: _listController,
              physics: BouncingScrollPhysics(),
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                return _getMessageContainer(
                    widget.messages[widget.messages.length - 1 - index]);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  textAlign: TextAlign.left,
                  scrollPhysics: BouncingScrollPhysics(),
                  controller: _controller,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                  ),
                  cursorColor: Colors.black,
                  focusNode: _node,
                ),
              ),
              SizedBox(width: 10),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.green,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.onSendText(_controller.text);
                  _listController.animateTo(0.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                  _controller.clear();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
