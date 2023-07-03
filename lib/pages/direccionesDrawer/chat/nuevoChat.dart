import 'package:flutter/material.dart';

class NuevoChat extends StatelessWidget {
  const NuevoChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nuevo Chat",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.tealAccent,
      ),
      body: ChatBotPage(),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  String response = "";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Color.fromARGB(106, 158, 158, 158),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      border: InputBorder.none),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 213, 176, 65)),
                onPressed: () async {
                  // var res = await sendTextCompletionRequest(_controller.text);
                  // response = res["choices"][0]["text"];
                  // print(response);
                  // setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enviar pregunta',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            Container(
              width: 500,
              child: Text(
                response,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
