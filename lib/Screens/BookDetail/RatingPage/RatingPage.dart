import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double ratingValue = 0;
  bool isEmojiTappped = false;
  List _emojis = [
    '🤮',
    '🤢',
    '😫',
    '😫',
    '😟',
    '😕',
    '🤨',
    '😃',
    '😁',
    '😍',
    '🥰',
  ];

  final textFormFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Rating"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Rate this Book !',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    child: Text(
                      '${_emojis[ratingValue.toInt()]}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Slider(
                    min: 0,
                    max: 10,
                    divisions: 10,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(.3),
                    value: ratingValue,
                    onChanged: (newRating) {
                      print(newRating);
                      setState(() {
                        ratingValue = newRating;
                      });
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(children: [
                    Text('${_emojis[0.toInt()]}'),
                    Spacer(),
                    Text('${_emojis[9.toInt()]}')
                  ]),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 5,
                  controller: textFormFieldController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Review'),
                  cursorColor: Theme.of(context).primaryColor,
                  // The validator receives the text that the user has entered.
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("🚨 Review found empty"),
              content: Text("Please add a review. 😃"),
              actions: [
                RaisedButton(
                  child: Text("i will add !"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                ),
                RaisedButton(
                  child: Text("No Need !"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void popPage() {
    Navigator.pop(context);
  }
}
