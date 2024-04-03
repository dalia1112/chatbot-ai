// import 'package:chatbot1/models/chat_model.dart';
// import 'package:chatbot1/models/chats_provider.dart';
// import 'package:chatbot1/screens/Text_and_voice_field.dart';
// import 'package:chatbot1/screens/chat_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer(
//               builder: (context, ref, child) {
//                 final chats = ref.watch(chatsProvider).toList();
//                 return ListView.builder(
//                   itemCount: chats.length,
//                   itemBuilder: (context, index) {
//                     final chat = chats[index];
//                     // Determine whether to show the date separator
//                     final bool showDateSeparator =
//                         _shouldShowDateSeparator(chats, index);
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (showDateSeparator)
//                           _buildDateSeparator(chat.dateTime),
//                         ChatItem(
//                           text: chat.message,
//                           isMe: chat.isMe,
//                           dateTime: chat.dateTime,
//                           showDate: false,
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextAndVoiceField(),
//           ),
//           const SizedBox(height: 15),
//         ],
//       ),
//     );
//   }

//   bool _shouldShowDateSeparator(List<ChatModel> chats, int index) {
//     // If it's the first message, always show the date separator
//     if (index == 0) {
//       return true;
//     }

//     // Get the current message's date
//     final currentDate = chats[index].dateTime;

//     // Get the previous message's date
//     final prevDate = chats[index - 1].dateTime;

//     // Compare if the dates are different
//     return currentDate.year != prevDate.year ||
//         currentDate.month != prevDate.month ||
//         currentDate.day != prevDate.day;
//   }

//   Widget _buildDateSeparator(DateTime dateTime) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       margin: EdgeInsets.all(25),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Divider(
//               color: Color.fromARGB(255, 210, 210, 210),
//               thickness: 1.5,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               _formatDate(dateTime),
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Divider(
//               color: Color.fromARGB(255, 210, 210, 210),
//               thickness: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(DateTime dateTime) {
//     return DateFormat('MMMM dd, yyyy').format(dateTime);
//   }
// }


import 'package:chatbot1/models/chat_model.dart';
import 'package:chatbot1/models/chats_provider.dart';
import 'package:chatbot1/screens/Text_and_voice_field.dart';
import 'package:chatbot1/screens/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).toList();
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    // Determine whether to show the date separator
                    final bool showDateSeparator =
                        _shouldShowDateSeparator(chats, index);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showDateSeparator)
                          _buildDateSeparator(chat.dateTime),
                        ChatItem(
                          text: chat.message,
                          isMe: chat.isMe,
                          dateTime: chat.dateTime,
                          showDate: false,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextAndVoiceField(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  bool _shouldShowDateSeparator(List<ChatModel> chats, int index) {
    // If it's the first message, always show the date separator
    if (index == 0) {
      return true;
    }

    // Get the current message's date
    final currentDate = chats[index].dateTime;

    // Get the previous message's date
    final prevDate = chats[index - 1].dateTime;

    // Compare if the dates are different
    return currentDate.year != prevDate.year ||
        currentDate.month != prevDate.month ||
        currentDate.day != prevDate.day;
  }

  Widget _buildDateSeparator(DateTime dateTime) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 210, 210, 210),
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              _formatDate(dateTime),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 210, 210, 210),
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
