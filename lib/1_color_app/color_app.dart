import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red(color: Color.fromARGB(255, 244, 67, 54)),
  green(color: Color.fromARGB(255, 76, 175, 80)),
  yellow(color: Color.fromARGB(255, 255, 235, 59)),
  blue(color: Color.fromARGB(255, 33, 150, 243));

  final Color color;
  const CardType({required this.color});
}

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterService {
  static List<Map<CardType, CounterNotifier>> counters = CardType.values
      .map((ct) => {ct: CounterNotifier()})
      .toList();
  static Map<CardType,CounterNotifier> getCounter(CardType ct) {
        return counters.singleWhere((e) => e.keys.first == ct);
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreenV2(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ...CardType.values.map((ct) => ColorTapV2(counter: CounterService.getCounter(ct)))
        ],
      ),
    );
  }
}

class ColorTapV2 extends StatelessWidget {
  final Map<CardType, CounterNotifier> counter;
  const ColorTapV2({super.key, required this.counter});

  Color get backgroundColor => switch (counter.keys.first) {
    == CardType.blue => Colors.blue,
    == CardType.green => Colors.green,
    == CardType.yellow => const Color.fromARGB(255, 227, 207, 20),
    == CardType.red => Colors.redAccent,
    _ => Colors.black, // default option required by compiler
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: counter.values.first.increment,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: ListenableBuilder(
            listenable: counter.values.first,
            builder: (context, child) {
              return Text(
                'Taps: ${counter.values.first.count}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Strange ...

class StatisticsScreenV2 extends StatelessWidget {
  const StatisticsScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...CardType.values.map((ct) => Text(
              'Red Taps: ${CounterService.getCounter(ct).values.first.count}',
              style: TextStyle(fontSize: 24)
            ))
          ],
        ),
      ),
    );
  }
}
