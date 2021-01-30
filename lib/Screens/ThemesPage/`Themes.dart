import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/ThemesPage/themeChanger.dart';
import 'package:provider/provider.dart';

class ThemesPage extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Page')),
      body: ThemesBody(),
    );
  }
}

class ThemesBody extends StatefulWidget {
  @override
  _ThemeBodyState createState() => _ThemeBodyState();
}

bool isOn = false;

class _ThemeBodyState extends State<ThemesBody> {
  Icon sunIcon = Icon(Icons.wb_sunny);
  Icon moonIcon = Icon(Icons.brightness_3);

  void toggleSwitch(bool value) {
    if (isOn == false) {
      setState(() {
        isOn = true;
      });
    } else {
      setState(() {
        isOn = false;
      });
    }
  }

  @override
  Widget build(context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bright / Dark",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              toggleSwitch(isOn);

              if (!isOn) {
                print("dark Mode OFF");
                themeChanger.setTheme(ThemeData.light());
              } else {
                print("dark Mode ON");
                themeChanger.setTheme(ThemeData.dark());
              }
            },
            leading: isOn ? moonIcon : sunIcon,
            title: Text(isOn ? "Dark Theme" : "Light Theme"),
            // trailing: Switch(value: isOn, onChanged: toggleSwitch),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Colors",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(child: Container(height: 960, child: bringAllColors())),
      ],
    );
  }

  Widget bringAllColors() {
    return Column(
      children: [
        allThemeCicles(Colors.pink),
        allThemeCicles(Colors.red),
        allThemeCicles(Colors.deepOrange),
        allThemeCicles(Colors.orange),
        allThemeCicles(Colors.amber),
        allThemeCicles(Colors.yellow),
        allThemeCicles(Colors.lime),
        allThemeCicles(Colors.lightGreen),
        allThemeCicles(Colors.green),
        allThemeCicles(Colors.teal),
        allThemeCicles(Colors.cyan),
        allThemeCicles(Colors.lightBlue),
        allThemeCicles(Colors.blue),
        allThemeCicles(Colors.indigo),
        allThemeCicles(Colors.purple),
        allThemeCicles(Colors.deepPurple),
        allThemeCicles(Colors.blueGrey),
        allThemeCicles(Colors.brown),
        allThemeCicles(Colors.grey),
      ],
    );
  }

  Widget allThemeCicles(theColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
      child: Row(children: [
        themeCicle(theColor[100]),
        Spacer(),
        themeCicle(theColor[200]),
        Spacer(),
        themeCicle(theColor[300]),
        Spacer(),
        themeCicle(theColor[400]),
        Spacer(),
        themeCicle(theColor[500]),
        Spacer(),
        themeCicle(theColor[600]),
        Spacer(),
        themeCicle(theColor[700]),
        Spacer(),
        themeCicle(theColor[800]),
        Spacer(),
        themeCicle(theColor[900]),
        Spacer(),
      ]),
    );
  }

  Widget themeCicle(aColor) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    return InkWell(
      onTap: () {
        isOn = false;
        themeChanger.setTheme(ThemeData(primaryColor: aColor));
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], color: aColor, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
