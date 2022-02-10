import 'package:flutter/material.dart';
import 'package:rum_logger_client/service/user_service.dart';

class AddNewKeywordsWidget extends StatefulWidget {
  AddNewKeywordsWidget({
    Key? key,
    required this.userService,
  }) : super(key: key);

  final UserService userService;

  @override
  State<AddNewKeywordsWidget> createState() => _AddNewKeywordsWidgetState();
}

class _AddNewKeywordsWidgetState extends State<AddNewKeywordsWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 80.0,
              constraints: BoxConstraints(maxHeight: 80),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: myController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintMaxLines: 3,
                    hintStyle: TextStyle(fontSize: 12.0),
                    hintText:
                        'Syntax: \n category 1: key1; key2 \n category 2: key3; key4',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.orangeAccent; // Use the component's default.
                }),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.black87; // Use the component's default.
                }),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) return Colors.red;
                  return null; // Defer to the widget's default.
                }),
              ),
              onPressed: () {
                var value = myController.text.replaceAll('\n', '|').toString();
                widget.userService.AddNewKeyWordss(value).then((value) => null);
              },
              child: SizedBox(
                  height: 65, child: Center(child: Text('Add new keywords'))),
            ),
          )
        ],
      ),
    );
  }
}
