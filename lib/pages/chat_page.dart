import 'package:chatify/models/chat.dart';
import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                this.widget.chat.title(),
                fontSize: 10,
                primaryAction: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  onPressed: () {

                  },
                ),
                secondaryAction: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
