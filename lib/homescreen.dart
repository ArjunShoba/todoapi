import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapi/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  Todomodel? dataFromAPI;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    try {
      String url = "https://dummyjson.com/todos";
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          dataFromAPI = todomodelFromJson(res.body);
          _isLoading = false;
        });
      } else {
        debugPrint("Failed to load todos. Status code: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching todos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataFromAPI == null
              ? const Center(
                  child: Text("Failed to load data"),
                )
              : ListView.builder(
                  itemCount: dataFromAPI!.todos.length,
                  itemBuilder: (context, index) {
                    final todo = dataFromAPI!.todos[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: ${todo.id}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text("Todo: ${todo.todo}"),
                          const SizedBox(height: 5),
                          Text("Completed: ${todo.completed ? 'Yes' : 'No'}"),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
