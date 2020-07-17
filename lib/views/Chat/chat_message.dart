import 'package:flutter/cupertino.dart';
import 'package:socail_network_flutter/views/Chat/MassageMainPage.dart';

class ChatMessage{
  String message;
  MessageType type;
  ChatMessage({@required this.type,@required this.message});
}