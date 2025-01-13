import 'package:flutter/material.dart';

class CounterStatefulDemo extends StatefulWidget {
  Color buttonColor;
  CounterStatefulDemo({super.key, required this.buttonColor});

  @override
  State<CounterStatefulDemo> createState() => _CounterStatefulDemoState();
    // State<CounterStatefulDemo> stateClassAssociatedWithThisWidget = _CounterStatefulDemoState();
    // return stateClassAssociatedWithThisWidget;
  // }
}

class _CounterStatefulDemoState extends State<CounterStatefulDemo> {

  int counter = 0;

  void increment() {
    if(mounted){
      setState(() {
      counter++;
      });
    }
    print(counter);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.buttonColor,
       child: Icon(Icons.add),
       onPressed: () {
         increment();
       },
      ),
      body: Center(
        child: Text(
          '$counter',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
