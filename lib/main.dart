import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week10_sample_1/counter_provider.dart';

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
        primarySwatch: Colors.deepOrange,
      ),
      home: ChangeNotifierProvider<CounterProvider>(
        create: (_) => CounterProvider(),
        child: DefaultTabController(
          length: 3,
          initialIndex: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Week 11"),
              /*bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.timer)),
                ],
              ),*/
            ),
            body: TabBarView(children: [
              const MyHomePage(title: 'KIT305 Home Page'),
              TotalTab(),
              TimerTab(),
            ]),
            bottomNavigationBar: Builder(
              builder: (context) {
                return TabBar(
                  tabs: [
                    Tab(text: "Counters"),
                    Tab(text: "Total"),
                    Tab(text: "Timer"),
                  ],
                  labelColor: Theme.of(context).primaryColor,
                );
              }
            )
          )
        ),
      ),
    );
  }
}

class TotalTab extends StatelessWidget {
  const TotalTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer<CounterProvider>(
      builder: (context, counterProvider, _) {
        return Text("Total is: ${counterProvider.total}");
      }
    ));
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
    return Center(
        child: Column(
          children:
          const [
            //Hard-coded counter widgets (uncomment *** to use the list of labels below)
            CounterWidget(buttonText: "Hi", counterIndex: 0),
            CounterWidget(buttonText: "Bye", counterIndex: 1),
            CounterWidget(buttonText: "huzzah", counterIndex: 2),

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
    );
  }

  //defining the labels as a list of strings (only used if you comment out *** above)
  List<String> counterLabels = [
    "A Counter", "Another counter", "Wow", "Much Timer"
  ];
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, required this.buttonText, required this.counterIndex}) : super(key: key);

  final String buttonText;
  final int counterIndex;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
{
  int counter = 0;

  @override
  void initState()
  {
    super.initState();

    var counterProvider = Provider.of<CounterProvider>(context, listen: false);
    counter = counterProvider.counters[widget.counterIndex];
  }

  void _incrementCounter() {
    setState(() {
      counter++;
    });

    var counterProvider = Provider.of<CounterProvider>(context, listen: false);
    counterProvider.setCounter(widget.counterIndex, counter);

  }

  void _resetCounter() {
    setState(() {
      counter = 0;
    });

    var counterProvider = Provider.of<CounterProvider>(context, listen: false);
    counterProvider.setCounter(widget.counterIndex, 0);
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

class TimerTab extends StatefulWidget {
  const TimerTab({Key? key}) : super(key: key);

  @override
  State<TimerTab> createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab>
{
  int timerValue = 0;
  bool timerRunning = false;

  Future _timer() async
  {
    //if (timerRunning) return;

    setState(() => timerRunning = true);

    while(timerRunning)
    {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => timerValue++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("timer: $timerValue"),
        Row(
          children: [
            ElevatedButton(
              child: const Text("Start"),
              onPressed: timerRunning ? null : _timer,
            ),
            ElevatedButton(
              child: const Text("Stop"),
              onPressed: timerRunning ? () => setState(() => timerRunning = false) : null,
            ),
            ElevatedButton(
              child: const Text("Reset"),
              onPressed: () => setState(() => timerValue = 0),
            )
          ],
        )
      ],
    );
  }
}
