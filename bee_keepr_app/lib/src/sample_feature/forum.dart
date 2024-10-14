

import 'package:flutter/material.dart';
import 'subforum.dart'; 
import 'subforum_details.dart'; 

/// Displays the Forum Page.
class ForumPage extends StatelessWidget {
  static const routeName = '/forum'; 

  //subforums w categories
  final List<Subforum> _generalForums = [
    Subforum(title: 'Community', description: 'Talk about anything.', category: 'General Forums'),
    Subforum(title: 'Questions and Advice', description: 'Discuss beekeeping topics.', category: 'General Forums'),
    Subforum(title: 'National Events', description: 'Advertise national beekeeping events', category: 'General Forums'),
    Subforum(title: 'Advertising', description: 'Advertise beekeeping services and events', category: 'General Forums')
  ];

  final List<Subforum> _regionalForums = [
    Subforum(title: 'Community', description: 'Chat with beekeepers in your area.', category: 'Regional Forums'),
    Subforum(title: 'Regional Events', description: 'Discuss or advertise events in your area', category: 'Regional Forums'),
    Subforum(title: 'Advertising', description: 'Local advertising.', category: 'Regional Forums'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: ListView(
        children: [
          _buildSubforumGroup('General Forums', _generalForums, context),
          _buildSubforumGroup('Regional Forums', _regionalForums, context),
        ],
      ),
    );
  }

  Widget _buildSubforumGroup(String title, List<Subforum> subforums, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
           style: Theme.of(context).textTheme.titleLarge,

          ),
        ),
        ListView.builder(
          shrinkWrap: true, 
          physics: NeverScrollableScrollPhysics(), 
          itemCount: subforums.length,
          itemBuilder: (context, index) {
            final subforum = subforums[index];
            return ListTile(
              title: Text(subforum.title),
              subtitle: Text(subforum.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubforumDetails(subforum: subforum),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}


