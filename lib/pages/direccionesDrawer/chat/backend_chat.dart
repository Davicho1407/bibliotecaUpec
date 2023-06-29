import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> sendMessageToChatGPT(String message) async {
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_API_KEY',
    },
    body:
        '{"messages": [{"role": "system", "content": "You are a helpful assistant."}, {"role": "user", "content": "$message"}]}',
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final replies = jsonResponse['choices'][0]['message']['content'];
    return replies;
  } else {
    throw Exception('Failed to communicate with ChatGPT API');
  }
}
