import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taploadatgenerator/data.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabló adat kitöltő"),
      ),
      body: ListView.builder(
          itemCount: classlist.length,
          itemBuilder: ((context, index) {
            var data = classlist[index];

            return InkWell(
              onTap: () {
                context.go("/editor/${data['link']}");
              },
              child: Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: Text(data["name"] ?? "ez itt valaki"),
              ),
            );
          })),
    );
  }
}
