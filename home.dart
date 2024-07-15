import 'package:flutter/material.dart';

import 'challenge.dart';

class HomeWindow extends StatefulWidget {
  const HomeWindow({super.key});

  @override
  State<HomeWindow> createState() => _HomeWindowState();
}

class _HomeWindowState extends State<HomeWindow> {
  int cindex = 1;
  void tabTapped(int index) {
    setState(() {
      cindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.black,
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
        body: Center(
            child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => {
                    setState(() {
                      Navigator.pop(context);
                    })
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                TextButton(
                    onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SamApp()))
                        },
                    child: const Icon(Icons.arrow_forward))
              ],
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: tabTapped,
          currentIndex: cindex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.golf_course), label: 'Challenge'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        ),
      ),
    );
  }
}
