import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff7681ff),
      child: const Center(
        child: Image(image: AssetImage("assets/blog.gif")),
      ),
    );
  }
}
