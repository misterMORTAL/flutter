
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Contador';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Contador(),
    );
  }
}

class Contador extends StatefulWidget {
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> with SingleTickerProviderStateMixin {
  int _contar = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void incrementarContador() {
    setState(() {
      _contar = (_contar + 1) % 20;
    });
  }

  void restablecerContador() {
    setState(() {
      _contar = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CUARTO C',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 243, 33),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'CONTADOR EN : $_contar',
              style: TextStyle(fontSize: 35.0, color: Colors.blue),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                _animationController.reset();
                _animationController.forward();
                incrementarContador();
              },
              child: RotationTransition(
                turns: _rotationAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: CircleAvatar(
                    radius: 80.0,
                    child: Image.asset('assets/gibli.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 243, 33, 243),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.restore),
                onPressed: restablecerContador,
                tooltip: 'Restablecer contador',
                color: Colors.white,
              ),
              GestureDetector(
                onTapDown: (details) {
                  _animationController.forward();
                },
                onTapUp: (details) {
                  _animationController.reverse();
                  incrementarContador();
                },
                onTapCancel: () {
                  _animationController.reverse();
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: null,
                    tooltip: 'Incrementar contador',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: incrementarContador,
        tooltip: 'Incrementar contador',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
hola mundo
       

