import 'package:flutter/material.dart';

class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar({Key? key}) : super(key: key);

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  final _formKey = GlobalKey<FormState>();
  final _firstFieldController = TextEditingController();
  final _secondFieldController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  void showSnackBarFun(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: Colors.red,
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // More rounded corners
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );

    // Remove any current SnackBar before showing the new one
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom SnackBar and Form'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Enter first field',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          showSnackBarFun(context,
                              errorMessage += 'First field is empty. ');
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _secondFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Enter second field',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          showSnackBarFun(context,
                              errorMessage += 'Second field is empty. ');
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        errorMessage = '';
                        // Validate the form
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, show a success SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form is valid'),
                            ),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => showSnackBarFun(
                    context, "Yay! A SnackBar has been created"),
                child: const Text("Show SnackBar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
