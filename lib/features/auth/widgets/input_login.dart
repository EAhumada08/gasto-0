import 'package:flutter/material.dart';

class Inputlogin extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  const Inputlogin({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<Inputlogin> createState() => _InputloginState();
}

class _InputloginState extends State<Inputlogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: 200,
            child: Text(
              widget.label,
              style: Theme.of(context).primaryTextTheme.labelMedium,
            )),
        SizedBox(
          width: 300,
          child: TextField(
            key: ValueKey(widget.label),
            controller: widget.controller,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  IconData get icon => widget.isPassword ? Icons.lock : Icons.person;
}
