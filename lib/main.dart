import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'adapter/hive_todo_model.dart';
import 'bloc/todo_bloc.dart';
import 'provider/todo_provider.dart';
import 'screens/bloc_todo.dart';
import 'screens/getx_todo.dart';
import 'screens/provider_todo.dart';

// Entry point of the application
void main() async {
  // Ensure that widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Register the HiveTodoModel adapter
  Hive.registerAdapter(HiveTodoModelAdapter());

  // Open the Hive box for storing todos
  await Hive.openBox<HiveTodoModel>('todos');

  // Run the application
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide TodoProvider for the entire app
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        // Provide TodoBloc for the entire app
        BlocProvider(create: (_) => TodoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter State Management Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NavigationPage(),
      ),
    );
  }
}

// Widget for navigation between different state management implementations
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ProviderTodo(),
    const BlocTodo(),
    GetXTodo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Provider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block),
            label: 'Bloc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.get_app),
            label: 'GetX',
          ),
        ],
      ),
    );
  }
}
