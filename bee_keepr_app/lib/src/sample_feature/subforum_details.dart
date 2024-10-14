import 'package:flutter/material.dart';
import 'subforum.dart';


class SubforumDetails extends StatelessWidget {
  final Subforum subforum;

  const SubforumDetails({Key? key, required this.subforum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subforum.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subforum.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            Text(subforum.description),
            // more details here
          ],
        ),
      ),
    );
  }
}
