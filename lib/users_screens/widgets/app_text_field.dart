import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool obscure;
  final TextEditingController? controller; // 외부에서 controller 전달 가능

  const AppTextField({
    Key? key, // super.key 대신 Key? key
    required this.label,
    this.obscure = false,
    this.controller,
  }) : super(key: key); // super.key 연결

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // controller 연결
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: widget.obscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
