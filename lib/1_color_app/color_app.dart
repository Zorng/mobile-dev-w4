import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, green, yellow, blue }

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}


final redCounter = CounterNotifier();
final greenCounter = CounterNotifier();
final yellowCounter = CounterNotifier();
final blueCounter = CounterNotifier();



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int _currentIndex = 0;
  int redTapCount = 0;
  int blueTapCount = 0;

  void _incrementRedTapCount() {
    setState(() {
      redTapCount++;
    });
  }

  void _incrementBlueTapCount() {
    setState(() {
      blueTapCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? ColorTapsScreen(
              redTapCount: redTapCount,
              blueTapCount: blueTapCount,
              onRedTap: _incrementRedTapCount,
              onBlueTap: _incrementBlueTapCount,
            )
          : StatisticsScreenV2(
              // redTapCount: redTapCount,
              // blueTapCount: blueTapCount,
            ),
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
  final int redTapCount;
  final int blueTapCount;
  final VoidCallback onRedTap;
  final VoidCallback onBlueTap;

  const ColorTapsScreen({
    super.key,
    required this.redTapCount,
    required this.blueTapCount,
    required this.onRedTap,
    required this.onBlueTap,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTapV2(counter: redCounter , type:CardType.red),
          ColorTapV2(counter: greenCounter , type:CardType.green),
          ColorTapV2(counter: yellowCounter , type:CardType.yellow),
          ColorTapV2(counter: blueCounter , type:CardType.blue),
          // ColorTap(type: CardType.red, tapCount: redTapCount, onTap: onRedTap),
          // ColorTap(
          //   type: CardType.blue,
          //   tapCount: blueTapCount,
          //   onTap: onBlueTap,
          // ),
        ],
      ),
    );
  }
}

// class ColorTap extends StatelessWidget {
//   final CardType type;
//   final int tapCount;
//   final VoidCallback onTap;

//   const ColorTap({
//     super.key,
//     required this.type,
//     required this.tapCount,
//     required this.onTap,
//   });

//   Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         width: double.infinity,
//         height: 100,
//         child: Center(
//           child: Text(
//             'Taps: $tapCount',
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ColorTapV2 extends StatelessWidget {
  final CounterNotifier counter;
  final CardType type;
  const ColorTapV2({super.key, required this.counter, required this.type});

  Color get backgroundColor => switch(type) {
    == CardType.blue => Colors.blue,
    == CardType.green => Colors.green,
    == CardType.yellow => const Color.fromARGB(255, 227, 207, 20),
    == CardType.red => Colors.redAccent,
    _ => Colors.black // default option required by compiler 
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: counter.increment,
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
            listenable: counter,
            builder: (context, child) {
              return Text(
                'Taps: ${counter.count}',
                style: TextStyle(fontSize: 24, color: Colors.white)
              );
            }
          ),
        ),
      ),
    );
  }
}


// class StatisticsScreen extends StatelessWidget {
//   final int redTapCount;
//   final int blueTapCount;

//   const StatisticsScreen({
//     super.key,
//     required this.redTapCount,
//     required this.blueTapCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Statistics')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Red Taps: $redTapCount', style: TextStyle(fontSize: 24)),
//             Text('Blue Taps: $blueTapCount', style: TextStyle(fontSize: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Strange ... 

class StatisticsScreenV2 extends StatelessWidget {

  const StatisticsScreenV2({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Red Taps: ${redCounter.count}', style: TextStyle(fontSize: 24)),
            Text('Green Taps: ${greenCounter.count}', style: TextStyle(fontSize: 24)),
            Text('Yellow Taps: ${yellowCounter.count}', style: TextStyle(fontSize: 24)),
            Text('Blue Taps: ${blueCounter.count}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
