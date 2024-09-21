// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './views/home_screen.dart';
import './providers/wishlist_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()), // Add WishlistProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFF8AB6F9), //Color(0xFFCDBCA8)
      ),
      home: const HomeScreen(),
    );
  }
}
