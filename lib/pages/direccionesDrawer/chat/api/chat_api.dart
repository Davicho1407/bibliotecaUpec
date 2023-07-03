// api/chat_api.dart

import 'package:dart_openai/openai.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/chat/api/secrets.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/chat/models/chat_message.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = openAiApiKey;
    OpenAI.organization = openAiOrg;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
