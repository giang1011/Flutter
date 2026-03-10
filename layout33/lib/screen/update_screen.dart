import 'package:flutter/material.dart';
import '../model/user_model.dart';

class UpdateScreen extends StatefulWidget {

  final User user;

  const UpdateScreen({super.key, required this.user});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.name);
    ageController = TextEditingController(text: widget.user.age.toString());
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("UPDATE ITEM")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Update"),
              onPressed: (){
                setState(() {
                  widget.user.name = nameController.text;
                  widget.user.age = int.parse(ageController.text);
                  widget.user.email = emailController.text;
                });

                Navigator.pop(context,true);
              },
            )

          ],
        ),
      ),
    );
  }
}