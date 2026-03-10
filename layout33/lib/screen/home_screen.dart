import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'create_screen.dart';
import 'update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<User> users = [
    User(id: 1, name: "Nguyen An", age: 22, email: "an@gmail.com"),
    User(id: 2, name: "Tran Binh", age: 25, email: "binh@gmail.com"),
    User(id: 3, name: "Le Chi", age: 21, email: "chi@gmail.com"),
    User(id: 4, name: "Pham Dung", age: 24, email: "dung@gmail.com"),
  ];

  String searchText = "";

  void deleteUser(int id){
    setState(() {
      users.removeWhere((u) => u.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

    List<User> filtered =
    users.where((u) => u.name.toLowerCase().contains(searchText.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("LIST MANAGEMENT SYSTEM")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateScreen()),
          );

          if(result != null){
            setState(() {
              users.add(result);
            });
          }

        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              children: [
                const Text("Search: "),
                Expanded(
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context,index){

                  final user = filtered[index];

                  return Card(
                    child: ListTile(
                      title: Text("${user.id}. ${user.name}"),
                      subtitle: Text("Age: ${user.age} | ${user.email}"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateScreen(user: user),
                                ),
                              );

                              if(result != null){
                                setState(() {});
                              }

                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: (){

                              showDialog(
                                context: context,
                                builder: (_){

                                  return AlertDialog(
                                    title: const Text("Delete Confirmation"),
                                    content: Text("Delete item ID ${user.id}?"),
                                    actions: [

                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      ),

                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: (){
                                          deleteUser(user.id);
                                          Navigator.pop(context);
                                        },
                                      ),

                                    ],
                                  );

                                },
                              );

                            },
                          )

                        ],
                      ),
                    ),
                  );

                },
              ),
            )

          ],
        ),
      ),
    );
  }
}