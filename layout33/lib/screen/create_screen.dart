import 'package:flutter/material.dart';
import '../model/user_model.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("CREATE ITEM")),
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

            Row(
              children: [

                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: (){

                    final user = User(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      email: emailController.text,
                    );

                    Navigator.pop(context,user);
                  },
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )

              ],
            )

          ],
        ),
      ),
    );
  }
}