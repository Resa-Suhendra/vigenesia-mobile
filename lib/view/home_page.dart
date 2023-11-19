import 'package:flutter/material.dart';
import 'package:vigenesia/view/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _motivationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello User'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/vigenesia-logo.png'), height: 100,),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/19484515?v=4',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'MOTIVATION',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.deepPurple,
                ),
              ),
              const Text(
                'what\'s your biggest motivation?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
              TextFormField(
                controller: _motivationController,
                decoration: const InputDecoration(
                  hintText: 'Enter your motivation',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  final String motivation = _motivationController.text;
                  print('Motivation: $motivation');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
