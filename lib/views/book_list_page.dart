import 'dart:convert';

import 'package:book_app/controller/book_controller.dart';
import 'package:book_app/model/book_list_response.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Booklistpage extends StatefulWidget {
  const Booklistpage({super.key});

  @override
  State<Booklistpage> createState() => _BooklistpageState();
}

class _BooklistpageState extends State<Booklistpage> {
  BookController? bookController;
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        child:CircularProgressIndicator() ,
        builder:(context, controller, child)=> Container(
          child: Center(
            child: bookController!.bookList == null
                ? child
                : ListView.builder(
                    itemCount: bookController!.bookList!.books!.length,
                    itemBuilder: (context, index) {
                      final currentBook = bookController!.bookList!.books![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => DetailBookPage(
                                    isbn: currentBook.isbn13!,
                                  )),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    Text(currentBook.subtitle!),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text(currentBook.price!)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
