import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w10/model/settings/app_settings.dart';
import 'package:mobile_dev_w4/w10/ui/states/settings_state.dart';
import 'package:provider/provider.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  void onSubmit() {
    Navigator.pop<String>(context, _controller.text);
  }

  TextEditingController _controller = TextEditingController();
  int maxCommentLenght = 250;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppSettingsState settingsState = context.watch<AppSettingsState>();
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: settingsState.theme.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              maxLength: maxCommentLenght,
              decoration: const InputDecoration(
                labelText: 'Write a Comment',
                hintText: 'Your thoughts',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length > maxCommentLenght) {
                  return 'Comment is too long';
                }
                return null;
              },
            ),
            FilledButton(
              onPressed: () {
                onSubmit();
              },
              style: FilledButton.styleFrom(
                backgroundColor: settingsState.theme.color,
              ),
              child: Text("Comment"),
            ),
          ],
        ),
      ),
    );
  }
}
