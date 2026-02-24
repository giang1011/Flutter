import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  home: SimpleAPI(),
  debugShowCheckedModeBanner: false,
));

class SimpleAPI extends StatefulWidget {
  @override
  State<SimpleAPI> createState() => _SimpleAPIState();
}

class _SimpleAPIState extends State<SimpleAPI> {
  var data;

  @override
  void initState() {
    super.initState();
    http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'))
      .then((res) {
        if (res.statusCode == 200) {
          setState(() => data = json.decode(res.body));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
        backgroundColor: Colors.purple,
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(' ID: ${data['id']}'),
                  SizedBox(height: 10),
                  Text(' User: ${data['userId']}'),
                  SizedBox(height: 20),
                  Text(' ${data['title']}', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(' ${data['body']}'),
                ],
              ),
            ),
    );
  }
}