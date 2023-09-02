import 'package:flutter/material.dart';
import 'package:my_database/database/ToDoDatabase.dart';
import 'package:my_database/database/provider/database_provider.dart';
import 'package:my_database/entity/to_do.dart';
import 'package:my_database/treeview/MyTreeViewDemo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final database =
  //     $FloorToDoDatabase.databaseBuilder("to_do_database.db").build();
  // runApp(MyApp(database));
  runApp(const MyTreeViewDemo());
}

class MyApp extends StatelessWidget {
  const MyApp(Future<ToDoDatabase> database, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ToDoDatabase>(
      future: DatabaseProvider().database,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final database = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              actions: [
                GestureDetector(
                  child: const Icon(Icons.add_to_drive),
                  onTap: () {
                    database.toDoDao
                        .insertToDo(ToDo(1, "task1", "time1", "scheduleTime1"));
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
