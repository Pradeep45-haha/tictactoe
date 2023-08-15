import 'package:flutter/material.dart';
import 'package:tictactoe/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: buttonResposiveSize.height,
        maxWidth: buttonResposiveSize.width,
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.purple,
            blurRadius: 8.0,
            spreadRadius: 2.0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: ElevatedButton(

        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          
          elevation: 4.0,
          minimumSize: Size(
            width * .9,
            50,
          ),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
