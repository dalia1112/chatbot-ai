import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime dateTime;
  final bool showDate;

  const ChatItem({
    Key? key,
    required this.text,
    required this.isMe,
    required this.dateTime,
    required this.showDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (showDate) _buildDateSeparator(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ProfileContainer(isMe: isMe),
              SizedBox(width: 10),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft:
                        isMe ? Radius.circular(18) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${_formatTime(dateTime)}',
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMe) ProfileContainer(isMe: isMe),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        '${_formatDate(dateTime)}',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final period = dateTime.hour > 12 ? 'PM' : 'AM';
  final minutes = dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
  return '${hour}:${minutes} $period';
  }
}

class ProfileContainer extends StatelessWidget {
  final bool isMe;

  const ProfileContainer({
    Key? key,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        isMe ? Icons.person : Icons.computer,
        color: Colors.white,
      ),
    );
  }
}





