import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> _tasks = [
    {"title": "Task 1", "completed": false},
    {"title": "Task 2", "completed": false},
    {"title": "Task 3", "completed": false},
  ];

  List<Map<String, dynamic>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 48.0, left: 24.0, right: 24.0, bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(48.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16.0,
                  offset: Offset(0, 8.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "To-Do List",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchResults = _tasks
                          .where((task) => task["title"]
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.white.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
 Expanded(
  child: ListView.builder(
    itemCount: _searchResults.length,
    itemBuilder: (context, index) {
      bool completed = _searchResults[index]["completed"];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchResults[index]["completed"] = !completed;
                    });
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: completed ? Colors.blue : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 204, 203, 203),
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: completed ? Colors.white : Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Text(
                  _searchResults[index]["title"],
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: completed ? TextDecoration.lineThrough : null,
                    color: completed ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _tasks.remove(_searchResults[index]);
                  _searchResults = _tasks;
                });
              },
            ),
          ],
        ),
      );
    },
  ),
),
        
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(48.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16.0,
                  offset: Offset(0, -8.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "   Enter your important tasks here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_sharp),
                  onPressed: () {
                    setState(() {
                      String taskTitle = _controller.text.trim();
                      if (taskTitle.isNotEmpty) {
                        _tasks.add({"title": taskTitle, "completed": false});
                        _searchResults = _tasks;
                        _controller.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
