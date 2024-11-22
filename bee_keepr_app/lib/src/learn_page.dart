import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  // Manage the visibility of submenus
  List<dynamic> lessons = [];
  String articleTitle = "Beekeeping School";
  String currentContent = "";

  // Load lessons from json
  Future<void> loadLessons() async {
    final data = await rootBundle.loadString('json/texts.json');
    final jsonData = json.decode(data);
    setState(() {
      lessons = jsonData['lessons'];
    });
  }

  // get lesson completion status
  bool getLessonStatus(int lessonNum, List<Map<String, dynamic>> lessons) {
    for (var lesson in lessons) {
      if (lesson['lessonNumber'] == lessonNum) {
        return lesson['completed'];
      }
    }
    return false;
  }

  // update lesson completion status
  void updateLessonCompletion(
      int lessonNum, bool status, List<Map<String, dynamic>> lessons) {
    for (var lesson in lessons) {
      if (lesson['lessonNumber'] == lessonNum) {
        lesson['completed'] = status;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadLessons();
  }

  void updateTitle(String newTitle) {
    setState(() {
      articleTitle = newTitle;
    });
  }

  void updateLesson(String newTitle, String newContent) {
    setState(() {
      articleTitle = newTitle;
      currentContent = newContent;
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
              child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index];
                    return ExpandableMenuItem(
                      title: "Lesson ${lesson['lessonNumber']}",
                      isExpanded: lesson['isExpanded'] ?? false,
                      onTap: () {
                        updateTitle(lesson['title']);
                        setState(() {
                          lesson['isExpanded'] =
                              !(lesson['isExpanded'] ?? false);
                        });
                      },
                      isCompleted: lesson['completed'] ?? false,
                      onCompletionChanged: (value) {
                        setState(() {
                          lesson['completed'] = value;
                        });
                      },
                      submenu: (lesson['subsections'] as List<dynamic>)
                          .map((sublesson) => MenuItem(
                              title: "Lesson ${sublesson['subsectionNumber']}",
                              isCompleted: sublesson['completed'] ?? false,
                              onCompletionChanged: (value) {
                                setState(() {
                                  sublesson['completed'] = value;
                                });
                              },
                              onTap: () => updateLesson(
                                  sublesson['title'], sublesson['content'])))
                          .toList(),
                    );
                  })),
          // Main content area
          Expanded(
              child: SingleChildScrollView(
                  child: ArticleWidget(
            title: articleTitle,
            content: currentContent,
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
    super.key,
    required this.title,
    required this.content,
    this.imageUrl,
    this.backgroundColor,
    this.titleFontSize = 24.0,
    this.contentFontSize = 16.0,
  });

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
            const SizedBox(height: 8),
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

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isCompleted = false,
    required this.onCompletionChanged,
  }); // ADDED

  @override
  Widget build(BuildContext context) {
    return Row(
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
              style: const TextStyle(color: Colors.white),
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

  const ExpandableMenuItem({
    super.key,
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
              activeColor: Colors.blue,
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
                      style: const TextStyle(color: Colors.white),
                    ),
                    Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
