import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const QuotesPage(),
    );
  }
}

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> with SingleTickerProviderStateMixin {
  final List<String> quotes = [
    "Jangan menyerah sebelum mencoba.",
    "Kegagalan adalah guru terbaik.",
    "Hidup adalah perjalanan, nikmati prosesnya.",
    "Setiap hari adalah kesempatan baru.",
    "Berani mencoba adalah awal dari keberhasilan.",
    "Kesuksesan dimulai dari langkah pertama."
  ];

  String currentQuote = "Tekan tombol untuk mendapatkan quote!";
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void generateQuote() {
    final random = Random();
    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];
      _controller.forward(from: 0); // restart animation
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  currentQuote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: generateQuote,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Dapatkan Quote Baru'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
