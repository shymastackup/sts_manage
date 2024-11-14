import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) => Column(
                children: [
                  Text(
                    '${counterProvider.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  if (counterProvider.errorMessage != null) // Show error message if it exists
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        counterProvider.errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32.0, bottom: 20),
            child: Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return FloatingActionButton(
                  onPressed: () => counterProvider.decrement(),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, bottom: 20),
            child: FloatingActionButton(
              onPressed: () => context.read<CounterProvider>().increment(),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}


