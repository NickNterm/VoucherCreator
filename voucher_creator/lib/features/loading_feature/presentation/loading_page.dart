import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double opacityIcon = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          opacityIcon = 1;
        });
        Future.delayed(Duration(milliseconds: 1000), () {
          Navigator.pushReplacementNamed(context, '/main');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opacityIcon,
          duration: Duration(milliseconds: 500),
          child: Image.asset(
            'assets/image/icon.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
