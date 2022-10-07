import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Booklistpage extends StatefulWidget {
  const Booklistpage({super.key});

  @override
  State<Booklistpage> createState() => _BooklistpageState();
}

class _BooklistpageState extends State<Booklistpage> {
  fetchBookApi() async {
    var url = Uri.parse('https;//api.itbook.store/1.0/new');
    var response =
        await http.get(url,);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    fetchBookApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalogue"),
      ),
      body: Container(),
    );
  }
}
