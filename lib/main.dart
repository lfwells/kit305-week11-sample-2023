import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'KIT305 Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.title = "Default Value" //Jordan asked this, how to set a default value for parameter
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children:
          [
            //Hard-coded counter widgets (uncomment *** to use the list of labels below)
            CounterWidget(buttonText: "Hi", onCounterChanged: (value) {
              print("counter 1 was incremented");
              setState(() { counters[0]=value; });
            },),
            CounterWidget(buttonText: "Bye", onCounterChanged: (value) {
              print("counter 2 was incremented");
              setState(() { counters[1]=value; });
            }),
            CounterWidget(buttonText: "huzzah", onCounterChanged: (value) {
              print("counter 3 was incremented");
              setState(() { counters[2]=value; });
            }),

            /*

            *** uncomment this part to see the list of labels used instead of the hard-coded ones above
            uses higher-order functions again (map)

            ...counterLabels.asMap().entries.map((kvp) => CounterWidget(
                buttonText: kvp.value,  onCounterChanged: (value) {
                    setState(() { counters[kvp.key]=value; });
                }),
            ),

            */
          ],
        ),
      ),
    );
  }

  //store the state of the counters here, since we need to calculate the total
  //(note this could be done better, but we ran out of time, DM me for info)
  List<int> counters = [0, 0, 0, 0];

  //using a higher-order function to calculate the total
  int get total => counters.reduce((value, element) => value + element);

  //defining the labels as a list of strings (only used if you comment out *** above)
  List<String> counterLabels = [
    "A Counter", "Another counter", "Wow", "Much Timer"
  ];
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, required this.buttonText, required this.onCounterChanged}) : super(key: key);

  final String buttonText;

  final Function(int) onCounterChanged;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
{
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
      widget.onCounterChanged(counter);
    });
  }

  void _resetCounter() {
    setState(() {
      counter = 0;
      widget.onCounterChanged(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Counter:"),
              Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text(widget.buttonText),//const Icon(Icons.add),
        ),
        OutlinedButton(onPressed: _resetCounter, child: const Text("Reset"))
      ],
    );
  }
}
