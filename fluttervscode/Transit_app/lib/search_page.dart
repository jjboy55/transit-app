import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                const Text(
                  'Your Route',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 170,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
