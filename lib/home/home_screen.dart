import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_example/home/bloc/gemini_bloc.dart';
import 'package:flutter_gemini_example/home/widgets/chat_item.dart';
import 'package:flutter_gemini_example/widgets/error_screen.dart';

class HomeScreen extends StatelessWidget {
  final textCtr = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gemini Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => GeminiBloc(),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GeminiBloc, GeminiState>(
                  builder: (context, state) {
                    if (state is OnDataReceived) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: context.read<GeminiBloc>().chats.length,
                        itemBuilder: (context, index) => ChatItem(
                            chat: context.read<GeminiBloc>().chats[index]),
                      );
                    } else if (state is OnError) {
                      return CustomErrorWidget(
                          error: state.message,
                          onReload: () {
                            textCtr.text = 'start';
                            _submit(context: context);
                          });
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<GeminiBloc, GeminiState>(
                      builder: (context, state) {
                        return TextField(
                          controller: textCtr,
                          decoration: const InputDecoration(
                              hintText: 'Enter text here'),
                          onSubmitted: (value) {
                            _submit(context: context);
                          },
                        );
                      },
                    ),
                  ),
                  BlocBuilder<GeminiBloc, GeminiState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          _submit(context: context);
                        },
                        icon: const Icon(Icons.send),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit({required BuildContext context}) {
    context.read<GeminiBloc>().add(
          GeminiSubmit(text: textCtr.text),
        );
    textCtr.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
