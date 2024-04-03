import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    token: 'sk-s329fqujgFkxDclongF9T3BlbkFJENWqfVbKzTnO9nLSnjjJgit ',
  
    

    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(List<String> messages) async {
    try {
      final input = messages.join(' ');
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": input})
      ], maxToken: 300, model: GptTurbo0301ChatModel());

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message!.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  void dispose() {
  

    // _openAI.close();
  }
}
