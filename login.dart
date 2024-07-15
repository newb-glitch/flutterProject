import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogLog(),
    );
  }
}

class LogLog extends StatefulWidget {
  const LogLog({super.key});

  @override
  State<LogLog> createState() => _LogLogState();
}

class _LogLogState extends State<LogLog> {
  late TextEditingController logController;
  late TextEditingController passwordCont;
  String email = '';
  String password = '';
  String err = '';

  @override
  void initState() {
    super.initState();
    logController = TextEditingController();
    passwordCont = TextEditingController();
  }

  @override
  void dispose() {
    logController.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  void usertry() {
    if (email == "user" && password == "user12") {
      setState(() {
        err = "";
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeWindow()));
    } else {
      setState(() {
        err = "Wrong Email or password :(";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Log-in"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Center(
            child: Column(
              children: [
                const Text("Email: "),
                TextField(
                  controller: logController,
                  onChanged: (value) => {
                    setState(() {
                      email = logController.text;
                    })
                  },
                  onSubmitted: (value) {
                    usertry();
                  },
                ),
                const Text("Password"),
                TextField(
                  controller: passwordCont,
                  onChanged: (value) => {
                    setState(() {
                      password = passwordCont.text;
                    })
                  },
                  onSubmitted: (value) {
                    usertry();
                  },
                ),
                Text(err),
                FloatingActionButton(
                  onPressed: () => {usertry()},
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
