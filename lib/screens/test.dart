import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SafeArea(
          child: TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.75,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
