import 'package:flutter/material.dart';
import 'package:to_do_list/screens/login.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

   @override //boilerplate
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do List'), backgroundColor: Colors.red),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Welcome to the to do list app",
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "Please log in or sign up to continue",
              textAlign: TextAlign.center,
            ),
                Row( 
                   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        
                                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                                      },
                                      child: const Text('SignUp'),
                                    ),
                    ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Login'),
                )
                  ],
                  
                ),
              ],
            ),
            
 
      ),
    );
  }
}