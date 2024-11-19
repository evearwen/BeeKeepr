import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  // Manage the visibility of submenus
  List<bool> showLesson = [false, false, false];
  String articleTitle = "Overview";

  //saving the completion/non completion-- coded here for now since no database yet
   List<bool> lessonCompletion = [false, false, false, false]; // lessons
  List<List<bool>> subLessonCompletion = [ // sub-lessons
    [false, false], 
    [false, false], 
    [false, false], 
  ];

  void updateTitle(String newTitle) {
    setState(() {
      articleTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFE9AB17),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0),
            child: Text("Lessons",
                style: TextStyle(fontSize: 50, color: Colors.black)),
          )),
      body: Row(
        children: [
          // Vertical menu bar on the left
          Container(
            width: 200,
            color: const Color(0xFFE9AB17),
            child: Column(
              children: [
                MenuItem(
                  title: 'Overview',
                  onTap: () {
                    updateTitle('Overview');
                  },
                  isCompleted: lessonCompletion[0], // Default value
                  // onCompletionChanged: (_) {},
                  onCompletionChanged: (value) { 
                        setState(() {
                          lessonCompletion[0] = value;
                        });
                      },
                ),
                ExpandableMenuItem(
                  title: 'Lesson 1',
                  isExpanded: showLesson[0],
                  onTap: () {
                    updateTitle('Lesson 1');
                    setState(() {
                      showLesson[0] = !showLesson[0];
                    });
                  },
                   isCompleted: lessonCompletion[1], // Default value
                  // onCompletionChanged: (_) {},
                  onCompletionChanged: (value) { 
                        setState(() {
                          lessonCompletion[1] = value;
                        });
                      },
                  submenu: [
                    MenuItem(
                      title: 'Lesson 1.1',
                      isCompleted: subLessonCompletion[0][0], 
                      onCompletionChanged: (value) { 
                        setState(() {
                          subLessonCompletion[0][0] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 1.1'),
                    ),
                    MenuItem(
                      title: 'Lesson 1.2',
                      isCompleted: subLessonCompletion[0][1],
                      onCompletionChanged: (value) {
                        setState(() {
                          subLessonCompletion[0][1] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 1.2'),
                    ),
                  ],
                ),

                 ExpandableMenuItem(
                  title: 'Lesson 2',
                  isExpanded: showLesson[1],
                  onTap: () {
                    updateTitle('Lesson 2');
                    setState(() {
                      showLesson[1] = !showLesson[1];
                    });
                  },
                   isCompleted: lessonCompletion[2], // Default value
                  // onCompletionChanged: (_) {},
                  onCompletionChanged: (value) { 
                        setState(() {
                          lessonCompletion[2] = value;
                        });
                      },
                  submenu: [
                    MenuItem(
                      title: 'Lesson 2.1',
                      isCompleted: subLessonCompletion[1][0], 
                      onCompletionChanged: (value) { 
                        setState(() {
                          subLessonCompletion[1][0] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 2.1'),
                    ),
                    MenuItem(
                      title: 'Lesson 2.2',
                      isCompleted: subLessonCompletion[1][1],
                      onCompletionChanged: (value) {
                        setState(() {
                          subLessonCompletion[1][1] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 2.2'),
                    ),
                  ],
                ),

                 ExpandableMenuItem(
                  title: 'Lesson 3',
                  isExpanded: showLesson[2],
                  onTap: () {
                    updateTitle('Lesson 1');
                    setState(() {
                      showLesson[2] = !showLesson[2];
                    });
                  },
                   isCompleted: lessonCompletion[3], // Default value
                  // onCompletionChanged: (_) {},
                  onCompletionChanged: (value) { 
                        setState(() {
                          lessonCompletion[3] = value;
                        });
                      },
                  submenu: [
                    MenuItem(
                      title: 'Lesson 3.1',
                      isCompleted: subLessonCompletion[2][0], 
                      onCompletionChanged: (value) { 
                        setState(() {
                          subLessonCompletion[2][0] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 3.1'),
                    ),
                    MenuItem(
                      title: 'Lesson 3.2',
                      isCompleted: subLessonCompletion[2][1],
                      onCompletionChanged: (value) {
                        setState(() {
                          subLessonCompletion[2][1] = value;
                        });
                      },
                      onTap: () => updateTitle('Lesson 3.2'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
              child: SingleChildScrollView(
                  child: ArticleWidget(
            title: articleTitle,
            content: '''Scripts.com
Bee Movie
By Jerry Seinfeld

NARRATOR:
(Black screen with text; The sound of buzzing bees can be heard)
According to all known laws
of aviation,
 :
there is no way a bee
should be able to fly.
 :
Its wings are too small to get
its fat little body off the ground.
 :
The bee, of course, flies anyway
 :
because bees don't care
what humans think is impossible.
BARRY BENSON:
(Barry is picking out a shirt)
Yellow, black. Yellow, black.
Yellow, black. Yellow, black.
 :
Ooh, black and yellow!
Let's shake it up a little.''',
            backgroundColor: Colors.lightBlue[50],
          ))),
        ],
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  final String title;
  final String content;
  final String? imageUrl; // Optional image URL
  final Color? backgroundColor; // Optional background color
  final double titleFontSize; // Font size for the title
  final double contentFontSize; // Font size for the content

  const ArticleWidget({
    Key? key,
    required this.title,
    required this.content,
    this.imageUrl,
    this.backgroundColor,
    this.titleFontSize = 24.0,
    this.contentFontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null) Image.network(imageUrl!),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: contentFontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isCompleted; 
  final ValueChanged<bool> onCompletionChanged;

    MenuItem({
    required this.title,
    required this.onTap,
    this.isCompleted = false, 
    required this.onCompletionChanged,
     }); // ADDED



  @override
  Widget build(BuildContext context) {
    return Row(//added checkbox for completion
      children: [
        Checkbox(
          value: isCompleted,
          onChanged: (value) {
            if (value != null) {
              onCompletionChanged(value);
            }
          },
          activeColor: Colors.green,
        ),
        Expanded(
          child: TextButton(
            onPressed: onTap,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}


class ExpandableMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isExpanded;
  final List<MenuItem> submenu;
  final bool isCompleted; 
  final ValueChanged<bool> onCompletionChanged;

  ExpandableMenuItem({
    required this.title,
    required this.onTap,
    required this.isExpanded,
    required this.submenu,
    this.isCompleted = false, 
    required this.onCompletionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row( 
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: (value) {
                if (value != null) {
                  onCompletionChanged(value);
                }
              },
              activeColor: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19.7),
              child: TextButton(
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.arrow_drop_up 
                          : Icons.arrow_drop_down, 
                      color: Colors.white, 
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isExpanded) 
          Column(
            children: submenu
                .map((item) => Padding(
                      padding: const EdgeInsets.only(left: 40.0), 
                      child: item,
                    ))
                .toList(),
          ),
      ],
    );
  }
}
